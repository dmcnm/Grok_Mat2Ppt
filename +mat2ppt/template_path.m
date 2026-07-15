function p = template_path(name)
%TEMPLATE_PATH  Absolute path to a bundled template resource.
%
%   p = mat2ppt.template_path()
%   p = mat2ppt.template_path("default.pptx")
%
%   Resolves files under resources/templates relative to the Mat2Ppt root.
%   Templates are byte-identical copies of python-pptx 1.0.2 templates.

    if nargin < 1 || strlength(string(name)) == 0
        name = "default.pptx";
    end
    name = string(name);

    here = fileparts(mfilename("fullpath"));
    root = fileparts(here);  % parent of +mat2ppt
    p = fullfile(root, "resources", "templates", name);

    if ~isfile(p)
        error("mat2ppt:TemplateNotFound", ...
            "Template not found: %s", p);
    end
end
