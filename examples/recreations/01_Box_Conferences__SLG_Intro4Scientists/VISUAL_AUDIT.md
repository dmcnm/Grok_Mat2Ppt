# Visual audit — SLG Intro Rev1 (spacing / bullets / box lessons)

**Date:** 2026-07-18

## Lessons applied this pass

| Issue | Root cause | Fix |
|-------|------------|-----|
| Title font size off | Layout `lstStyle defRPr sz=6600` not cloned (empty lstStyle on ph) | Explicit Georgia **66 pt** on title runs |
| Slide 2 text under images | Body used **layout height ~6.2"**; source shortens body to ~3.8" above images. Autofit only fits the box. | `set_shape_box_(body, …, h=3.5)` + proper `a:off`/`a:ext` |
| Slide 3 bullet pattern | Free textboxes need explicit `buChar` / `buNone`; headers are bulleted in source | Headers + body columns: bullets; quote/subtitle: `buNone` |
| Slides 6–7 spacing | Source `lstStyle` has `lnSpc 120%`, `spcBef` 10 pt | `apply_list_spacing_` + 6 real paragraphs with soft breaks |

## Skills updated

- `mat2ppt-bullet-autofit` — box-before-autofit; buNone vs buChar; spcBef/lnSpc
- `mat2ppt-font-paragraph-audit` — layout title size, box/autofit, spacing checks
- `mat2ppt-slide-templates` — layout lstStyle size not cloned; body box vs layout

## Product fix

- Added `+mat2ppt/+oxml/+shapes/get_or_add_xfrm.m` (was misnamed `xfrm_helpers.m`)

## Residual

- Slide 2 may still need visual tweak if 22 pt is slightly small vs original 28×0.925
- Nested list indent on free shapes may be weaker than full `lstStyle` marL
- Quote color (gold) not recreated
