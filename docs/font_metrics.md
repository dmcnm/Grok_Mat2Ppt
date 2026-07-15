# Font metrics (decision B1)

When Mat2Ppt needs font metrics (ascent, advance widths, etc.) the way
python-pptx does:

| Situation | Behavior |
|-----------|----------|
| **Font file bytes available** (path or test fixture) | Parse the file and match python-pptx as closely as possible |
| **Font file not available** | Use a documented fallback; if `.pptx` XML would differ from python-pptx, record a **deviation (D-number)** — do not silently invent OS fonts |
| **No metrics needed** (pure EMU layout) | Normal L1 package fidelity |

There is **no requirement** to scan `C:\Windows\Fonts` (or similar) for automatic
resolution. Greatest fidelity comes from using the **same font files** as the
script or test under comparison.

See project design §7.12.
