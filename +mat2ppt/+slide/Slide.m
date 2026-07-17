classdef Slide < handle
%SLIDE  Presentation slide (p:sld).
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::Slide (P6-W2/W6)

    properties (Access = private)
        element_
        partname_
        prs_
        shapes_ = []
        notes_ = []
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

        function prs = presentation(obj)
            prs = obj.prs_;
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

        function phs = placeholders(obj)
            %PLACEHOLDERS  Placeholder shapes on this slide (1-based).
            phs = mat2ppt.slide.placeholders_from_shapes_(obj.shapes());
        end

        function tf = has_notes_slide(obj)
            %HAS_NOTES_SLIDE  True if a notes slide part is already related.
            pkg = obj.prs_.package();
            tf = mat2ppt.opc.has_rel_type(pkg, obj.partname_, ...
                mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_SLIDE);
        end

        function ns = notes_slide(obj)
            %NOTES_SLIDE  Notes page (creates notes master + notes slide if needed).
            if ~isempty(obj.notes_)
                ns = obj.notes_;
                return
            end
            ns = mat2ppt.slide.ensure_notes_slide(obj);
            obj.notes_ = ns;
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

        function id = slide_id(obj)
            %SLIDE_ID  Stable integer id from presentation p:sldId/@id.
            %
            %   Ported from python-pptx Slide.slide_id / PresentationPart.slide_id
            id = mat2ppt.slide.slide_id_for_partname_(obj.prs_, obj.partname_);
        end

        function layout = slide_layout(obj)
            %SLIDE_LAYOUT  Layout this slide inherits from (via SLIDE_LAYOUT rel).
            pkg = obj.prs_.package();
            layoutPn = mat2ppt.opc.related_partname_by_type(pkg, obj.partname_, ...
                mat2ppt.opc.RELATIONSHIP_TYPE.SLIDE_LAYOUT);
            if isempty(layoutPn)
                error("mat2ppt:InvalidPackage", ...
                    "Slide has no slideLayout relationship: %s", obj.partname_);
            end
            elm = pkg.xml_part_element(layoutPn);
            if isempty(elm)
                error("mat2ppt:InvalidPackage", "Missing layout part %s", layoutPn);
            end
            layout = mat2ppt.slide.SlideLayout(elm, layoutPn, obj.prs_);
        end

        function tf = follow_master_background(obj)
            %FOLLOW_MASTER_BACKGROUND  True when slide has no custom p:bg (getter only).
            %
            %   Upstream v1.0.2 documents assign True/False but implements getter only.
            [cSld, ~] = mat2ppt.slide.find_cSld_spTree(obj.element_);
            bg = cSld.find("p:bg");
            if isempty(bg)
                kids = cSld.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "bg")
                        bg = kids{i};
                        break
                    end
                end
            end
            tf = isempty(bg);
        end
    end
end
