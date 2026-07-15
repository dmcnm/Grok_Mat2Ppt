%% ex08_showcase — Multi-slide deck (title, bullets, bullets+image, shapes, table+pic, chart)
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex08_showcase.pptx");
% Rocket photos (user-supplied). Prefer stable names; fall back to originals.
imgPortrait = fullfile(outDir, "rocket_starship_launch.jpg");
if ~isfile(imgPortrait)
    imgPortrait = fullfile(outDir, "20260709_CC_Star10_42_DSC_8953_mobile_c4b1853b3c.jpg");
end
imgStarship = fullfile(outDir, "rocket_starship.jpeg");
if ~isfile(imgStarship)
    imgStarship = fullfile(outDir, "Starship.jpeg");
end

prs = mat2ppt.Presentation();

%% 1 — title
titleLay = prs.slide_layouts().get_by_name("Title Slide");
s1 = prs.slides().add_slide(titleLay);
s1.shapes().item(1).text_frame().text = "Mat2Ppt Examples";
s1.shapes().item(2).text_frame().text = "ex08_showcase — rockets included";

%% 2 — standard bullets (Title and Content)
tac = prs.slide_layouts().get_by_name("Title and Content");
s2 = prs.slides().add_slide(tac);
s2.shapes().item(1).text_frame().text = "Bulleted Slide Example";
body = s2.shapes().item(2).text_frame();
body.clear();
ps = body.paragraphs();
ps{1}.text = "This is the first bullet";
ps{1}.level = 0;
p = body.add_paragraph();
p.text = "Nested bullet";
p.level = 1;
p = body.add_paragraph();
p.text = "Another top-level bullet";
p.level = 0;

%% 3 — bullets + rocket photo
s3 = prs.slides().add_slide(tac);
s3.shapes().item(1).text_frame().text = "Bullets next to a rocket photo";
body = s3.shapes().item(2).text_frame();
body.clear();
ps = body.paragraphs();
ps{1}.text = "Left: bullet list";
ps{1}.level = 0;
p = body.add_paragraph();
p.text = "Right: JPEG via add_picture";
p.level = 0;
if isfile(imgPortrait)
    s3.shapes().add_picture(imgPortrait, ...
        mat2ppt.util.Inches(5.2), mat2ppt.util.Inches(1.6), ...
        mat2ppt.util.Inches(4.0), mat2ppt.util.Inches(4.5));
end

blank = prs.slide_layouts().get_by_name("Blank");

%% 4 — textbox + shape
s4 = prs.slides().add_slide(blank);
s4.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
tb = s4.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(2.5), ...
    mat2ppt.util.Inches(6), mat2ppt.util.Inches(1));
tb.text_frame().text = "Shapes and text";

%% 5 — table + Starship image
s5 = prs.slides().add_slide(blank);
gf = s5.shapes().add_table(2, 2, ...
    mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
    mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
t = gf.table();
t.cell(1, 1).text = "A";
t.cell(2, 2).text = "B";
if isfile(imgStarship)
    s5.shapes().add_picture(imgStarship, ...
        mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5), ...
        mat2ppt.util.Inches(4.5), mat2ppt.util.Inches(4.5));
end

%% 6 — chart
s6 = prs.slides().add_slide(blank);
data = mat2ppt.chart.CategoryChartData();
data.set_categories({"Q1", "Q2", "Q3"});
data.add_series("Revenue", [10, 14, 12]);
s6.shapes().add_chart( ...
    mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(7), mat2ppt.util.Inches(4.5), data);

prs.save(outPath);
fprintf("Wrote %s (%d slides)\n", outPath, prs.slides().length);
