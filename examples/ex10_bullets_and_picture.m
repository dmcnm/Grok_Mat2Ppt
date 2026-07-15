%% ex10_bullets_and_picture — Two Content: bullets (left) + rocket photo (right)
% Layout: "Two Content" (same pattern as showcase slide 3 / your sample).
% Query layouts first with ex00_list_layouts or:
%   layouts = prs.slide_layouts();  % .length, .item(i), .get_by_name(name)

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

% List layouts (optional demo)
layouts = prs.slide_layouts();
fprintf("Using layout 'Two Content' (index among %d layouts)\n", layouts.length);
for i = 1:layouts.length
    if layouts.item(i).name == "Two Content"
        fprintf("  Two Content is layouts.item(%d)\n", i);
    end
end

lay = layouts.get_by_name("Two Content");
s = prs.slides().add_slide(lay);

% Two Content shapes (1-based): 1=title, 2=left body, 3=right body
s.shapes().item(1).text_frame().text = "Two Content: bullets + rocket";

bodyL = s.shapes().item(2).text_frame();
bodyL.clear();
ps = bodyL.paragraphs();
ps{1}.text = "Left column bullets";
ps{1}.level = 0;
p2 = bodyL.add_paragraph();
p2.text = "JPEG via add_picture on the right";
p2.level = 1;
p3 = bodyL.add_paragraph();
p3.text = "Right placeholder can hold text too";
p3.level = 0;

s.shapes().item(3).text_frame().text = "Right column label";

% Picture over the right half (matches your Two Content sample)
s.shapes().add_picture(imgPath, ...
    mat2ppt.util.Inches(5.2), mat2ppt.util.Inches(1.6), ...
    mat2ppt.util.Inches(4.0), mat2ppt.util.Inches(4.5));

prs.save(outPath);
fprintf("Wrote %s (image=%s)\n", outPath, imgPath);
