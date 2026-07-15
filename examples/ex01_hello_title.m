%% ex01_hello_title — Title slide with title and subtitle text
% Creates out_ex01_hello_title.pptx next to this script.

addpath(fullfile(fileparts(mfilename("fullpath")), ".."));

outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex01_hello_title.pptx");

prs = mat2ppt.Presentation();
layout = prs.slide_layouts().get_by_name("Title Slide");
s = prs.slides().add_slide(layout);

% Placeholder shapes on a Title Slide: 1 = title, 2 = subtitle (1-based)
s.shapes().item(1).text_frame().text = "Hello from Mat2Ppt";
s.shapes().item(2).text_frame().text = "Title + subtitle example";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
