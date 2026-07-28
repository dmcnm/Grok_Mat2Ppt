# Font & paragraph audit — 26_Dropbox_w-Sandia__Vibrationdata_download

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | TextBox 10 | free | 2.0,2.7303,8.2905,2.8273 | shape | 4 | hlink |
| 1 | TextBox 11 | free | 2.6662,1.1607,6.465,0.9088 | shape | 2 | scheme=accent5 |
| 3 | TextBox 6 | free | 11.0149,1.4179,1.9851,1.0098 | shape | 1 |  |
| 4 | TextBox 4 | free | 4.597,2.8209,6.2388,1.3127 | shape | 2 |  |

**Text shapes fingerprinted:** 4

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
