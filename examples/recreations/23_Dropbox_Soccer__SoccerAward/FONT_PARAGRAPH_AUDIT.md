# Font & paragraph audit — 23_Dropbox_Soccer__SoccerAward

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Rectangle 2 | ctrTitle | 2.0,2.5833,7.1007,0.75 | none | 0 |  |
| 1 | Rectangle 3 | subTitle:1 | 2.5,3.9931,6.2014,1.3403 | none | 0 |  |

**Text shapes fingerprinted:** 2

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
