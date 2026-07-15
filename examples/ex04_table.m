%% ex04_table — Insert a table and set cell text (1-based rows/cols)
addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex04_table.pptx");

prs = mat2ppt.Presentation();
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);

gf = s.shapes().add_table(3, 3, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(6), mat2ppt.util.Inches(2.5));
tbl = gf.table();  % GraphicFrame → Table

% Cells are 1-based: cell(row, col)
tbl.cell(1, 1).text = "Name";
tbl.cell(1, 2).text = "Qty";
tbl.cell(1, 3).text = "Notes";
tbl.cell(2, 1).text = "Apples";
tbl.cell(2, 2).text = "12";
tbl.cell(3, 1).text = "Oranges";
tbl.cell(3, 2).text = "8";

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
