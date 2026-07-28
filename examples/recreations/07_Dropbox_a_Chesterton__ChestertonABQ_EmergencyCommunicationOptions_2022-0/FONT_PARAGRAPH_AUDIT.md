# Font & paragraph audit — 07_Dropbox_a_Chesterton__ChestertonABQ_EmergencyCommunicationOptions_2022-0

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Title 1 | ctrTitle | 1.6667,1.9557,10.0,2.6111 | norm fs=90000 | 1 |  |
| 1 | TextBox 3 | free | 4.1082,4.8354,4.3143,0.9088 | shape | 2 |  |
| 2 | Title 1 | title | layout | norm | 1 |  |
| 2 | Content Placeholder 2 | body:1 | 0.5393,1.2388,12.5453,5.5293 | norm | 11 |  |
| 3 | Title 1 | title | layout | norm | 1 |  |
| 3 | Content Placeholder 2 | body:1 | 0.5393,1.2388,11.7207,5.5293 | norm | 2 |  |
| 4 | Title 1 | title | layout | none | 1 |  |
| 4 | Content Placeholder 2 | body:1 | layout | none | 3 |  |
| 5 | Title 1 | title | layout | none | 1 |  |
| 5 | Content Placeholder 2 | body:1 | layout | none | 1 |  |
| 6 | Title 1 | title | layout | none | 1 |  |
| 6 | Content Placeholder 2 | body:1 | layout | none | 1 |  |

**Text shapes fingerprinted:** 12

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
