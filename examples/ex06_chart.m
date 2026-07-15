%% ex06_chart — Column chart from CategoryChartData
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex06_chart.pptx");

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

data = mat2ppt.chart.CategoryChartData();
data.set_categories({"East", "West", "North"});
data.add_series("Sales", [1.2, 2.3, 1.8]);
data.add_series("Cost", [0.8, 1.1, 0.9]);

gf = s.shapes().add_chart( ...
    mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
    mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.8), ...
    mat2ppt.util.Inches(8.5), mat2ppt.util.Inches(5), data);

% Optional: inspect via Chart API (1-based series)
ch = gf.chart();
fprintf("Series count: %d, first name: %s\n", ch.series_count(), ch.series_name(1));

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
