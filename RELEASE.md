# Mat2Ppt release notes — campaign 2026-07-15

**Version string:** `mat2ppt.version` → `0.10.1-p10-w1` (toolbox)  
**Upstream pin:** python-pptx **v1.0.2** / `278b47b` (read-only)

## Highlights

- Full PRT campaign P0–P10 through showcase + coverage matrix close-out
- M1 open/save L1 36/36; M2 hello-world L1 38/38
- Tables, pictures (imfinfo metrics, no Pillow), notes, hyperlinks
- Charts: data model, xlsx embed (D-xlsx), xmlwriters, `add_chart`, Chart API,
  `replace_data`, multi-type structural matrix
- Showcase deck: title, shapes, table+picture, chart, notes, hyperlink  
  (L0 inventory match vs python-pptx oracle)

## Known deviations / deferrals

| ID | Summary |
|----|---------|
| **D-xlsx** | Embedded chart workbook bytes may not match xlsxwriter; structural + caches required |
| XY/bubble/radar xmlwriters | `mat2ppt:notYetPorted` on ChartXmlWriter factory |
| Full chart XML L1 | Prefer structural L0 + D-xlsx for embeddings |

## Test

```matlab
addpath('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt');
runtests('tests');  % or workspace ./harness/run_matlab.sh --tests
```

## License

MIT — see LICENSE and NOTICE (python-pptx attribution).
