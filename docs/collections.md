# Collections and indexing

**Indices are 1-based.** The first element is always `1`.

## Access forms (both supported — decision A3)

```matlab
% Canonical in documentation (explicit)
s = prs.slides.item(1);
sh = slide.shapes.item(2);

% Also supported (MATLAB-style alias; same meaning)
s = prs.slides(1);
sh = slide.shapes(2);
```

Both forms are required on every public collection type and must behave the same.
Invalid indices raise `mat2ppt:IndexOutOfRange` with a message that states the
valid range `1…n`.

## Length

```matlab
n = prs.slides.length;   % mirrors len(prs.slides) in python-pptx
```

## Related

- [indexing.md](indexing.md) — why 1-based vs python-pptx 0-based  
- Project design §7.11 (A3)  
