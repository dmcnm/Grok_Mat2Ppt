# Font & paragraph audit — 06_Box_Zeffy__Donation_Form_Question_Discrepencies_by_Link_Type_

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | TextBox 4 | free | 1.7445,0.6874,1.6979,1.3127 | shape | 2 |  |
| 1 | TextBox 5 | free | 1.7188,5.1775,1.6979,1.3127 | shape | 2 |  |
| 1 | TextBox 6 | free | 1.7187,3.0118,1.6979,1.3127 | shape | 1 |  |
| 2 | TextBox 5 | free | 1.7549,0.6375,1.6979,1.3127 | shape | 2 |  |
| 2 | TextBox 6 | free | 2.2236,3.3297,1.6979,1.3127 | shape | 1 |  |

**Text shapes fingerprinted:** 5

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.

## Rebuild

`out_mat2ppt.pptx` rebuilt from fingerprint-driven `demo.m` via MATLAB R2024b (skill pipeline).
