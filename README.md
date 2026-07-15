# Mat2Ppt

MATLAB toolbox that ports **python-pptx v1.0.2** for creating and updating
PowerPoint `.pptx` packages. Target behavior: the same authoring operations
produce package parts equivalent to python-pptx (XML parts byte-identical by
default). Public names track python-pptx; **collection indices are 1-based** in
MATLAB (python-pptx is 0-based).

## Status

Phase 0 bootstrap complete; Phase 1 starting. Product code lands incrementally
by work package under the Grok PRT in `C:\Users\dougl\Grok\MSOffice`.

## Quick start (target API)

```matlab
addpath('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt');  % or install path
prs = mat2ppt.Presentation();           % class at package root (Option C)
% prs = mat2ppt.Presentation("in.pptx");
prs.save("out.pptx");                   % M1: parts match python-pptx
```

`mat2ppt.Presentation` is a **class** (`+mat2ppt/Presentation.m`), not a factory
function. Full authoring APIs land in later work packages.

## Layout

```
+mat2ppt/              Toolbox package (MATLAB)
resources/templates/   Built-in templates (from python-pptx, byte-identical)
tests/                 matlab.unittest suite
docs/                  API / user docs (see docs/indexing.md)
LICENSE, NOTICE        MIT + attribution
```

## Indexing, absent values, and errors

| Topic | Rule | Doc |
|-------|------|-----|
| Collection indices | **1-based** (first item = 1) | [docs/indexing.md](docs/indexing.md) |
| Python `None` (absent) | Pass **`[]` or `missing`** | [docs/absent_and_errors.md](docs/absent_and_errors.md) |
| Failures | `mat2ppt:*` id + helpful message | same |

## Requirements

- MATLAB R2024b+ base (no optional toolboxes)
- No Microsoft Office required to *generate* files (Office used only for verification)

## Reference

- Upstream: https://github.com/scanny/python-pptx (tag v1.0.2)
- Local read-only clone: `C:\Users\dougl\Repos\python-pptx`
- Project workspace: `C:\Users\dougl\Grok\MSOffice`
