classdef CT_SchemeColor < mat2ppt.oxml.BaseOxmlElement
%CT_SCHEMECOLOR  a:schemeClr element (P5-W10).
%
%   Ported from python-pptx oxml/dml/color.py::CT_SchemeColor

    methods
        function obj = CT_SchemeColor(tag)
            if nargin < 1, tag = "a:schemeClr"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end
        function v = get.val(obj)
            v = obj.get("val");
            if mat2ppt.isAbsent(v), v = ""; else, v = char(string(v)); end
        end
        function set.val(obj, v)
            obj.set("val", char(string(v)));
        end
    end
    properties (Dependent)
        val
    end
end
