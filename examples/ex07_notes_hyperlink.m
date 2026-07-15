%% ex07_notes_hyperlink — Speaker notes + hyperlink on a run
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex07_notes_hyperlink.pptx");

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(2), ...
    mat2ppt.util.Inches(6), mat2ppt.util.Inches(1));
paras = tb.text_frame().paragraphs();
p = paras{1};
p.clear_content();
r = p.add_run();
r.text = "Open example.com";
r.hyperlink().address = "https://example.com/";

% Notes slide (creates notes part if needed)
s.notes_slide().notes_text_frame().text = "Say this while clicking the link.";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
