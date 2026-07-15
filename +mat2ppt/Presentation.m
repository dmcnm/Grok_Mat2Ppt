classdef Presentation < handle
%PRESENTATION  PowerPoint presentation package (public entry, Option C).
%
%   prs = mat2ppt.Presentation()
%   prs = mat2ppt.Presentation(path)
%   prs.save(path)
%
%   Ported from python-pptx 1.0.2: src/pptx/api.py::Presentation
%   + src/pptx/presentation.py::Presentation (thin M1 shell)

    properties (Access = private)
        pkg_
    end

    methods
        function obj = Presentation(pptx)
            %PRESENTATION  Open default template or path.
            if nargin < 1 || mat2ppt.isAbsent(pptx)
                pptx = mat2ppt.template_path("default.pptx");
            end
            pptx = char(string(pptx));
            if ~isfile(pptx)
                error("mat2ppt:PackageNotFoundError", ...
                    "Package not found at '%s'.", pptx);
            end
            obj.pkg_ = mat2ppt.opc.OpcPackage.open(pptx);
        end

        function save(obj, path)
            %SAVE  Write package to path.
            arguments
                obj
                path
            end
            path = char(string(path));
            if strlength(string(path)) == 0
                error("mat2ppt:ArgumentError", "save path must be non-empty text.");
            end
            obj.pkg_.save(path);
        end

        function pkg = package(obj)
            %PACKAGE  Underlying OpcPackage (advanced).
            pkg = obj.pkg_;
        end
    end
end
