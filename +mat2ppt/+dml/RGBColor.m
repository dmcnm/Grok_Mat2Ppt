classdef RGBColor
%RGBCOLOR  sRGB color as three bytes 0..255 (immutable value object).
%
%   c = mat2ppt.dml.RGBColor(r, g, b)
%   c.hex  % 'FF0000' style (also char(c) / string(c))
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/color.py::RGBColor

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
            r = double(r); g = double(g); b = double(b);
            for v = [r, g, b]
                if v ~= floor(v) || v < 0 || v > 255
                    error("mat2ppt:ValueError", ...
                        "RGBColor() takes three integer values 0-255");
                end
            end
            obj.r = r;
            obj.g = g;
            obj.b = b;
        end

        function h = get.hex(obj)
            h = string(upper(sprintf("%02X%02X%02X", obj.r, obj.g, obj.b)));
        end

        function s = char(obj)
            s = char(obj.hex);
        end

        function s = string(obj)
            s = string(obj.hex);
        end

        function tf = eq(a, b)
            if ~isa(b, "mat2ppt.dml.RGBColor")
                tf = false;
                return
            end
            tf = a.r == b.r && a.g == b.g && a.b == b.b;
        end
    end

    methods (Static)
        function obj = from_string(s)
            s = char(string(s));
            if startsWith(s, "#"), s = s(2:end); end
            if numel(s) ~= 6
                error("mat2ppt:ValueError", "RGB hex string must be 6 hex digits");
            end
            r = hex2dec(s(1:2));
            g = hex2dec(s(3:4));
            b = hex2dec(s(5:6));
            obj = mat2ppt.dml.RGBColor(r, g, b);
        end
    end
end
