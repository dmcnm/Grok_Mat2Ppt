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
        coreProps_ = []  % cached CoreProperties or []
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

        function cp = core_properties(obj)
            %CORE_PROPERTIES  Dublin Core metadata for this package.
            if isempty(obj.coreProps_)
                elm = obj.pkg_.xml_part_element("/docProps/core.xml");
                if isempty(elm)
                    error("mat2ppt:InvalidPackage", "Missing /docProps/core.xml");
                end
                obj.coreProps_ = mat2ppt.parts.CoreProperties(elm);
            end
            cp = obj.coreProps_;
        end

        function elm = presentation_element(obj)
            %PRESENTATION_ELEMENT  Root p:presentation of /ppt/presentation.xml.
            elm = obj.pkg_.xml_part_element("/ppt/presentation.xml");
            if isempty(elm)
                error("mat2ppt:InvalidPackage", "Missing /ppt/presentation.xml");
            end
        end

        function s = slides(obj)
            %SLIDES  |Slides| collection (1-based). Empty on default template.
            s = mat2ppt.slide.Slides(obj);
        end

        function sm = slide_masters(obj)
            %SLIDE_MASTERS  |SlideMasters| collection (1-based).
            sm = mat2ppt.slide.SlideMasters(obj);
        end

        function sm = slide_master(obj)
            %SLIDE_MASTER  First slide master (common single-master case).
            sm = obj.slide_masters().item(1);
        end

        function layouts = slide_layouts(obj)
            %SLIDE_LAYOUTS  Layouts of the first slide master (1-based).
            layouts = obj.slide_master().slide_layouts();
        end
    end
end

