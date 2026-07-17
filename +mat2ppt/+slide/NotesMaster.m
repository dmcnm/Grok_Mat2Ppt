classdef NotesMaster < handle
%NOTESMASTER  Notes master (p:notesMaster).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::NotesMaster (R1-W2)

    properties (Access = private)
        element_
        partname_
        prs_
        shapes_ = []
    end

    methods
        function obj = NotesMaster(element, partname, prs)
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

        function sh = shapes(obj)
            if isempty(obj.shapes_)
                [~, spTree] = mat2ppt.slide.find_cSld_spTree(obj.element_);
                obj.shapes_ = mat2ppt.shapes.SlideShapes(spTree, obj);
            end
            sh = obj.shapes_;
        end

        function phs = placeholders(obj)
            phs = mat2ppt.slide.placeholders_from_shapes_(obj.shapes());
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
