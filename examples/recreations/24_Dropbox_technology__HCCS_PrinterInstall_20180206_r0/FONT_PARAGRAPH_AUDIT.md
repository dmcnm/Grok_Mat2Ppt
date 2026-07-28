# Font & paragraph audit — 24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | Title 1 | ctrTitle | 0.8646,1.2274,11.875,2.6111 | none | 1 |  |
| 1 | Subtitle 2 | subTitle:1 | 1.6667,3.9392,10.0,1.8108 | norm | 2 |  |
| 2 | Title 1 | title | layout | norm fs=90000 | 1 |  |
| 2 | Content Placeholder 2 | body:1 | layout | none | 2 |  |
| 3 | Title 1 | title | layout | norm fs=90000 | 1 |  |
| 3 | Content Placeholder 2 | body:1 | 0.2057,1.3365,12.7422,5.4187 | none | 8 |  |
| 4 | Title 1 | title | 0.5316,0.3993,11.0,0.7213 | norm fs=90000 | 1 |  |
| 4 | Content Placeholder 2 | body:1 | 0.2057,1.3365,12.7422,5.4187 | none | 9 |  |
| 5 | Title 1 | title | 0.5851,0.3993,10.9719,0.7213 | norm fs=90000 | 1 |  |
| 5 | Content Placeholder 2 | body:1 | 0.2057,1.3365,12.7422,5.4187 | none | 3 |  |
| 6 | Title 1 | title | 0.5851,0.3993,11.0351,0.7213 | norm fs=90000 | 1 |  |
| 6 | Content Placeholder 2 | body:1 | 0.2057,1.3365,12.7422,5.4187 | none | 3 |  |
| 7 | Title 1 | title | 0.5851,0.3993,10.9592,0.7213 | norm fs=90000 | 1 |  |
| 7 | Content Placeholder 2 | body:1 | 0.2057,1.3365,12.7422,5.4187 | none | 2 |  |

**Text shapes fingerprinted:** 14

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
