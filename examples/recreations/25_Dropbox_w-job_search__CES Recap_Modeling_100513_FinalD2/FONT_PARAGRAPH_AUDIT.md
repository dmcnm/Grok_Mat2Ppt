# Font & paragraph audit — 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Rectangle 1 | free | 0.2083,1.3333,9.5833,2.5833 | none | 1 | cs=Lucida Sans Unicode |
| 1 | Title 10 | ctrTitle | 0.1667,1.7889,9.4167,1.7944 | none | 1 | cs=Lucida Sans Unicode |
| 1 | Subtitle 11 | subTitle:1 | 2.5,3.8333,5.0,1.4167 | none | 2 | scheme=tx1; cs=Lucida Sans Unicode |
| 2 | Rectangle 1 | title | 1.4028,0.0625,7.1806,1.1875 | none | 1 |  |
| 2 | Rectangle 2 | body:1 | 0.1667,1.3073,6.0833,5.6094 | none | 7 |  |
| 2 | TextBox 5 | free | 6.0797,5.1667,3.9203,1.0266 | shape | 3 |  |
| 3 | Title 1 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 3 | Content Placeholder 2 | body:1 | 0.25,1.3559,9.5833,5.6684 | none | 6 |  |
| 4 | Title 1 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 4 | Content Placeholder 2 | body:1 | 0.4167,1.5833,6.4167,5.0243 | none | 3 |  |
| 4 | TextBox 4 | free | 0.5,5.1667,6.0833,1.7839 | shape | 1 |  |
| 5 | Title 1 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 5 | Content Placeholder 2 | body:1 | 0.25,1.3559,9.5833,5.6684 | none | 4 |  |
| 6 | Title 1 | title | layout | none | 1 |  |
| 6 | Content Placeholder 2 | body:1 | layout | none | 10 |  |
| 7 | Title 1 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 7 | Content Placeholder 2 | body:1 | 0.5903,1.8333,9.0278,5.191 | none | 9 |  |
| 8 | Title 24 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 8 | Content Placeholder 25 | body:2 | 0.0,1.3333,6.6667,2.1667 | none | 3 |  |
| 8 | TextBox 31 | free | 0.0,4.3333,1.6667,0.7742 | shape | 1 |  |
| 8 | TextBox 32 | free | 0.0,6.25,1.6667,0.7742 | shape | 1 |  |
| 9 | Title 6 | title | 1.0842,0.1927,7.8316,0.8906 | none | 1 |  |
| 9 | Slide Number Placeholder 4 | sldNum:4294967295 | 7.6667,7.1007,2.3333,0.3993 | none | 0 |  |
| 9 | Content Placeholder 20 | free | 5.25,1.4167,4.3333,2.0833 | none | 3 | cs=+mn-cs; cap=none |
| 9 | TextBox 14 | free | 0.3642,2.8114,1.1292,0.4083 | shape | 1 | scheme=accent6 |
| 9 | TextBox 15 | free | 3.2785,3.1048,1.0548,0.7055 | shape | 1 | scheme=accent6 |
| 9 | TextBox 16 | free | 0.4657,4.6673,0.9696,0.4103 | shape | 1 | scheme=accent6 |
| 9 | TextBox 17 | free | 0.25,5.392,1.2922,0.7074 | shape | 1 | scheme=accent6 |
| 9 | TextBox 29 | free | 1.0,1.5,2.9167,0.7742 | shape | 1 |  |
| 9 | TextBox 24 | free | 4.5833,4.1667,4.0,0.4376 | shape | 1 |  |
| 10 | Title 1 | title | layout | none | 1 |  |
| 11 | Rectangle 1 | title | 1.0833,0.1667,7.8333,1.0 | none | 1 |  |
| 11 | Rectangle 2 | body:1 | 0.1667,1.3333,6.3333,5.6701 | none | 16 |  |
| 12 | Rectangle 10 | free | 4.8333,1.5286,5.0,2.3047 | shape | 3 | cs=Arial Unicode MS |
| 12 | Title 13 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 13 | Rectangle 1 | title | 1.0833,0.2951,7.8299,0.7882 | none | 1 |  |
| 13 | Rectangle 2 | body:1 | 3.1667,1.4167,6.6667,5.6667 | none | 7 | cs=Arial |
| 14 | Title 1 | title | layout | none | 1 |  |
| 14 | Content Placeholder 5 | body:2 | 0.0,1.3333,6.8333,2.6667 | none | 4 |  |
| 14 | Text Box 4 | free | 7.8333,1.3333,1.6667,0.3726 | shape | 1 |  |
| 15 | Text Box 1 | free | 1.0833,0.2951,7.8333,0.8924 | none | 1 |  |
| 15 | Text Box 2 | free | 0.0,1.25,5.1667,4.4167 | none | 4 | scheme=accent4 |
| 15 | TextBox 7 | free | 0.1667,6.0,4.75,1.1107 | shape | 3 | scheme=tx1 |
| 16 | Title 1 | title | layout | none | 1 |  |
| 16 | Content Placeholder 2 | body:1 | 0.0,2.0,4.5833,5.0 | none | 5 |  |
| 16 | TextBox 9 | free | 5.5833,1.4167,1.6667,0.7742 | shape | 1 |  |
| 16 | TextBox 10 | free | 8.0,5.8333,1.6667,0.7742 | shape | 1 |  |
| 17 | Title 1 | title | 1.0833,0.25,7.8316,0.8906 | none | 1 |  |
| 17 | Content Placeholder 2 | body:1 | 0.1667,1.3559,5.75,5.6684 | none | 6 |  |
| 18 | Title 1 | title | layout | none | 1 |  |
| 18 | Content Placeholder 2 | body:1 | 0.1667,1.3559,4.8333,5.6684 | none | 4 |  |
| 19 | Title 1 | title | layout | none | 1 |  |
| 19 | TextBox 12 | free | 6.0574,6.2595,3.5,0.7405 | shape | 1 | scheme=tx1 |
| 19 | Content Placeholder 2 | body:1 | 0.0,1.25,5.25,5.7743 | none | 4 |  |
| 19 | TextBox 17 | free | 5.0833,5.7499,4.9167,1.0098 | shape | 1 |  |
| 20 | Title 1 | title | layout | none | 1 |  |
| 20 | Content Placeholder 2 | body:1 | 0.0833,2.1667,4.7708,4.8576 | none | 2 |  |
| 21 | Title 1 | title | layout | none | 1 |  |
| 21 | Content Placeholder 2 | body:1 | layout | none | 9 |  |
| 22 | Title 4 | title | layout | none | 1 |  |
| 22 | Content Placeholder 5 | body:1 | layout | none | 8 |  |
| 23 | Title 1 | title | layout | none | 1 |  |
| 23 | Content Placeholder 2 | body:1 | 0.25,1.3559,9.5833,5.6684 | none | 12 |  |
| 24 | Title 3 | ctrTitle | 0.75,1.4167,8.5,1.6076 | none | 1 |  |
| 25 | Title 1 | title | layout | none | 1 |  |
| 25 | Content Placeholder 2 | body:1 | layout | none | 11 | cs=Lucida Sans Unicode; cs=Arial |
| 26 | Title 1 | title | layout | none | 1 |  |

**Text shapes fingerprinted:** 67

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
