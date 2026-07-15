%% ex09_bullets — Title and Content slide with multi-level bullets
% Layout: "Title and Content" (standard bullet body placeholder).

addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex09_bullets.pptx");

prs = mat2ppt.Presentation();
lay = prs.slide_layouts().get_by_name("Title and Content");
s = prs.slides().add_slide(lay);

% Shape 1 = title, shape 2 = body (content) placeholder — 1-based
s.shapes().item(1).text_frame().text = "Bulleted Slide Example";

body = s.shapes().item(2).text_frame();
body.clear();
ps = body.paragraphs();
ps{1}.text = "This is the first bullet";
ps{1}.level = 0;

p2 = body.add_paragraph();
p2.text = "This is the second bullet (level 1)";
p2.level = 1;

p3 = body.add_paragraph();
p3.text = "This is the third bullet (level 2)";
p3.level = 2;

p4 = body.add_paragraph();
p4.text = "Back to level zero";
p4.level = 0;

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
