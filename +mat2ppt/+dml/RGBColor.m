classdef RGBColor
%RGBCOLOR  sRGB color as three bytes 0..255.
%
%   c = mat2ppt.dml.RGBColor(r, g, b)
%   c.hex  % 'FF0000' style
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/color.py::RGBColor (subset)

    properties (SetAccess = private)
        r (1,1) double
        g (1,1) double
        b (1,1) double
    end

    properties (Dependent, SetAccess = private)
        hex
    end

    methods
        function obj = RGBColor(r, g, b)
            obj.r = double(r);
            obj.g = double(g);
            obj.b = double(b);
        end

        function h = get.hex(obj)
            h = upper(sprintf("%02X%02X%02X", obj.r, obj.g, obj.b));
        end

        function tf = eq(a, b)
            tf = a.r == b.r && a.g == b.g && a.b == b.b;
        end
    end

    methods (Static)
        function obj = from_string(s)
            s = char(string(s));
            if startsWith(s, "#"), s = s(2:end); end
            r = hex2dec(s(1:2));
            g = hex2dec(s(3:4));
            b = hex2dec(s(5:6));
            obj = mat2ppt.dml.RGBColor(r, g, b);
        end
    end
end
