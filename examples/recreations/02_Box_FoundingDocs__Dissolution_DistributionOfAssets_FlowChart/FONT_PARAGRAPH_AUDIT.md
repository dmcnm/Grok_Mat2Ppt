# Font & paragraph audit — 02_Box_FoundingDocs__Dissolution_DistributionOfAssets_FlowChart

## Pipeline applied (2026-07-18)

Per skills `mat2ppt-font-paragraph-audit`, `mat2ppt-slide-templates`,
`mat2ppt-bullet-autofit`, `mat2ppt-image-place-crop`:

1. **source_template.pptx** — masters/theme/layouts, zero slides
2. **Box first** — slide `a:xfrm` when source overrides layout
3. **Text structure** — soft-break titles, levels, soft breaks preserved where extracted
4. **List props** — `apply_list_para_props_` (marL/indent, accent1 buClr, spacing)
5. **Autofit** — match source (norm+fontScale / none / spAutoFit)
6. **Images** — per-slide geometry + crop when present

## Status

- Demo rebuilt with fidelity helpers (same pattern as Ex01).
- `out_mat2ppt.pptx` regenerated.
- Residual: free flowchart/form chrome (fills, connector adj, group shapes) may still differ visually from Office original; text/paragraph pipeline is the primary scope of this pass.

## Next visual check

COM-export key slides to `visual_compare/` and side-by-side with original.
