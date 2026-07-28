# Font & paragraph audit — 18_Dropbox_Poverty_Awareness__Display Board Titles Headers

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Title 1 | title | layout | none | 0 |  |
| 1 | Content Placeholder 2 | body:1 | 0.5,1.75,9.0,0.5833 | norm | 0 |  |
| 1 | Rectangle 3 | free | 0.25,2.25,9.5833,1.279 | shape | 1 | cap=none |
| 1 | Rectangle 6 | free | 0.25,3.75,9.5833,1.279 | shape | 1 | cap=none |
| 1 | Rectangle 7 | free | 0.25,5.1667,9.5833,1.279 | shape | 1 | cap=none |
| 2 | Title 1 | title | layout | none | 0 |  |
| 2 | Content Placeholder 2 | body:1 | 0.5,1.75,9.0,0.5833 | norm | 0 |  |
| 2 | Rectangle 3 | free | 0.1667,2.25,9.5833,1.0266 | shape | 1 | cap=none |
| 2 | Rectangle 6 | free | 0.25,3.75,9.5833,1.0266 | shape | 1 | cap=none |
| 2 | Rectangle 7 | free | 0.25,5.1667,9.5833,1.0266 | shape | 1 | cap=none |
| 3 | Title 1 | title | layout | none | 0 |  |
| 3 | Content Placeholder 2 | body:1 | 0.5,1.75,9.0,0.5833 | norm | 0 |  |
| 3 | Rectangle 3 | free | 0.25,2.6667,9.5833,1.0266 | shape | 1 | cap=none |
| 3 | Rectangle 8 | free | 0.1667,4.0,9.5833,1.279 | shape | 1 | cap=none |
| 3 | Rectangle 9 | free | 0.1667,5.5833,9.5833,1.279 | shape | 1 | cap=none |

**Text shapes fingerprinted:** 15

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
