# Visual audit — Art Nonprofit Planning Meeting (**frozen**)

**Status:** hand_tuned · Batch 1 · 2026-07-18

## Layout / template

| Slides | Source | Demo |
|--------|--------|------|
| 1 | Title Slide | **Title Slide** (ctrTitle + subTitle) |
| 2–3, 5–11 | Title and Content | **Title and Content** + multi-level bullets |
| 4 | Title and Content | **Title Only** (hand-tuned — floor plan + legend) |

## Eye test (sampled 1–4)

| Slide | Result |
|------:|--------|
| 1 | Layout OK; **missing** full-bleed master background / large watermark |
| 2 | Bullets OK; missing master logos + blue rules + school footer chrome |
| 3 | Body list complete at 12 pt; callout present (not blue styled) |
| 4 | Floor plan + legend; no empty bullet ghosts |

## Hand-tunes applied

- Layout-aware regenerate (Inches, Title Slide / Title and Content)
- Slide 3: body 12 pt; multi-line callout
- Slide 4: Title Only + free legend (avoid body bullets under image)

## Residual (accepted) — **theme/master gap**

Biggest remaining gap for this deck is **not** layout name, but **master chrome**:

- Full-bleed title background
- Logo on every content slide (master/layout pics)
- Blue horizontal rules + footer slogan
- Colored legend runs on slide 4
- Callout fill/gradient on slide 3

Track as product/theme follow-up, not more autogen thrash.

## Artifacts

- `demo.m` (hand-tuned) · `demo.m.bak_pre_layout`
- `visual_compare/orig_slide{1..4}.png`, `mat2ppt_slide{1..4}.png`
- `out_mat2ppt.pptx`
