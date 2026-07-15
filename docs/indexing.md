# Indexing in Mat2Ppt

**One rule for MATLAB users: collection indices are 1-based.**

The first slide, shape, layout, table cell (where an index is used), or other
ordered collection item is always index **1**, not 0. This matches normal MATLAB
array indexing and is intentional—even though the upstream library **python-pptx**
uses 0-based indices in Python.

| You want… | Mat2Ppt (MATLAB) | python-pptx (Python) |
|-----------|------------------|----------------------|
| First item | `1` | `0` |
| Second item | `2` | `1` |
| Last of *n* items | `n` | `n - 1` |
| Invalid | `0`, `n+1`, negatives | often `-1` wrap or `IndexError` on bad range |

Conversion used only by maintainers and automated tests:

```text
matlab_index  = python_index + 1
python_index  = matlab_index - 1
```

## What this applies to

Any **public** Mat2Ppt API that:

- Takes a position into a collection (e.g. “the *i*-th slide”, “shape at index *i*”)
- Returns such a position (e.g. “index of this slide in the presentation”)

Examples (illustrative names; exact methods land as the port progresses):

```matlab
% First slide — index 1
slide = prs.slides.item(1);    % or prs.slides(1), depending on the final API shape

% Second shape on that slide
shape = slide.shapes.item(2);
```

Always check the function/class help for the symbol you call; index-taking
methods document **1-based (MATLAB)** explicitly.

## What this does *not* change

| Topic | Behavior |
|-------|----------|
| **`.pptx` files on disk** | Mat2Ppt aims for the same package parts as python-pptx for the same operations. File format indexing (if any) is not “MATLAB-ized.” |
| **Plain MATLAB arrays** | Still 1-based, as always (`a(1)` is the first element). |
| **Loop idioms** | Prefer `for i = 1:n` over `0:n-1`. |
| **Human “slide 1” in PowerPoint UI** | Aligns with Mat2Ppt index 1 for the first slide in the library’s order. |

## Errors

For a collection of length `n`:

- Valid public indices: `1, 2, …, n`
- Invalid: `0`, `n+1`, and negative values (unless a specific API documents otherwise)

Errors use stable `mat2ppt:*` identifiers. Prefer handling the error id in code
rather than parsing message text.

## Relation to python-pptx

Mat2Ppt is a MATLAB port of [python-pptx](https://github.com/scanny/python-pptx)
(v1.0.2). Most public names, argument order, and defaults track that library so
behavior and generated packages stay aligned. **Indexing base is the deliberate
exception** for MATLAB usability: one consistent rule for end users, no mix of
0-based “Python-style” APIs and 1-based MATLAB arrays.

Upstream Python docs and tests that show `slides[0]` mean “first slide”; in
Mat2Ppt that is index `1`.

## For contributors / PRT

- Design reference: project workspace `design.md` §7.4 (A15)
- Port hazard: `prt-port-hazards` → **H-INDEX**
- Gate 3 API probes must convert ±1 when comparing to python-pptx JSON
- Help headers for index APIs must state 1-based and mention the python-pptx contrast

## Status

This document is part of the toolbox from bootstrap so the rule is fixed **before**
slide/shape collection APIs land. Examples will be updated as those APIs ship.
