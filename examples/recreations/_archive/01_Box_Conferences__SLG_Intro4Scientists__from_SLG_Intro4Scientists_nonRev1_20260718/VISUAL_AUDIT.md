# Visual audit — SLG Intro for Scientists (**frozen**)

**Status:** hand_tuned · Batch 1 · 2026-07-18

## Layout / template

| Slide | Source | Demo |
|------:|--------|------|
| 1 | Title and Content | Title and Content + multi-para bullets |
| 2 | Comparison | Comparison + hand-tuned fonts / free text |
| 3–6 | Title and Content | Title and Content |

## Eye test (key slides)

| Slide | Result |
|------:|--------|
| 1 | **Good** — real bullets; footer slightly tight under last line |
| 2 | **Good after hand-tune** — columns fit at 9 pt; subtitle under title; quote + footer clear |

## Hand-tunes applied

- Slide 2: body fonts 9 pt; headers 14; subtitle free textbox; quote 10 pt; footer repositioned
- Layout-aware regenerate (not Blank free-rects)

## Residual (accepted)

- Default Mat2Ppt theme fonts/margins vs source theme
- Footer/slide number as free textboxes (latent ph not cloned — same as python-pptx)
- Master logos / school chrome not on every slide

## Artifacts

- `demo.m` (hand-tuned) · `demo.m.bak_pre_layout`
- `visual_compare/orig_slide{1,2}.png`, `mat2ppt_slide{1,2}.png`
- `out_mat2ppt.pptx`
