classdef Slides < mat2ppt.shared.Collection
%SLIDES  1-based collection of presentation slides.
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::Slides (P6-W2 read path)

    properties (Access = private)
        prs_
    end

    methods
        function obj = Slides(prs)
            obj.prs_ = prs;
            obj.rebuild_();
        end

        function prs = presentation(obj)
            prs = obj.prs_;
        end

        function slide = add_slide(obj, slideLayout)
            %ADD_SLIDE  New slide based on layout (P6-W3 package wiring).
            arguments
                obj
                slideLayout (1,1) mat2ppt.slide.SlideLayout
            end
            pkg = obj.prs_.package();
            n = obj.next_slide_number_();
            slidePn = sprintf("/ppt/slides/slide%d.xml", n);
            sldElm = mat2ppt.oxml.slide.CT_Slide.new();
            pkg.add_xml_part(slidePn, sldElm, mat2ppt.opc.CONTENT_TYPE.PML_SLIDE);
            % slide -> layout relationship
            pkg.add_relationship(slidePn, mat2ppt.opc.RELATIONSHIP_TYPE.SLIDE_LAYOUT, ...
                slideLayout.partname());
            % presentation -> slide relationship
            rId = pkg.add_relationship("/ppt/presentation.xml", ...
                mat2ppt.opc.RELATIONSHIP_TYPE.SLIDE, slidePn);
            % sldIdLst entry
            mat2ppt.slide.add_sldId_(obj.prs_.presentation_element(), rId);
            % keep presentation XML in package map
            pkg.replace_xml_part("/ppt/presentation.xml", obj.prs_.presentation_element());
            slide = mat2ppt.slide.Slide(sldElm, slidePn, obj.prs_);
            mat2ppt.slide.clone_layout_placeholders(slide, slideLayout);
            % re-persist slide after placeholder clone
            pkg.replace_xml_part(slidePn, sldElm);
            obj.rebuild_();
            % return the collection member (same tree)
            slide = obj.item(obj.length);
        end
    end

    methods (Access = private)
        function n = next_slide_number_(obj)
            pkg = obj.prs_.package();
            names = pkg.list_partnames();
            maxN = 0;
            for i = 1:numel(names)
                pn = char(names(i));
                tok = regexp(pn, "^/ppt/slides/slide(\d+)\.xml$", "tokens", "once");
                if ~isempty(tok)
                    maxN = max(maxN, str2double(tok{1}));
                end
            end
            n = maxN + 1;
        end

        function rebuild_(obj)
            pkg = obj.prs_.package();
            presElm = obj.prs_.presentation_element();
            sldIdLst = presElm.find("p:sldIdLst");
            if isempty(sldIdLst)
                kids = presElm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "sldIdLst")
                        sldIdLst = kids{i};
                        break
                    end
                end
            end
            items = {};
            if isempty(sldIdLst)
                obj.items_ = items;
                return
            end
            for i = 1:numel(sldIdLst.getchildren())
                el = sldIdLst.child(i);
                if ~strcmp(char(el.localName()), "sldId")
                    continue
                end
                rid = mat2ppt.opc.rId_attr(el);
                if isempty(rid)
                    continue
                end
                pn = mat2ppt.opc.related_partname(pkg, "/ppt/presentation.xml", rid);
                elm = pkg.xml_part_element(pn);
                if isempty(elm)
                    error("mat2ppt:InvalidPackage", "Missing slide part %s", pn);
                end
                items{end+1} = mat2ppt.slide.Slide(elm, pn, obj.prs_); %#ok<AGROW>
            end
            obj.items_ = items;
        end
    end
end
