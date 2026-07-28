# Visual audit — 05 Thermometer Graphic

**Date:** 2026-07-28  
**Status:** **visual_ok** (hand-rebuild via pipeline fix; no manual demo.m carve)

## Eye test

| Slide | Result | Notes |
|------:|--------|-------|
| 1 (0–45%) | **PASS** | 12 stacked meters; fill levels + labels match original |
| 2 (50–100%) | **PASS** | 12 stacked meters; progressive fill through 100% |

PNG pairs: `visual_compare/orig_slide*.png` vs `mat2ppt_slide*.png` (COM export 1200×1200).

## Root causes fixed (pipeline)

| Issue | Cause | Fix |
|-------|--------|-----|
| All meters collapsed to one Y | Nested `p:grpSp` xfrm **replaced** parent instead of **composed** | `compose_gxfrm` in `recreation_fidelity_pipeline.py` |
| Empty / wrong bar fill | Track fill is **`a:gradFill`** (not solid); extractor ignored gradients | Extract gradient stops + `apply_grad_fill_` helper in demo |

## Residual (non-blocking)

- Outline stroke slightly theme-blue vs original black (`style` lnRef vs explicit `tx1` line) — hard to see at full-slide scale
- Canvas is **56"×56"** custom size (not a unit bug)

## Rebuild

```bash
python3 harness/recreation_fidelity_pipeline.py --dir …/05_Box_Website__Thermometer_Graphic
./harness/run_matlab.sh "run('…/demo.m')"
# export: harness/export_pptx_slides.ps1
```
