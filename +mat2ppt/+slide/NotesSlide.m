classdef NotesSlide < handle
%NOTESSLIDE  Notes page for a slide (p:notes).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::NotesSlide (P6-W6)

    properties (Access = private)
        element_
        partname_
        prs_
        shapes_ = []
    end

    methods
        function obj = NotesSlide(element, partname, prs)
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

        function ph = notes_placeholder(obj)
            %NOTES_PLACEHOLDER  Body placeholder (notes text).
            phs = obj.placeholders();
            ph = [];
            for i = 1:phs.length
                sh = phs.item(i);
                t = mat2ppt.shapes.PlaceholderMixin.placeholder_type(sh.element());
                if strcmp(t, "body")
                    ph = sh;
                    return
                end
            end
        end

        function tf = notes_text_frame(obj)
            ph = obj.notes_placeholder();
            if isempty(ph)
                tf = [];
            else
                tf = ph.text_frame();
            end
        end
    end
end
