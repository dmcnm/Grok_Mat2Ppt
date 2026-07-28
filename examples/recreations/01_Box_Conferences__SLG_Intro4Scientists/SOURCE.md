# Source package

| Field | Value |
|-------|--------|
| Final deck | `C:\Users\dougl\Box\Conferences\SLG_Intro4Scientists_Rev1.pptx` |
| Working copy | `reference_original.pptx` |
| **Authoring template** | `source_template.pptx` (masters + layouts + Gallery theme, **zero slides**) |

## Why not `Presentation()` default?

Default Mat2Ppt package is **Office** theme (white). This deck needs:

- Gallery theme (`bg2` beige ≈ `#DFDBD5`, accent red)
- Master wood-floor picture
- Layout red title rules
- Title style Georgia + all caps

```matlab
prs = mat2ppt.Presentation(fullfile(here, "source_template.pptx"));
```

## Rebuild source_template

Strip all slides from `reference_original.pptx` while keeping `ppt/slideMasters`,
`ppt/slideLayouts`, `ppt/theme`, media. See session notes / regenerate script.
