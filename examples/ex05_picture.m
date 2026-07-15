%% ex05_picture — Embed a PNG/JPEG from disk
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex05_picture.pptx");
imgPath = fullfile(outDir, "sample_image.png");

if ~isfile(imgPath)
    error("mat2ppt:examples", "Missing %s — re-clone examples assets.", imgPath);
end

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

% Width/height optional: omit or [] to use native size / aspect
s.shapes().add_picture(imgPath, ...
    mat2ppt.util.Inches(2), mat2ppt.util.Inches(1.5), ...
    mat2ppt.util.Inches(4), mat2ppt.util.Inches(3));

tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(5), ...
    mat2ppt.util.Inches(7), mat2ppt.util.Inches(0.5));
tb.text_frame().text = "Picture inserted via add_picture.";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
