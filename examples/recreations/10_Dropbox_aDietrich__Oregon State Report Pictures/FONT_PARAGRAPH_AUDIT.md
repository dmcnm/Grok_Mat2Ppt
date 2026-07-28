# Font & paragraph audit — 10_Dropbox_aDietrich__Oregon State Report Pictures

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Title 1 | title | layout | none | 0 |  |
| 2 | Title 1 | title | layout | none | 0 |  |
| 3 | Title 1 | title | layout | none | 0 |  |
| 4 | Title 1 | title | layout | none | 0 |  |
| 5 | Title 1 | title | layout | none | 0 |  |
| 6 | Title 1 | title | layout | none | 0 |  |
| 7 | Title 1 | title | layout | none | 0 |  |
| 8 | Title 1 | title | layout | none | 0 |  |
| 9 | Title 1 | title | layout | none | 0 |  |
| 10 | Title 1 | title | layout | none | 0 |  |
| 11 | Title 1 | title | layout | none | 0 |  |
| 12 | Title 1 | title | layout | none | 0 |  |
| 13 | Title 1 | title | layout | none | 0 |  |
| 14 | Title 1 | title | layout | none | 0 |  |
| 14 | TextBox 4 | free | 1.4188,1.647,1.8257,0.4039 | shape | 1 |  |
| 14 | TextBox 5 | free | 6.1714,3.628,2.3515,0.5722 | shape | 1 |  |

**Text shapes fingerprinted:** 16

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
