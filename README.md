# Mat2Ppt

MATLAB toolbox that ports **python-pptx v1.0.2** for creating and updating
PowerPoint `.pptx` packages. Target behavior: the same authoring operations
produce package parts equivalent to python-pptx (XML parts byte-identical by
default; embedded chart workbooks may use **D-xlsx** structural parity). Public
names track python-pptx; **collection indices are 1-based** in MATLAB
(python-pptx is 0-based).

## Status (campaign)

| Milestone | Result |
|-----------|--------|
| **M1** | Default `Presentation()` open/save L1 **36/36** |
| **M2** | Title slide + textbox “hello world” L1 **38/38** |
| **M3** | Chart matrix structural (column/bar/line/pie) + D-xlsx |
| **Showcase** | 6-slide deck L0 inventory **57/57** vs python-pptx oracle |
| **Suite** | `matlab.unittest` green (see workspace status) |

Parity program / gates: workspace `C:\Users\dougl\Grok\MSOffice` (PRT, trackers, oracles).

## Quick start

```matlab
addpath('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt');
prs = mat2ppt.Presentation();
layout = prs.slide_layouts().get_by_name("Title Slide");
s = prs.slides().add_slide(layout);
s.shapes().item(1).text_frame().text = "Hello";
s.shapes().item(2).text_frame().text = "World";
prs.save("out.pptx");
```

### Charts

```matlab
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);
data = mat2ppt.chart.CategoryChartData();
data.set_categories({"East", "West"});
data.add_series("Sales", [1.2, 2.3]);
s.shapes().add_chart( ...
    mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(5), mat2ppt.util.Inches(4), data);
ch = s.shapes().item(s.shapes().length).chart();  % GraphicFrame.chart
```

`mat2ppt.Presentation` is a **class** (`+mat2ppt/Presentation.m`), not a factory function.

## Layout

```
+mat2ppt/              Toolbox package (MATLAB)
resources/templates/   Built-in templates (from python-pptx, byte-identical)
tests/                 matlab.unittest suite
docs/                  API / user docs
LICENSE, NOTICE        MIT + attribution
RELEASE.md             Campaign release notes
```

## Indexing, absent values, and errors

| Topic | Rule | Doc |
|-------|------|-----|
| Collection indices | **1-based** (first item = 1) | [docs/indexing.md](docs/indexing.md) |
| Collection access | **`.item(k)`** and **`collection(k)`** | [docs/collections.md](docs/collections.md) |
| Python `None` (absent) | Pass **`[]` or `missing`** | [docs/absent_and_errors.md](docs/absent_and_errors.md) |
| Failures | `mat2ppt:*` id + helpful message | same |
| Font metrics | File-based parity when available | [docs/font_metrics.md](docs/font_metrics.md) |

## Requirements

- MATLAB R2024b+ base (no optional toolboxes)
- No Microsoft Office required to *generate* files (Office used only for verification)

## Reference

- Upstream: https://github.com/scanny/python-pptx (tag v1.0.2, pin `278b47b`)
- Local read-only clone: `C:\Users\dougl\Repos\python-pptx`
- Project workspace: `C:\Users\dougl\Grok\MSOffice`
- Product remote: https://github.com/dmcnm/Grok_Mat2Ppt.git
