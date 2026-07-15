%% ex02_blank_textbox — Blank slide with a free textbox
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex02_blank_textbox.pptx");

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1.5), ...
    mat2ppt.util.Inches(7), mat2ppt.util.Inches(2));
tb.text_frame().text = "This text is in a free textbox on a Blank layout.";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
