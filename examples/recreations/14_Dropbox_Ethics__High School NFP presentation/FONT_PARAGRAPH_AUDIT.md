# Font & paragraph audit — 14_Dropbox_Ethics__High School NFP presentation

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Rectangle 2 | title | 0.4167,0.3333,8.8333,1.25 | norm | 1 | scheme=bg1; cs=Aharoni |
| 1 | Rectangle 3 | body:1 | 5.1667,2.0,4.4167,4.5 | norm | 3 |  |
| 2 | Rectangle 3 | title | 0.4167,0.3333,9.4167,1.25 | norm | 1 | scheme=bg1; cs=Aharoni |
| 2 | Rectangle 8 | body:1 | 7.0064,1.734,3.0671,5.25 | norm | 5 | scheme=bg1 |
| 3 | Title 1 | title | 0.5417,0.0833,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 3 | Content Placeholder 2 | body:1 | 2.5833,1.533,6.9167,4.5 | no | 5 |  |
| 3 | TextBox 3 | free | 0.25,2.9167,2.0,0.9088 | shape | 1 | cs=Aharoni |
| 4 | Title 1 | title | 0.6875,0.1337,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 4 | Content Placeholder 2 | body:1 | 2.4167,1.75,7.5833,5.75 | norm fs=85000 | 5 |  |
| 4 | TextBox 3 | free | 0.25,2.9167,2.0,1.3127 | shape | 1 | cs=Aharoni |
| 5 | Title 1 | title | 0.6875,0.0833,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 5 | Content Placeholder 2 | body:1 | 2.5833,1.8333,7.25,4.5 | norm | 4 |  |
| 6 | Title 1 | ctrTitle | 0.75,2.4167,8.5,2.7743 | none | 1 | scheme=bg1 |
| 7 | Title 1 | title | 0.6875,0.1337,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 7 | Content Placeholder 2 | body:1 | 2.5,1.5833,7.25,4.9167 | none | 1 |  |
| 8 | Title 1 | title | 0.6875,0.0343,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 8 | Content Placeholder 2 | body:1 | 2.25,1.9167,7.25,4.5 | none | 1 |  |
| 9 | Rectangle 12 | title | 0.6875,0.1918,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 9 | Rectangle 13 | body:1 | 3.25,1.6121,6.0625,4.5 | no | 4 |  |
| 10 | Text Box 6 | free | 4.375,2.3038,1.25,0.3698 | shape | 1 |  |
| 10 | Title 1 | title | 0.4167,0.0833,9.25,1.25 | norm | 1 | scheme=bg1; cs=Aharoni |
| 11 | Text Box 6 | free | 4.375,2.3038,1.25,0.3698 | shape | 1 |  |
| 11 | Text Box 8 | free | 4.2431,4.0382,1.5417,0.5 | shape | 1 |  |
| 11 | Title 1 | title | 0.4167,0.0833,9.25,1.25 | norm | 1 | scheme=bg1; cs=Aharoni |
| 12 | Title 1 | title | 0.6875,0.1605,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 12 | Rectangle 4 | free | 0.0833,5.142,2.4008,2.2551 | shape | 1 | scheme=bg1; cs=Calibri; hlink |
| 12 | TextBox 2 | free | 0.25,2.1667,2.2341,2.4571 | shape | 2 | scheme=bg1 |
| 13 | Title 1 | title | 0.6875,0.1918,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 13 | Content Placeholder 2 | body:1 | 2.6667,2.0833,6.9167,4.9167 | norm | 3 |  |
| 14 | Title 1 | title | 0.6875,0.2176,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 14 | TextBox 6 | free | 0.4011,1.75,1.8333,1.1781 | shape | 1 | scheme=bg1; cs=Calibri |
| 14 | TextBox 2 | free | 0.25,3.5833,2.1667,0.5049 | shape | 1 | scheme=bg1 |
| 15 | Rectangle 2 | title | 0.8097,0.1707,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 15 | Rectangle 3 | body:1 | 3.1972,1.936,5.5,5.1667 | norm | 5 |  |
| 15 | TextBox 8 | free | 3.0,3.4161,6.25,1.3127 | shape | 1 |  |
| 16 | Title 1 | title | 0.6875,0.1085,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 16 | Content Placeholder 2 | body:1 | 2.6667,1.9167,6.4531,4.75 | norm | 1 |  |
| 17 | Title 1 | title | 0.6875,0.0343,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 17 | Content Placeholder 2 | body:1 | 2.5833,1.9167,7.1667,5.4167 | norm fs=92500 | 7 |  |
| 18 | Title 3 | title | 1.0,1.25,8.625,3.1198 | norm | 1 | scheme=bg1; cs=Aharoni |
| 18 | Text Placeholder 4 | body:1 | 0.6667,5.0,9.2083,1.6406 | none | 1 | scheme=tx1 |
| 19 | Title 1 | title | 0.6875,0.0755,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 19 | Content Placeholder 2 | body:1 | 2.6324,1.75,7.3333,4.5 | norm fs=92500 | 6 |  |
| 20 | Title 1 | title | 0.4167,0.0833,9.25,1.25 | none | 1 | scheme=bg1; cs=Aharoni |
| 20 | Content Placeholder 2 | body:1 | 2.25,1.75,7.75,5.6667 | norm fs=92500 | 10 |  |
| 21 | Title 1 | title | 0.5833,0.0833,8.9167,1.25 | norm fs=90000 | 1 | scheme=bg1; cs=Aharoni |
| 21 | Content Placeholder 2 | body:1 | 2.25,1.75,7.5833,5.5 | norm | 3 |  |
| 22 | Rectangle 8 | free | 0.8333,-0.5,9.1422,3.6015 | shape | 1 |  |
| 23 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 23 | Content Placeholder 2 | body:1 | 2.6667,1.9965,6.6458,4.7587 | norm | 1 | cs=Aharoni |
| 24 | Title 1 | title | 0.6875,0.25,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 24 | Content Placeholder 2 | body:1 | 2.5833,1.9965,6.7292,4.7587 | no | 2 |  |
| 25 | Title 1 | title | 1.0,1.8846,8.625,3.1198 | none | 1 | scheme=bg1; cs=Aharoni |
| 25 | Content Placeholder 2 | body:1 | 0.3333,5.0191,9.5,1.6406 | norm | 2 | cs=Calibri |
| 26 | Title 3 | title | 0.1667,0.02,9.6667,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 26 | Content Placeholder 4 | body:1 | 2.25,1.4696,7.5833,6.0104 | norm fs=47500 | 10 |  |
| 27 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 27 | Content Placeholder 2 | body:1 | 2.5833,1.75,7.0,5.3368 | norm | 3 |  |
| 28 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 28 | Content Placeholder 2 | body:1 | 3.0,1.9965,6.3125,4.7587 | norm | 1 |  |
| 29 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 29 | Content Placeholder 2 | body:1 | 3.0,1.9965,6.3125,4.7587 | norm | 1 |  |
| 30 | Title 3 | title | 1.25,1.4167,8.625,3.1198 | norm | 1 | scheme=bg1; cs=Aharoni |
| 30 | Text Placeholder 4 | body:1 | 2.75,5.0191,6.5573,1.6406 | no | 1 | scheme=tx1 |
| 31 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 31 | Content Placeholder 2 | body:1 | 2.9167,1.9167,6.5833,4.5 | norm | 3 |  |
| 32 | Title 1 | title | 0.3333,0.0885,8.9792,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 32 | Content Placeholder 2 | body:1 | 2.5,1.75,7.25,4.75 | no | 3 |  |
| 33 | Title 1 | title | 1.0833,0.02,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 33 | Content Placeholder 2 | body:1 | 2.5833,1.9965,6.7292,5.3368 | norm fs=92500 | 8 |  |
| 34 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 34 | Content Placeholder 2 | body:1 | 3.3333,1.9965,6.0833,4.7587 | norm | 1 |  |
| 35 | Title 1 | title | 0.6875,0.0343,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 35 | Content Placeholder 2 | body:1 | 2.8333,1.9965,6.4792,4.7587 | norm | 1 |  |
| 36 | Title 3 | title | 1.0833,1.3333,8.625,3.1198 | norm | 1 | scheme=bg1; cs=Aharoni |
| 36 | Text Placeholder 4 | body:1 | 0.4167,5.0191,9.2917,1.6406 | no | 1 | scheme=tx1 |
| 37 | Title 3 | title | 0.25,0.02,9.5,1.4497 | none | 1 | scheme=bg1; cs=Aharoni |
| 37 | Content Placeholder 6 | body:1 | layout | none | 0 |  |
| 38 | Rectangle 2 | title | 0.9942,0.0755,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 38 | Rectangle 3 | body:1 | 2.6667,1.8194,7.2917,4.1667 | norm | 4 |  |
| 38 | TextBox 5 | free | 0.0417,3.0833,2.4167,0.4376 | shape | 1 | cs=Calibri |
| 38 | TextBox 6 | free | 0.9942,1.6233,0.7244,0.46 | shape | 1 | scheme=bg1; cs=Calibri |
| 38 | TextBox 9 | free | 0.0417,5.0858,2.4167,0.4376 | shape | 1 | cs=Calibri |
| 38 | TextBox 10 | free | 0.7961,3.7973,1.1206,0.46 | shape | 1 | scheme=bg1; cs=Calibri |
| 38 | TextBox 13 | free | 0.0417,6.9791,2.4167,0.4376 | shape | 1 | cs=Calibri |
| 38 | TextBox 14 | free | 0.9942,5.7067,0.7244,0.46 | shape | 1 | scheme=bg1; cs=Calibri |
| 38 | Rectangle 16 | free | 2.25,6.6105,7.381,0.6395 | shape | 1 | cs=Calibri |
| 39 | Title 1 | title | 0.6875,0.02,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 39 | Content Placeholder 2 | body:1 | 0.6875,1.9965,8.625,5.3368 | norm | 8 |  |
| 40 | Title 1 | title | 0.6875,-0.0429,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 40 | Content Placeholder 2 | body:1 | 2.6667,1.75,7.0833,4.5 | none | 5 |  |
| 40 | Content Placeholder 2 | free | 3.1771,4.064,2.9167,0.5833 | none | 1 |  |
| 40 | Rectangle 8 | free | 2.5,4.456,7.0833,0.7742 | shape | 1 | cs=Calibri |
| 41 | Title 1 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 41 | Content Placeholder 2 | body:1 | 2.511,1.5918,7.489,4.7587 | norm | 7 |  |
| 42 | Title 3 | title | 0.6875,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 42 | Content Placeholder 4 | body:1 | 2.6667,1.9965,6.6458,4.7587 | norm | 1 |  |
| 43 | Title 1 | title | 0.7267,0.1667,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 43 | Content Placeholder 2 | body:1 | 2.6667,1.9965,6.6458,4.7587 | norm | 2 |  |
| 44 | Title 3 | title | 0.7166,0.8403,8.625,3.1198 | norm | 1 | scheme=bg1; cs=Aharoni |
| 44 | Text Placeholder 4 | body:1 | layout | norm | 1 | scheme=tx1 |
| 45 | Title 3 | title | layout | none | 0 |  |
| 45 | Content Placeholder 4 | body:1 | layout | none | 0 |  |
| 46 | Rectangle 2 | title | 0.4167,0.0833,9.5833,1.25 | none | 1 | scheme=bg1; cs=Aharoni |
| 46 | Rectangle 3 | body:1 | 5.2475,1.6225,4.5025,5.0441 | norm | 3 |  |
| 47 | Title 1 | title | layout | none | 1 |  |
| 47 | Content Placeholder 8 | body:1 | 2.8333,1.75,7.1667,4.5 | norm | 2 |  |
| 48 | Title 1 | title | 0.3333,0.0343,9.25,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 48 | Content Placeholder 2 | body:1 | 0.6875,1.5833,8.625,5.9167 | norm | 3 |  |
| 49 | Title 1 | title | 0.7022,0.2156,8.625,1.4497 | norm | 1 | scheme=bg1; cs=Aharoni |
| 49 | Content Placeholder 2 | body:1 | 2.8333,1.8009,6.4792,4.7587 | no | 4 |  |
| 50 | Title 1 | title | layout | none | 1 |  |
| 50 | Content Placeholder 2 | body:1 | 2.5,1.6667,6.75,4.5 | norm | 12 |  |

**Text shapes fingerprinted:** 113

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
