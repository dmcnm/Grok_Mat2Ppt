%% ex05_picture — Embed a JPEG from disk (Starship photo)
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex05_picture.pptx");
imgPath = fullfile(outDir, "rocket_starship.jpeg");
if ~isfile(imgPath)
    imgPath = fullfile(outDir, "Starship.jpeg");
end
if ~isfile(imgPath)
    error("mat2ppt:examples", "Missing rocket image in examples/ (rocket_starship.jpeg).");
end

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

% Width/height optional: omit or [] to use native size / aspect
s.shapes().add_picture(imgPath, ...
    mat2ppt.util.Inches(2), mat2ppt.util.Inches(1.0), ...
    mat2ppt.util.Inches(5), mat2ppt.util.Inches(5));

tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(6.2), ...
    mat2ppt.util.Inches(7), mat2ppt.util.Inches(0.5));
tb.text_frame().text = "Starship photo via add_picture (JPEG).";

prs.save(outPath);
fprintf("Wrote %s (image=%s)\n", outPath, imgPath);
