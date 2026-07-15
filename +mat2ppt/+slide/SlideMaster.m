classdef SlideMaster < handle
%SLIDEMASTER  Slide master (p:sldMaster).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::SlideMaster (P6-W2 subset)

    properties (Access = private)
        element_
        partname_
        prs_
        layouts_ = []
    end

    methods
        function obj = SlideMaster(element, partname, prs)
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
            p = struct("package", obj.prs_.package(), "partname", obj.partname_);
        end

        function prs = presentation(obj)
            prs = obj.prs_;
        end

        function layouts = slide_layouts(obj)
            if isempty(obj.layouts_)
                obj.layouts_ = mat2ppt.slide.SlideLayouts(obj);
            end
            layouts = obj.layouts_;
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
