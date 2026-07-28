# Font & paragraph audit — 03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220

## Method (skill gate)

Per `mat2ppt-font-paragraph-audit`: **one fingerprint per text box**.

- Extract: `extracted/text_fingerprints.json` (**22+ text boxes / 11 slides**)
- Demo: fingerprint-driven `demo.m` (parameterized helpers; **not** one body policy for all)
- Package: `source_template.pptx` + rebuilt `out_mat2ppt.pptx`

## Binding order applied

1. Shape type + box (xfrm)
2. Text structure (paras / levels / soft breaks)
3. Font + para props **from that shape only**
4. Autofit last (fontScale / lnSpcReduction / spAutoFit / none)

## Per-shape policy map (source of truth)

| slide | shape | ph/free | box | autofit+scale | lstStyle? | #paras | levels | explicit | notes |
|------:|-------|---------|-----|---------------|-----------|-------:|--------|----------|-------|
| 1 | Title 1 | ctrTitle | layout | norm | no | 1 | 0 | inherit | |
| 1 | Subtitle 2 | subTitle | layout | norm | no | 2 | 0,0 | inherit | two paras |
| 2 | Title 1 | title | layout | norm | no | 1 | 0 | inherit | |
| 2 | Content Placeholder 2 | body | set | norm | no | 3 | 0×3 | listProps **false** | inherit layout bullets |
| 3 | Title 1 | title | layout | norm | no | 1 | 0 | sz=36 | |
| 3 | Content Placeholder 2 | body | set | norm **fs=62500 lsr=20000** | no | 17 | 0–2 | listProps false | |
| 3 | callout free | free | set | **spAutoFit** | no | 1 | 0 | **pt=40 bold scheme=accent5 algn=ctr** | bodyInsets |
| 4 | Title 1 | title | set | **none** | no | 1 | 0 | inherit | |
| 4 | Content Placeholder 2 | body | set | norm **fs=92500 lsr=10000** | no | 3 | 0×3 | colors: srgb 00B050 / 7030A0 / **scheme accent2** | legend (body ph, not free tb) |
| 5–8 | Title 1 | title | set | norm | no | 1 soft-break 2 lines | 0 | sz=36 | multi-line titles |
| 5 | body | body | set | norm | no | 4 | 0–1 | listProps false | |
| 6 | body | body | set | norm **fs=92500 lsr=20000** | no | 10 | 0–1 | listProps false | |
| 7 | body | body | set | norm **fs=92500 lsr=10000** | no | 10 | 0–1 | listProps false | |
| 8 | body | body | set | norm **lsr=10000** | no | 10 | 0–2 | listProps false | |
| 9 | Title 1 | title | set | norm | no | 1 | 0 | sz=36 | |
| 9 | Content Placeholder 2 **left** | body | set | norm **fs=92500 lsr=20000** | no | 8 | 0–1 | listProps **false** (inherit layout) | |
| 9 | free **right** | free | set | norm **fs=85000 lsr=10000** | **YES injectLstStyle** | 11 | 0–1 | bodyInsets | **different** from left |
| 10 | Title 1 | title | set | none | no | 1 | 0 | algn=ctr | body removed |
| 11 | Title 1 | title | layout | none | no | 1 | 0 | inherit | |
| 11 | Content Placeholder 2 | body | layout | none | no | 0 | — | empty body kept | |

## Diff vs `out_mat2ppt.pptx` (post rebuild)

| Severity | Item | Status |
|----------|------|--------|
| Critical | Multi-column s9 left vs right different policy | **Closed** |
| Critical | Placeholder forced foreign listProps | **Closed** (listProps false) |
| Major | s3 callout scheme accent5 + 40 pt + center | **Closed** |
| Major | s4 legend fontScale 92500 + per-line colors | **Closed** |
| Minor | Decorative text shadow on callout rPr | Open (visual secondary) |
| Minor | Connector chrome on s4 diagram | Present; not text-gate |

**Gate:** no Critical open on text shapes.

## Status

Rebuilt fingerprint-driven. Open `out_mat2ppt.pptx` and spot-check slides 3, 4, 9.
