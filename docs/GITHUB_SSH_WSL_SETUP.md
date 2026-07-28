# GitHub SSH setup for WSL (Grok / automated pushes)

Reference guide for this machine (`CFam-2025`): generate an SSH key in **WSL**, register it on GitHub, commit, and push **Grok_Mat2Ppt** / **Grok_Mat2Doc**.

**Why this exists:** Grok and many terminal tools run in **WSL**. HTTPS `git push origin` fails there with “could not read Username” because the shell is non-interactive. **Windows Git + Credential Manager** can still push over HTTPS; SSH is the clean long-term fix for WSL.

**Repos involved:**

| Local path | GitHub repo |
|------------|-------------|
| `C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt` | `https://github.com/dmcnm/Grok_Mat2Ppt` |
| `C:\Users\dougl\Repos\MSOffice_Grok\Mat2Doc` | `https://github.com/dmcnm/Grok_Mat2Doc` |

WSL equivalents: `/mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt` and `.../Mat2Doc`.

---

## 1. Prerequisites

- WSL Ubuntu (or similar) with OpenSSH client (`ssh -V` works)
- GitHub account that owns the repos (**dmcnm** for these projects)
- You can open a WSL terminal as your Linux user (e.g. `dougl@CFam-2025`)

---

## 2. Generate an SSH key **in WSL**

Do this **inside WSL**, not only on Windows. The agent uses WSL’s `~/.ssh`.

```bash
# Create key (empty passphrase = good for automation / Grok)
ssh-keygen -t ed25519 -C "douglascoombs@outlook.com" -f ~/.ssh/id_ed25519_github -N ""
```

| Flag | Meaning |
|------|---------|
| `-t ed25519` | Modern key type |
| `-C "..."` | Comment/label (email is fine) |
| `-f ~/.ssh/id_ed25519_github` | Key path |
| `-N ""` | Empty passphrase (no prompt on each use) |

If you set a passphrase instead, you must run `ssh-agent` + `ssh-add` after each login (or unlock once per session).

**Expected files:**

```text
~/.ssh/id_ed25519_github      # private — never paste to chat or GitHub
~/.ssh/id_ed25519_github.pub  # public — add to GitHub only
```

Permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519_github
chmod 644 ~/.ssh/id_ed25519_github.pub
```

---

## 3. SSH config (tell GitHub which key to use)

Create or edit `~/.ssh/config`:

```text
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  IdentitiesOnly yes
```

```bash
chmod 600 ~/.ssh/config
```

`IdentitiesOnly yes` avoids offering random other keys and keeps behavior predictable.

---

## 4. Optional: ssh-agent

With `IdentityFile` set, SSH can use the key **without** an agent. An agent is still useful if you use a passphrase.

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
ssh-add -l   # should list the key
```

Optional auto-start in `~/.bashrc`:

```bash
# GitHub key for non-interactive / Grok-friendly git
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" >/dev/null
  ssh-add ~/.ssh/id_ed25519_github 2>/dev/null
fi
```

---

## 5. GitHub side (required)

Local setup alone is not enough. GitHub must know your **public** key.

1. Show the public key:

   ```bash
   cat ~/.ssh/id_ed25519_github.pub
   ```

2. Sign in to GitHub as **dmcnm** (account that owns the repos).

