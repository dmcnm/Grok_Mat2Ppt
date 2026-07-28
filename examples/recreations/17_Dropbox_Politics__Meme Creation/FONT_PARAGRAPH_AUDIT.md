# Font & paragraph audit — 17_Dropbox_Politics__Meme Creation

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | TextBox 8 | free | 1.149,0.6931,3.4258,0.4376 | shape | 1 | scheme=accent1 |
| 1 | TextBox 15 | free | 5.6035,0.6944,1.3965,0.4376 | shape | 1 | scheme=accent1 |

**Text shapes fingerprinted:** 2

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
