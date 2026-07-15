classdef SlideLayouts < mat2ppt.shared.Collection
%SLIDELAYOUTS  1-based layouts belonging to a slide master.
%
%   Ported from python-pptx 1.0.2: src/pptx/slide.py::SlideLayouts (P6-W2)

    properties (Access = private)
        master_
    end

    methods
        function obj = SlideLayouts(master)
            arguments
                master (1,1) mat2ppt.slide.SlideMaster
            end
            obj.master_ = master;
            obj.rebuild_();
        end

        function lay = get_by_name(obj, name, default)
            %GET_BY_NAME  First layout with matching cSld name (or default).
            if nargin < 3
                default = [];
            end
            name = string(name);
            for i = 1:obj.length
                lay = obj.item(i);
                if lay.name == name
                    return
                end
            end
            lay = default;
        end
    end

    methods (Access = private)
        function rebuild_(obj)
            master = obj.master_;
            pkg = master.part().package;
            masterPn = master.partname();
            elm = master.element();
            lst = elm.find("p:sldLayoutIdLst");
            if isempty(lst)
                kids = elm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "sldLayoutIdLst")
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
            prs = master.presentation();
            for i = 1:numel(lst.getchildren())
                el = lst.child(i);
                if ~strcmp(char(el.localName()), "sldLayoutId")
                    continue
                end
                rid = mat2ppt.opc.rId_attr(el);
                if isempty(rid)
                    continue
                end
                pn = mat2ppt.opc.related_partname(pkg, masterPn, rid);
                layElm = pkg.xml_part_element(pn);
                if isempty(layElm)
                    error("mat2ppt:InvalidPackage", "Missing layout %s", pn);
                end
                items{end+1} = mat2ppt.slide.SlideLayout(layElm, pn, prs, masterPn); %#ok<AGROW>
            end
            obj.items_ = items;
        end
    end
end
