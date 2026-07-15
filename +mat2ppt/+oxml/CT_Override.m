classdef CT_Override < mat2ppt.oxml.BaseOxmlElement
%CT_OVERRIDE  ct:Override content-types entry.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::CT_Override

    methods
        function obj = CT_Override(tag)
            if nargin < 1, tag = "ct:Override"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end
        function v = get.partName(obj)
            v = obj.get_attr_value("PartName", "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end
        function set.partName(obj, v)
            obj.set_attr_value("PartName", v, "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end
        function v = get.contentType(obj)
            v = obj.get_attr_value("ContentType", "mat2ppt.oxml.simpletypes.ST_ContentType");
        end
        function set.contentType(obj, v)
            obj.set_attr_value("ContentType", v, "mat2ppt.oxml.simpletypes.ST_ContentType");
        end
    end
    properties (Dependent)
        partName
        contentType
    end
end
