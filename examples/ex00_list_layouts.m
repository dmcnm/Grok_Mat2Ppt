%% ex00_list_layouts — Query available slide layouts (1-based)
% Prints every layout name on the default presentation template.
% Layouts are ordered as on the slide master (same order as PowerPoint UI).

addpath(fullfile(fileparts(mfilename("fullpath")), ".."));

prs = mat2ppt.Presentation();
layouts = prs.slide_layouts();

fprintf("Slide layout count: %d\n", layouts.length);
fprintf("%-4s  %-32s  %s\n", "Idx", "Name", "How to get");
fprintf("%s\n", repmat("-", 1, 72));
for i = 1:layouts.length
    lay = layouts.item(i);  % 1-based
    nm = char(string(lay.name));
    fprintf("%-4d  %-32s  get_by_name('%s')\n", i, nm, nm);
end

fprintf("\nExamples:\n");
fprintf("  lay = prs.slide_layouts().get_by_name('Two Content');\n");
fprintf("  s   = prs.slides().add_slide(lay);\n");
fprintf("  %% or by index (1-based):\n");
fprintf("  s   = prs.slides().add_slide(prs.slide_layouts().item(4));\n");
