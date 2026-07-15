%% ex03_shapes — Add an auto-shape and a textbox
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex03_shapes.pptx");

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));

tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(3), ...
    mat2ppt.util.Inches(5), mat2ppt.util.Inches(1));
tb.text_frame().text = "Rectangle above, textbox below.";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
