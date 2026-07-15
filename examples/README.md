# Mat2Ppt examples

Runnable MATLAB scripts that build small `.pptx` files.

## Setup

```matlab
addpath('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt');  % or your install path
cd('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples');
```

Run any script (each writes next to itself or to a temp folder noted in the file):

| Script | Demonstrates |
|--------|----------------|
| `ex01_hello_title.m` | New presentation, title slide, text, save |
| `ex02_blank_textbox.m` | Blank slide + free textbox |
| `ex03_shapes.m` | Auto-shapes (rectangle, etc.) |
| `ex04_table.m` | Insert table, set cell text (1-based cells) |
| `ex05_picture.m` | Insert image from file |
| `ex06_chart.m` | Column chart from CategoryChartData |
| `ex07_notes_hyperlink.m` | Speaker notes + hyperlink run |
| `ex08_showcase.m` | Multi-slide deck (title, bullets, bullets+image, shapes, table, chart) |
| `ex09_bullets.m` | Title and Content + multi-level bullets |
| `ex10_bullets_and_picture.m` | Bullets (left) + picture (right) |

## Image assets (rockets)

| File | Use |
|------|-----|
| `rocket_starship.jpeg` | Stable name (copy of `Starship.jpeg`) |
| `rocket_starship_launch.jpg` | Stable name (copy of the long `20260709_…jpg`) |
| `Starship.jpeg` / `20260709_….jpg` | Originals you added |
| `6MJLDW7E3FG4VAH2NPHEXT5BUA.avif` | **Not used** — AVIF is not supported by MATLAB `imfinfo` / typical PPT embeds |

Scripts prefer the `rocket_*` names, then fall back to the original filenames.

## Conventions

- **Collection indices are 1-based** (first slide/shape = `1`).
- Lengths use `mat2ppt.util.Inches(...)` (or `Emu`, `Pt`, …).
- Prefer `slide_layouts().get_by_name("Title Slide")` / `"Blank"` / `"Title and Content"`.
- Supported picture types: **JPEG, PNG, GIF, TIFF, BMP** (not AVIF/WebP unless converted).

## User guide (Word)

See **`docs/Mat2Ppt_User_Guide.docx`** for narrative documentation with the same recipes.
