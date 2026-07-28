# Font & paragraph audit — 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Rectangle 1 | free | 0.2083,1.3333,9.5833,2.5833 | none | 1 |  |
| 1 | Title 10 | ctrTitle | 0.1667,1.7889,9.4167,1.7944 | none | 1 | cs=Lucida Sans Unicode |
| 1 | Subtitle 11 | subTitle:1 | 2.1667,3.8333,6.0,1.4167 | none | 2 | scheme=tx1; cs=Lucida Sans Unicode |
| 2 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 2 | Content Placeholder 2 | body:1 | layout | none | 7 |  |
| 3 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 3 | Content Placeholder 2 | body:1 | layout | none | 9 |  |
| 4 | Rectangle 24 | free | 8.5466,3.75,0.9961,1.3127 | shape | 1 | cap=none |
| 4 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 4 | Content Placeholder 2 | body:1 | layout | none | 12 |  |
| 4 | TextBox 13 | free | 0.185,4.0734,1.9664,3.1302 | shape | 2 | scheme=tx1 |
| 4 | TextBox 27 | free | 0.2027,4.0415,2.2362,3.4669 | shape | 2 | scheme=tx1 |
| 4 | TextBox 36 | free | 0.1667,3.9932,2.3807,3.1303 | shape | 2 | scheme=tx1 |
| 5 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 5 | Content Placeholder 2 | body:1 | 0.0833,1.25,9.9167,4.75 | none | 8 |  |
| 5 | TextBox 8 | free | 5.5032,4.9838,2.4167,0.3366 | shape | 1 | scheme=accent1 |
| 6 | Content Placeholder 2 | body:1 | 0.0,1.1858,9.8333,5.8385 | none | 15 |  |
| 6 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 6 | TextBox 3 | free | 7.5847,1.6,1.6667,1.1107 | shape | 1 |  |
| 6 | TextBox 16 | free | 7.6234,2.8185,2.2024,1.1107 | shape | 1 |  |
| 6 | TextBox 18 | free | 7.1666,3.9831,2.8529,1.3127 | shape | 1 |  |
| 7 | Title 1 | title | 1.0833,0.0104,7.8316,1.1754 | none | 1 |  |
| 7 | Content Placeholder 2 | body:1 | 0.0871,1.3183,9.3681,5.6684 | none | 5 |  |
| 8 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 8 | Content Placeholder 2 | body:1 | 0.1849,1.2393,9.4331,5.7851 | none | 4 |  |
| 9 | Title 1 | title | 1.0833,0.0197,7.8316,1.1661 | none | 1 |  |
| 9 | Content Placeholder 2 | body:1 | -0.0097,1.2552,9.5196,0.8906 | none | 2 |  |
| 9 | Content Placeholder 2 | free | -0.0003,1.25,9.4514,1.526 | none | 2 |  |
| 9 | Content Placeholder 2 | free | 0.0,1.25,9.4514,0.8906 | none | 2 |  |
| 10 | Title 1 | title | 1.0833,0.0,7.8316,1.1858 | none | 1 |  |
| 10 | Content Placeholder 2 | body:1 | 0.0833,1.3333,9.8333,5.6684 | none | 12 |  |
| 11 | Title 3 | title | 0.75,3.7468,8.5,1.4896 | none | 1 |  |

**Text shapes fingerprinted:** 32

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
