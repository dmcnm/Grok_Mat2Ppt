%% ex10_bullets_and_picture — Title + bullets (left) + image (right)
% Uses Title and Content for bullets, then add_picture on the right.

addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex10_bullets_and_picture.pptx");
imgPath = fullfile(outDir, "rocket_starship_launch.jpg");
if ~isfile(imgPath)
    imgPath = fullfile(outDir, "20260709_CC_Star10_42_DSC_8953_mobile_c4b1853b3c.jpg");
end
if ~isfile(imgPath)
    imgPath = fullfile(outDir, "rocket_starship.jpeg");
end
if ~isfile(imgPath)
    error("mat2ppt:examples", "Missing rocket image in examples/.");
end

prs = mat2ppt.Presentation();
lay = prs.slide_layouts().get_by_name("Title and Content");
s = prs.slides().add_slide(lay);

s.shapes().item(1).text_frame().text = "Bullets next to a rocket photo";

body = s.shapes().item(2).text_frame();
body.clear();
ps = body.paragraphs();
ps{1}.text = "Launch photography";
ps{1}.level = 0;
p2 = body.add_paragraph();
p2.text = "JPEG inserted with add_picture";
p2.level = 1;
p3 = body.add_paragraph();
p3.text = "Sized on the right of the slide";
p3.level = 0;

% Place image on the right half of the slide
s.shapes().add_picture(imgPath, ...
    mat2ppt.util.Inches(5.2), mat2ppt.util.Inches(1.6), ...
    mat2ppt.util.Inches(4.0), mat2ppt.util.Inches(4.5));

prs.save(outPath);
fprintf("Wrote %s (image=%s)\n", outPath, imgPath);
