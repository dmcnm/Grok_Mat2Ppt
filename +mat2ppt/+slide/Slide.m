classdef Slide < handle
%SLIDE  Presentation slide (p:sld).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::Slide (P6-W2 subset)

    properties (Access = private)
        element_
        partname_
        prs_
        shapes_ = []
    end

    methods
        function obj = Slide(element, partname, prs)
            arguments
                element (1,1) mat2ppt.oxml.XmlElement
                partname
                prs
            end
            obj.element_ = element;
            obj.partname_ = char(string(partname));
            obj.prs_ = prs;
        end

        function e = element(obj)
            e = obj.element_;
        end

        function p = partname(obj)
            p = obj.partname_;
        end

        function p = part(obj)
            %PART  ProvidesPart stub: package + partname for shape trees.
            p = struct("package", obj.prs_.package(), "partname", obj.partname_);
        end

        function sh = shapes(obj)
            if isempty(obj.shapes_)
                [~, spTree] = mat2ppt.slide.find_cSld_spTree(obj.element_);
                obj.shapes_ = mat2ppt.shapes.SlideShapes(spTree, obj);
            end
            sh = obj.shapes_;
        end

        function n = name(obj)
            [cSld, ~] = mat2ppt.slide.find_cSld_spTree(obj.element_);
            raw = cSld.get("name");
            if mat2ppt.isAbsent(raw)
                n = "";
            else
                n = string(raw);
            end
        end
    end
end