3. Open: [https://github.com/settings/keys](https://github.com/settings/keys)

4. **New SSH key**
   - **Title:** e.g. `WSL CFam-2025`
   - **Key type:** Authentication Key
   - **Key:** paste the **entire** one-line `.pub` content  
     (starts with `ssh-ed25519`, ends with your email/comment)

5. **Add SSH key**

**Do not** paste the private key file (`id_ed25519_github` without `.pub`).

**Fingerprint check** (optional):

```bash
ssh-keygen -lf ~/.ssh/id_ed25519_github.pub
```

Example fingerprint format: `SHA256:....` — should match what you intend to register.

### Common GitHub pitfalls

| Mistake | Symptom |
|---------|---------|
| Key not added yet | `Permission denied (publickey)` even though SSH “offers” the key |
| Key on a different GitHub user than `dmcnm` | Same denial for these repos |
| Incomplete paste (missing `ssh-ed25519` prefix) | Key rejected or useless |
| Old Windows RSA key on GitHub, new ed25519 used in WSL | Denial until the **ed25519** public key is added |

Note: a Windows file like `dmcnm_PublicKeyPlain.ppk.txt` is a **different** key. WSL will not use it unless you convert and configure it.

---

## 6. Test authentication

```bash
ssh -T git@github.com
```

**Success** looks like:

```text
Hi dmcnm! You've successfully authenticated, but GitHub does not provide shell access.
```

That “does not provide shell access” line is **normal** — not an error.

**Failure** (key not on account or wrong key):

```text
git@github.com: Permission denied (publickey).
```

Debug (see which key is offered):

```bash
ssh -vT git@github.com 2>&1 | grep -E 'Offering|Authentications|Permission|Hi '
```

You want a line like `Offering public key: ... id_ed25519_github ...` and then either success or, if still denied, GitHub does not have that exact public key.

---

## 7. Remotes for these repos

Typical layout (already used on this machine):

```text
origin       https://github.com/dmcnm/Grok_Mat2Ppt.git   # HTTPS
github-ssh   git@github.com:dmcnm/Grok_Mat2Ppt.git       # SSH
```

Same pattern for Mat2Doc with `Grok_Mat2Doc`.

List remotes:

```bash
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt remote -v
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Doc remote -v
```

Add SSH remote if missing:

```bash
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt remote add github-ssh git@github.com:dmcnm/Grok_Mat2Ppt.git
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Doc remote add github-ssh git@github.com:dmcnm/Grok_Mat2Doc.git
```

Optional — make `origin` SSH so plain `git push` works from WSL:

```bash
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt remote set-url origin git@github.com:dmcnm/Grok_Mat2Ppt.git
git -C /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Doc remote set-url origin git@github.com:dmcnm/Grok_Mat2Doc.git
```

---

## 8. Everyday workflow: commit and push

### 8.1 See status

```bash
cd /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt
git status
git log --oneline origin/master..HEAD   # commits not yet on origin (if origin tracks GitHub)
```

### 8.2 Stage and commit

```bash
git add -A   # or specific paths
git status   # review

git commit -m "$(cat <<'EOF'
Short summary of the change

Optional longer explanation.
EOF
)"
```

Or a one-line message:

```bash
git commit -m "Fix: describe the change"
```

### 8.3 Push over SSH (WSL / Grok-friendly)

```bash
git push github-ssh master
```

If `origin` is SSH:

```bash
git push origin master
```

### 8.4 Mat2Doc the same way

```bash
cd /mnt/c/Users/dougl/Repos/MSOffice_Grok/Mat2Doc
git add -A
git commit -m "Describe change"
git push github-ssh master
```

---

## 9. Fallback: Windows Git + HTTPS (Credential Manager)

If SSH is broken but Windows already logged into GitHub:

```bash
"/mnt/c/Program Files/Git/cmd/git.exe" -C "C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt" push origin master
```

This uses **Windows Credential Manager**, not WSL’s SSH keys. It worked when WSL HTTPS could not prompt for a username.

---

## 10. What Grok / automation should use

| Method | When |
|--------|------|
| `git push github-ssh master` from WSL | Preferred once `ssh -T` shows `Hi dmcnm!` |
| Windows `git.exe` + `origin` HTTPS | Fallback if SSH agent/key missing in WSL |

Do **not** rely on interactive `git push` to HTTPS from non-interactive agent sessions.

---

## 11. Troubleshooting cheatsheet

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `Permission denied (publickey)` | Public key not on GitHub (or wrong account) | Add `.pub` under dmcnm → Settings → SSH keys |
| Same, after adding key | Wrong key on GitHub vs file offered | Compare `ssh-keygen -lf ~/.ssh/*.pub` to GitHub UI fingerprint |
| `could not read Username for 'https://github.com'` | HTTPS in non-interactive shell | Use `github-ssh` or Windows git.exe |
| `Could not open a connection to your authentication agent` | No ssh-agent | Optional; key still works via `IdentityFile`, or `eval $(ssh-agent -s)` + `ssh-add` |
| Works in Windows Terminal, fails for Grok | Different environment / no agent | Ensure key + config in **WSL** home `~/.ssh` |

Verbose one-liner:

```bash
ssh -vT git@github.com 2>&1 | grep -E 'Offering|Authentications that can continue|Hi |Permission'
```

Success path ends with authentication; failure often shows **Offering public key** then **Authentications that can continue: publickey** again (GitHub rejected the key).

---

## 12. Quick checklist

- [ ] `ssh-keygen` created `~/.ssh/id_ed25519_github` in **WSL**
- [ ] `~/.ssh/config` points `Host github.com` at that key
- [ ] Public key added on GitHub as **dmcnm**
- [ ] `ssh -T git@github.com` → `Hi dmcnm!`
- [ ] `github-ssh` remote (or SSH `origin`) configured
- [ ] Commit with `git add` / `git commit`
- [ ] Push with `git push github-ssh master`

---

## 13. Security reminders

- Never commit or chat the **private** key.
- Only the **`.pub`** line goes on GitHub.
- Revoke a key on GitHub if a machine is lost; generate a new pair.
- Empty passphrase is convenient for automation; a passphrase is safer on shared laptops.

---

*Document written for Douglas Coombs / CFam-2025 WSL workflow with Grok. Safe to keep in the MSOffice workspace for later reference.*
