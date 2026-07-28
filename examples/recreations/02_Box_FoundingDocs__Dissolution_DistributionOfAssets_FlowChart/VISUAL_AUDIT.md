# Visual audit — Dissolution flowchart (**frozen**)

**Status:** hand_tuned · Batch 0 · 2026-07-17/18

## Layout / template

| Slide | Source | Demo |
|------:|--------|------|
| 1 | Title Slide (no placeholders on slide) | **Blank** free shapes (flowchart) |

Pure freeform → Blank is correct; source layout name was misleading.

## Eye test

| Check | Result |
|-------|--------|
| Solid fills (not gradient) | PASS (`fillRef` 1) |
| Font 14 / 12 pt | PASS |
| Yes/No transparent textboxes | PASS |
| Connectors path + adj + arrows | PASS (flow begin→end) |
| Inches (not raw EMU) | PASS |

## Residual (accepted)

- Subtle style idx differences (lnRef/effectRef) vs Office file
- No `stCxn`/`endCxn` live attachment (endpoints free-standing)
- Elbow 40 default triangle where original had none

## Artifacts

- Hand-authored `demo.m` (do not overwrite with autogen)
- `visual_compare/orig_slide1.png`, `mat2ppt_slide1.png`
- `out_mat2ppt.pptx`
