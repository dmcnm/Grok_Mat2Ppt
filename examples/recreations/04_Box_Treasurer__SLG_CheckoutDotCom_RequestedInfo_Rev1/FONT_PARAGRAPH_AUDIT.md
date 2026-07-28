# Font & paragraph audit — 04 (from-scratch rebuild)

## Method

Skill gate `mat2ppt-font-paragraph-audit` + companions.

1. **Extract first:** `extracted/full_fingerprints.json` (group-transformed ABS boxes, per-para `lnSpcPct`, per-run scheme/srgb/hlink, connectors, chrome fills).
2. **Implement from fingerprints only** — `demo.m` rewritten from scratch (not patched from prior demo).
3. **Order:** source_template → box → text structure → font/para per shape → autofit → chrome/images → connectors.
4. **Diff:** machine checks on critical ABS / lnSpc / connectors / hlinks / accent schemes.

## Per-shape map (one row per text box / chrome)

| slide | shape | ph/free | ABS box | autofit | key para/run policy |
|------:|-------|---------|---------|---------|---------------------|
| 1 | Title 1 | ctrTitle | 2.6471×0.9711×9.4314×2.7793 | norm fs=90000 | soft×2 lines |
| 1 | Subtitle 2 | subTitle | 5.5638×4.9309×7.7696×1.7554 | norm | Apple Chancery 24 pt |
| 2 | Title 1 | title | layout | norm fs=90000 | soft×2 + trailing br |
| 2 | body | body | 0.525×1.0263×12.573×6.2201 | norm | listProps **false**; lvl≥1 **accent6**; URL multi-run + hlink |
| 3 | Title 1 | title | 0.1212×0.0505×13.2121×0.9588 | norm | |
| 3 | body note | body | 0.1212×5.02×6.0604×1.6614 | norm fs=92500 lsr=20000 | soft-break; pt=28 |
| 3 | 5× roundRect | free | per fingerprint | none, anchor=ctr | algn=ctr |
| 3 | 6× connectors | cxn | per ends/adj | — | 3× accent2+0.4; 3× default; w=38100; tail triangle lg |
| 4 | Title 1 | title | 0.1212×0.0505×13.2121×0.9588 | norm fs=90000 | soft×1 |
| 4 | body | body | 0.2774×1.0263×5.3249×3.9345 | norm lsr=10000 | listProps false |
| 4 | Donate Now | free | 1.8908×5.1749×2.098×0.7696 | none, ctr | |
| 4 | form panel | free | **6.0925×1.1406×6.5294×6.0297** | — | accent1 +0.8 (group ABS) |
| 4 | form TextBox | free | **6.6947×1.1416×5.9271×6.0287** | spAutoFit | **lnSpc 200k×5 + 250k×3**; soft-break checkbox |
| 4 | rightArrow | free | 4.4706×5.2934×1.0196×0.5328 | — | accent1 +0.8 |
| 5 | Title / body / Donate | … | per fp | … | listProps false |
| 5 | form panel | free | **6.4454×1.6896×6.5294×5.7267** | — | accent1 +0.8 ABS |
| 5 | form TextBox | free | **7.0476×1.6906×5.3249×5.7257** | spAutoFit | lnSpc 200k×7 + 250k×2; bold Project |
| 5 | rightArrow | free | 4.6537×5.834×1.0196×0.5328 | — | accent1 +0.8 |
| 5 | 2× progress groups | free | ABS transformed | — | ellipse+bars+Times New Roman labels |
| 6 | Title / body | … | body box set | none | listProps false |
| 6 | Picture | pic | 5.208×1.0132×7.7775×6.4489 | — | image3.png |
| 7 | Title | title | layout | norm fs=90000 | trailing soft break |
| 7 | body | body | 0.525×1.0263×11.3591×0.7384 | none | |
| 7 | 2 pics | pic | crops per fp | — | image4/5 |
| 8 | body | body | 0.525×1.0263×12.0869×6.2201 | none | multi-run Arial; labels srgb 222222; values accent6; hlinks |
| 9 | body | body | 0.3478×1.0263×12.4953×5.6796 | norm fs=92500 lsr=20000 | URL + email **hlink**; buNone on headers |
| 10 | body | body | layout | none | lvl≥1 accent6 |
| 11 | body | body | layout | none | attached docs accent6 |

## Machine verification (post-rebuild)

| Check | Result |
|-------|--------|
| s4 form panel ABS | **OK** 6.0925, 1.1406 |
| s4 form text ABS + lnSpc 200×5 / 250×3 | **OK** |
| s5 form panel + text ABS + lnSpc | **OK** |
| s5 progress labels (2) | **OK** |
| s3 connectors 6 (3 accent2, 1 straight) | **OK** |
| s2 accent6 answer runs | **OK** (8) |
| s9 hyperlinks ≥2 | **OK** |

**Critical open:** none on gated checks.

## Why this pass differs from prior

| Prior debt | This rebuild |
|------------|--------------|
| Group-local coords used as absolute | ABS = grpOff + (local − chOff) in extract + demo |
| Form lnSpc ignored | Per-para `spcPct` 200000/250000 applied |
| Chrome “added late” without extract | full_fingerprints.json includes all free shapes |
| One patched demo | **demo.m from scratch** from extract |

## Status

Rebuilt from scratch. Open `out_mat2ppt.pptx` and visually check slides **3–5** and **8–9**.
