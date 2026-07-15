classdef SlideMasters < mat2ppt.shared.Collection
%SLIDEMASTERS  1-based collection of slide masters.
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::SlideMasters (P6-W2)

    properties (Access = private)
        prs_
    end

    methods
        function obj = SlideMasters(prs)
            obj.prs_ = prs;
            obj.rebuild_();
        end
    end

    methods (Access = private)
        function rebuild_(obj)
            pkg = obj.prs_.package();
            presElm = obj.prs_.presentation_element();
            lst = presElm.find("p:sldMasterIdLst");
            if isempty(lst)
                kids = presElm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "sldMasterIdLst")
                        lst = kids{i};
                        break
                    end
                end
            end
            items = {};
            if isempty(lst)
                obj.items_ = items;
                return
            end
            for i = 1:numel(lst.getchildren())
                el = lst.child(i);
                if ~strcmp(char(el.localName()), "sldMasterId")
                    continue
                end
                rid = mat2ppt.opc.rId_attr(el);
                if isempty(rid)
                    continue
                end
                pn = mat2ppt.opc.related_partname(pkg, "/ppt/presentation.xml", rid);
                elm = pkg.xml_part_element(pn);
                if isempty(elm)
                    error("mat2ppt:InvalidPackage", "Missing slide master %s", pn);
                end
                items{end+1} = mat2ppt.slide.SlideMaster(elm, pn, obj.prs_); %#ok<AGROW>
            end
            obj.items_ = items;
        end
    end
end
