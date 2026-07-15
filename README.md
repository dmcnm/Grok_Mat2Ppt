# Mat2Ppt

MATLAB toolbox that ports **python-pptx v1.0.2** for creating and updating
PowerPoint `.pptx` packages. Target behavior: the same authoring operations
produce package parts equivalent to python-pptx (XML parts byte-identical by
default). Public names track python-pptx; **collection indices are 1-based** in
MATLAB (python-pptx is 0-based).

## Status

Phase 0 bootstrap. Product code lands incrementally by work package under the
Grok PRT in `C:\Users\dougl\Grok\MSOffice`.

## Layout

```
+mat2ppt/              Toolbox package (MATLAB)
resources/templates/   Built-in templates (from python-pptx, byte-identical)
tests/                 matlab.unittest suite
docs/                  API / user docs (see docs/indexing.md)
LICENSE, NOTICE        MIT + attribution
```

## Indexing

**All Mat2Ppt public collection indices are 1-based** (first item = 1).  
See **[docs/indexing.md](docs/indexing.md)** for the full rule, conversion to
python-pptx’s 0-based API, and what does *not* change (`.pptx` bytes, plain MATLAB arrays).

## Requirements

- MATLAB R2024b+ base (no optional toolboxes)
- No Microsoft Office required to *generate* files (Office used only for verification)

## Reference

- Upstream: https://github.com/scanny/python-pptx (tag v1.0.2)
- Local read-only clone: `C:\Users\dougl\Repos\python-pptx`
- Project workspace: `C:\Users\dougl\Grok\MSOffice`
