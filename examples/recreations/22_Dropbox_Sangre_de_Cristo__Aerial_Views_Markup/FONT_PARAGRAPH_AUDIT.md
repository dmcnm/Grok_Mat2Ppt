# Font & paragraph audit — 22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Rounded Rectangle 4 | free | 2.0751,4.1041,1.3347,0.4167 | none | 1 | scheme=tx1 |
| 1 | Rounded Rectangle 5 | free | 6.83,3.7708,1.3347,0.4167 | none | 1 | scheme=tx1 |
| 2 | Rounded Rectangle 3 | free | 2.9167,3.26,1.3333,0.1667 | none | 1 | scheme=tx1 |
| 2 | Rounded Rectangle 4 | free | 5.25,3.0933,1.3333,0.1667 | none | 1 | scheme=tx1 |
| 2 | Rounded Rectangle 5 | free | 4.5,5.3433,1.8333,0.1667 | none | 1 | scheme=tx1 |
| 3 | Rounded Rectangle 4 | free | 2.4088,4.2708,0.4171,0.3333 | none | 1 | scheme=tx1 |
| 3 | Rounded Rectangle 5 | free | 7.1638,3.7708,0.5005,0.3333 | none | 1 | scheme=tx1 |
| 4 | Rounded Rectangle 3 | free | 4.1667,2.6767,0.4167,0.17 | none | 1 | scheme=tx1 |
| 4 | Rounded Rectangle 4 | free | 5.3333,3.0933,0.4167,0.1667 | none | 1 | scheme=tx1 |
| 4 | Rounded Rectangle 5 | free | 4.4167,5.4267,0.4167,0.1667 | none | 1 | scheme=tx1 |

**Text shapes fingerprinted:** 10

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
