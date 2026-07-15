classdef BaseShape < mat2ppt.shared.ParentedElementProxy
%BASESHAPE  Common shape members (python-pptx shapes.base.BaseShape shell).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/base.py::BaseShape
%   P5-W1 — transform/name accessors; full behavior grows with oxml shape CT_*.

    properties (Access = protected)
        sp_
    end

    properties (Dependent)
        name
    end

    methods
        function obj = BaseShape(sp, parent)
            arguments
                sp (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ParentedElementProxy(sp, parent);
            obj.sp_ = sp;
        end

        function n = shape_id(obj)
            %SHAPE_ID  Integer shape id from p:cNvPr/@id when present.
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr)
                n = [];
                return
            end
            raw = cNvPr.get("id");
            if mat2ppt.isAbsent(raw)
                n = [];
            else
                n = str2double(raw);
            end
        end

        function n = get.name(obj)
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr)
                n = "";
                return
            end
            raw = cNvPr.get("name");
            if mat2ppt.isAbsent(raw)
                n = "";
            else
                n = string(raw);
            end
        end

        function set.name(obj, value)
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr)
                error("mat2ppt:InvalidXmlError", "Shape has no cNvPr for name");
            end
            cNvPr.set("name", char(string(value)));
        end
    end

    methods (Access = private)
        function el = find_cNvPr_(obj)
            el = [];
            kids = obj.sp_.getchildren();
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                if startsWith(string(ln), "nv")
                    c = kids{i}.find("p:cNvPr");
                    if ~isempty(c)
                        el = c;
                        return
                    end
                    gc = kids{i}.getchildren();
                    for j = 1:numel(gc)
                        if strcmp(char(gc{j}.localName()), "cNvPr")
                            el = gc{j};
                            return
                        end
                    end
                end
            end
        end
    end
end
