# Font & paragraph audit — 05_Box_Website__Thermometer_Graphic

## Method

Per `mat2ppt-font-paragraph-audit` (updated):

- **Extract always** complete font+para fingerprints (`extracted/full_fingerprints.json`)
- **Write** may omit only true layout/master defaults
- Package: `source_template.pptx` + `demo.m` + `out_mat2ppt.pptx`

## Per-text-shape extract summary

| slide | shape | ph/free | box | autofit | #paras | notes |
|------:|-------|---------|-----|---------|-------:|-------|
| 1 | TextBox 1 | free | 49.8568,15.0512,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 2 | free | 50.0,19.7059,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 3 | free | 50.0,24.3605,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 4 | free | 49.7135,29.0155,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 5 | free | 49.8568,33.6702,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 6 | free | 49.9427,38.3248,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 65 | free | 49.9427,42.9794,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 66 | free | 49.6562,47.6344,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 67 | free | 49.7995,52.2891,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 82 | free | 50.0,10.3966,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 93 | free | 50.0859,1.1056,4.6328,2.4234 | shape | 1 |  |
| 1 | TextBox 102 | free | 50.0,5.7602,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 1 | free | 49.8568,1.3188,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 2 | free | 50.0,5.9735,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 3 | free | 50.0,10.6281,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 4 | free | 49.7135,15.2831,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 5 | free | 49.8568,19.9378,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 6 | free | 49.9427,24.5924,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 65 | free | 49.9427,29.247,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 66 | free | 49.6562,33.9021,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 67 | free | 49.7995,38.5567,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 80 | free | 49.5703,43.2113,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 81 | free | 49.7135,47.866,4.6328,2.4234 | shape | 1 |  |
| 2 | TextBox 88 | free | 49.5703,52.5206,4.6328,2.4234 | shape | 1 |  |

**Text shapes fingerprinted:** 24

## Status

Extract complete. Demo generated from fingerprints. Rebuild `out_mat2ppt.pptx` via MATLAB.
