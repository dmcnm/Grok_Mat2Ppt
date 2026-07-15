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
    end

    methods (Access = private)
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
