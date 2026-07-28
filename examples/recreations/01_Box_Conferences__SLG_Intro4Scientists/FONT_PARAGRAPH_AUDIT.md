# Font & paragraph critical audit — 01 Rev1

## Master / theme gate

| | Original | Mat2Ppt out |
|---|---|---|
| titleStyle Georgia / cap=all | yes | yes |
| Gallery beige + wood floor | yes | yes |

**PASS:** `Presentation(source_template.pptx)` — not default.pptx.

## Root causes fixed this pass

| # | Failure | Fix |
|---|---------|-----|
| 1 | Title mid-size looked wrong | Source is **intentional**: line1 inherits layout **66 pt** (no `rPr@sz`); line2 **`sz=4400`**. Do not force 66 on both runs. Soft-break `a:br`. |
| 2 | Quote black despite XML `FFC000` | OOXML requires **`solidFill` before `latin`** on `a:rPr`. Product `FillFormat.solid` / `Font.name` insert in order. |
| 3 | Formats applied ad hoc | One path: `format_all_runs_` / `format_one_run_` (size → color → face). |
| 4 | Subtitle left under rule | Source slide overrides layout xfrm — applied. |
| 5 | MATLAB `struct("rgb",[r g b])` expands | Pass `rgb` in a cell; `normalize_fmt_opts_`. |

## Slide 1 (title)

| Field | Original | Out |
|-------|----------|-----|
| Line1 `sz` | (inherit layout 66) | none (inherit) |
| Line2 `sz` | 4400 | 4400 |
| Soft break | `a:br` | `a:br` |
| Subtitle box | xfrm 5.56", 4.93" | same |
| Subtitle face/pt | theme / 18 | Georgia 18 |

**PNG:** title line pixel heights match original (76 / 49 px at 1600×900).

## Slide 3 quote

| Field | Original | Out |
|-------|----------|-----|
| Color | `srgbClr FFC000` | `FFC000` |
| Size | (otherStyle 18) | `sz=1800` |
| Face | theme | Georgia |
| rPr order | solidFill only | solidFill → latin |
| Gold pixels (bottom band) | ~6122 | ~6151 |

**PASS** (COM export + pixel sample).

## Uniform policy (demo helpers)

```matlab
format_all_runs_(tf, struct("face","Georgia","pt",18,"rgb",{[255 192 0]}));
% order inside format_one_run_: size attr → color solidFill → face latin
```

## Binding order (all slides)

1. **Box** (`a:xfrm`) from source  
2. **Text** (paras, levels, soft breaks)  
3. **Font/para** (sz, face, buClr=accent1, spacing)  
4. **Autofit** last, with source `fontScale` / `lnSpcReduction`

## Mix-up explained — slide 8

| Layer | Value |
|-------|--------|
| Run `sz` | 2400 / 2000 (24 / 20 pt) on first bullets; last four inherit |
| `normAutofit fontScale` | **85000** (0.85) |
| **Visual size** | ≈ **20.4 / 17 pt**, not 24/20 |

Calling 24/20 “inherited” without fontScale was wrong. Source freezes both.

## Slide 2

| | Source | Fix |
|---|--------|-----|
| Body box | 0.525×1.0263, 11.3591×**3.8418** | was wrongly shortened to 3.50" |
| Run sz | 2800 | keep 2800 |
| fontScale | **92500** | write on `a:normAutofit` |

## Slide 3

| | Fix |
|---|-----|
| Bullet color | `buClr` → `schemeClr accent1` (#B71E42), not black |
| Headers | **20 pt** (lstStyle), not 18 |
| Body | 14/11 and 14/12/10 + spacing + lnSpcReduction 10000 |
| Quote | gold FFC000; no forced invent size |

## Slides 6–7

| | Source | Was wrong |
|---|--------|-----------|
| David pic | 1.1493, **1.0839**, 8.2621×**6.3667** | 1.45 / 5.95 |
| Rembrandt pic | 2.884, **1.0575**, 5.0543×**6.3004** | 1.45 / 5.9 |
| Sidebar | Georgia 20, accent1 bullets, soft-break dimensions | partial |

## Skills updated

- `mat2ppt-bullet-autofit` — box→font→autofit; fontScale; accent1; **list marL/indent**  
- `mat2ppt-font-paragraph-audit` — lessons 11–16  
- `mat2ppt-image-place-crop` — per-slide xfrm  

## Paragraph props fix (slides 3–7)

| Slide | Fix |
|-------|-----|
| **3** | `apply_list_para_props_` (marL/indent/spc/accent1 per level); header bodyPr insets+`anchor=t` |
| **4–5** | Source title+body **xfrm**; body **no autofit**; list props on paras |
| **6–7** | Sidebar list props + bodyPr insets+anchor; exact pic geometry |
