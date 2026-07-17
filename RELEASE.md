# Mat2Ppt release notes — residual campaign 2026-07-17

**Version string:** `0.11.0-residual`  
**Upstream pin:** python-pptx **v1.0.2** / `278b47b` (read-only)

## Campaigns

| Campaign | Result |
|----------|--------|
| P0–P10 primary | **COMPLETE** (M1/M2/M3 + showcase) |
| Residual R0–R8 | **COMPLETE** (public-surface twin + infra DEFs) |
| Residual R9 | system polish in progress (corpus postponed) |

## Residual highlights (R1–R8)

- Presentation/slide shell, text/DML/table residuals
- Connector, group, freeform, picture crop
- ActionSetting / click_action / named slide
- Area / XY / Bubble / Radar charts + chart title/style
- **add_movie** (Video, MediaPart, dual MEDIA+VIDEO, p:timing, speaker poster)
- **add_ole_object** (PROG_ID metadata, embeddings, ole_format)
- Domain CT registration + DEF-008/009/012 close-out (XmlElement residual signed)

## Known deviations / open items

| ID | Summary |
|----|---------|
| **D-xlsx** | Chart workbook bytes may differ from xlsxwriter |
| **RES-CORPUS** | External presentation corpus postponed (user HD scrape) |
| Movie experimental | Upstream experimental limits apply |
| Inventory heuristic | ~134 name-presence misses remain (many inherit/property aliases); authoring dual-audit surfaces closed |

## Test

```matlab
addpath('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt');
runtests('tests');
```

## License

MIT — see LICENSE and NOTICE (python-pptx attribution).
