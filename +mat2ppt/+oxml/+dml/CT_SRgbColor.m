classdef CT_SRgbColor < mat2ppt.oxml.BaseOxmlElement
%CT_SRGBCOLOR  a:srgbClr element.
%
%   Ported from python-pptx 1.0.2: oxml/dml/color.py::CT_SRgbColor (P5-W10)

    methods
        function obj = CT_SRgbColor(tag)
            if nargin < 1, tag = "a:srgbClr"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end
        function v = get.val(obj)
            v = obj.get_attr_value("val", "mat2ppt.oxml.simpletypes.ST_HexColorRGB");
        end
        function set.val(obj, v)
            obj.set_attr_value("val", v, "mat2ppt.oxml.simpletypes.ST_HexColorRGB");
        end
    end
    properties (Dependent)
        val
    end
    methods (Static)
        function obj = new(hexStr)
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            obj = mat2ppt.oxml.dml.CT_SRgbColor(sprintf("{%s}srgbClr", A));
            obj.val = hexStr;
        end
    end
end
