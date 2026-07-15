classdef CT_Default < mat2ppt.oxml.BaseOxmlElement
%CT_DEFAULT  ct:Default content-types entry.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::CT_Default

    methods
        function obj = CT_Default(tag)
            if nargin < 1, tag = "ct:Default"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end
        function v = get.extension(obj)
            v = obj.get_attr_value("Extension", "mat2ppt.oxml.simpletypes.ST_Extension");
        end
        function set.extension(obj, v)
            obj.set_attr_value("Extension", v, "mat2ppt.oxml.simpletypes.ST_Extension");
        end
        function v = get.contentType(obj)
            v = obj.get_attr_value("ContentType", "mat2ppt.oxml.simpletypes.ST_ContentType");
        end
        function set.contentType(obj, v)
            obj.set_attr_value("ContentType", v, "mat2ppt.oxml.simpletypes.ST_ContentType");
        end
    end
    properties (Dependent)
        extension
        contentType
    end
end
