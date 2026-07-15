%% ex08_showcase — Multi-slide deck: title, text, shape, table, picture, chart
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex08_showcase.pptx");
imgPath = fullfile(outDir, "sample_image.png");

prs = mat2ppt.Presentation();

%% Slide 1 — title
titleLay = prs.slide_layouts().get_by_name("Title Slide");
s1 = prs.slides().add_slide(titleLay);
s1.shapes().item(1).text_frame().text = "Mat2Ppt Examples";
s1.shapes().item(2).text_frame().text = "ex08_showcase";

blank = prs.slide_layouts().get_by_name("Blank");

%% Slide 2 — textbox + shape
s2 = prs.slides().add_slide(blank);
s2.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
tb = s2.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(2.5), ...
    mat2ppt.util.Inches(6), mat2ppt.util.Inches(1));
tb.text_frame().text = "Shapes and text";

%% Slide 3 — table + picture
s3 = prs.slides().add_slide(blank);
gf = s3.shapes().add_table(2, 2, ...
    mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
    mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
t = gf.table();
t.cell(1, 1).text = "A";
t.cell(2, 2).text = "B";
if isfile(imgPath)
    s3.shapes().add_picture(imgPath, ...
        mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5), ...
        mat2ppt.util.Inches(3), mat2ppt.util.Inches(2));
end

%% Slide 4 — chart
s4 = prs.slides().add_slide(blank);
data = mat2ppt.chart.CategoryChartData();
data.set_categories({"Q1", "Q2", "Q3"});
data.add_series("Revenue", [10, 14, 12]);
s4.shapes().add_chart( ...
    mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(7), mat2ppt.util.Inches(4.5), data);

prs.save(outPath);
fprintf("Wrote %s (%d slides)\n", outPath, prs.slides().length);
