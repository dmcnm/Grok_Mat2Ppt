# Font & paragraph audit — 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Title 1 | ctrTitle | layout | norm fs=90000 | 1 |  |
| 1 | Subtitle 2 | subTitle:1 | layout | none | 1 |  |
| 2 | Title 1 | title | layout | norm | 1 |  |
| 2 | Content Placeholder 2 | body:1 | 0.25,1.3333,9.0833,1.4167 | no | 5 |  |
| 3 | Title 1 | title | layout | none | 1 |  |
| 3 | Content Placeholder 2 | body:1 | 0.5,1.5,9.0,1.25 | norm fs=77500 | 3 |  |
| 4 | Title 1 | title | layout | none | 1 |  |
| 4 | Content Placeholder 2 | body:1 | 0.5,1.75,9.0,1.4167 | norm fs=70000 | 2 |  |
| 5 | Title 1 | title | 0.5,0.0833,9.0,1.0 | none | 1 |  |
| 5 | Content Placeholder 2 | body:1 | 0.5,1.0833,9.0833,1.1667 | norm fs=47500 | 3 |  |
| 6 | Title 1 | title | layout | none | 1 |  |
| 6 | Content Placeholder 2 | body:1 | 0.5,1.75,9.25,1.4167 | norm fs=92500 | 1 |  |
| 7 | Title 1 | title | layout | none | 1 |  |
| 7 | Content Placeholder 2 | body:1 | 0.5,1.4167,9.3333,1.8333 | norm fs=55000 | 3 |  |
| 8 | Title 1 | title | layout | norm | 1 |  |
| 8 | Content Placeholder 2 | body:1 | 0.3333,1.4167,9.1667,1.1667 | no | 3 |  |
| 9 | Title 1 | title | 0.478,0.0,9.0,1.25 | none | 1 |  |
| 9 | Content Placeholder 2 | body:1 | 0.4775,1.2253,8.9392,0.7747 | norm | 2 |  |
| 9 | TextBox 10 | free | 7.0833,1.9167,2.3333,0.4712 | shape | 1 |  |
| 9 | TextBox 11 | free | 4.0097,2.0597,2.593,0.2861 | shape | 1 |  |
| 9 | TextBox 12 | free | 0.5162,2.1523,2.593,0.2861 | shape | 1 |  |
| 9 | TextBox 13 | free | 0.521,4.8256,2.593,0.2861 | shape | 1 |  |
| 9 | TextBox 14 | free | 3.8447,4.7686,6.0009,0.4712 | shape | 1 |  |
| 10 | Title 1 | title | layout | none | 1 |  |
| 10 | Content Placeholder 2 | body:1 | 0.4167,1.5833,9.1667,1.1667 | norm | 3 |  |
| 11 | Title 1 | title | layout | none | 1 |  |
| 11 | Content Placeholder 2 | body:1 | 0.25,1.25,9.25,2.0 | norm | 5 |  |
| 12 | Title 1 | title | layout | none | 1 |  |
| 12 | Content Placeholder 2 | body:1 | 0.25,1.25,9.25,2.0 | norm | 6 |  |
| 13 | Title 1 | title | 0.3333,0.1667,9.1667,1.3837 | norm | 1 |  |
| 13 | Content Placeholder 2 | body:1 | 0.3333,1.25,9.3385,1.3333 | norm fs=55000 | 3 |  |
| 13 | Content Placeholder 2 | free | 0.25,2.4167,5.9167,1.9167 | norm fs=55000 | 4 |  |
| 14 | Title 1 | title | layout | none | 1 |  |
| 14 | Content Placeholder 2 | body:1 | 0.5,1.5,8.75,1.75 | norm fs=92500 | 2 |  |
| 15 | Title 1 | title | layout | none | 1 |  |
| 15 | Content Placeholder 2 | body:1 | 0.5,1.5,9.0,1.1667 | norm fs=70000 | 3 |  |
| 16 | Title 1 | title | layout | norm fs=90000 | 1 |  |
| 16 | Content Placeholder 2 | body:1 | 0.1667,1.5833,4.75,5.4167 | norm fs=70000 | 3 |  |
| 17 | Title 1 | title | layout | none | 1 |  |
| 17 | Content Placeholder 2 | body:1 | 0.5,1.75,9.0833,4.4167 | norm fs=85000 | 5 |  |

**Text shapes fingerprinted:** 40

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
