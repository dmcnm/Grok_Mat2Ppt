classdef SlideLayout < handle
%SLIDELAYOUT  Slide layout (p:sldLayout).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::SlideLayout (P6-W2 subset)

    properties (Access = private)
        element_
        partname_
        prs_
        masterPartname_
        shapes_ = []
    end

    methods
        function obj = SlideLayout(element, partname, prs, masterPartname)
            arguments
                element (1,1) mat2ppt.oxml.XmlElement
                partname
                prs
                masterPartname = ""
            end
            obj.element_ = element;
            obj.partname_ = char(string(partname));
            obj.prs_ = prs;
            obj.masterPartname_ = char(string(masterPartname));
        end

        function e = element(obj)
            e = obj.element_;
        end

        function p = partname(obj)
            p = obj.partname_;
        end

        function p = part(obj)
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
