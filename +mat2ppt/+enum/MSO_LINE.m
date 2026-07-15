classdef MSO_LINE
%MSO_LINE  Alias of mat2ppt.enum.MSO_LINE_DASH_STYLE.
%
%   Ported from python-pptx 1.0.2: MSO_LINE = MSO_LINE_DASH_STYLE

    properties (Constant)
        DASH = mat2ppt.enum.MSO_LINE_DASH_STYLE.DASH
        DASH_DOT = mat2ppt.enum.MSO_LINE_DASH_STYLE.DASH_DOT
        DASH_DOT_DOT = mat2ppt.enum.MSO_LINE_DASH_STYLE.DASH_DOT_DOT
        LONG_DASH = mat2ppt.enum.MSO_LINE_DASH_STYLE.LONG_DASH
        LONG_DASH_DOT = mat2ppt.enum.MSO_LINE_DASH_STYLE.LONG_DASH_DOT
        ROUND_DOT = mat2ppt.enum.MSO_LINE_DASH_STYLE.ROUND_DOT
        SOLID = mat2ppt.enum.MSO_LINE_DASH_STYLE.SOLID
        SQUARE_DOT = mat2ppt.enum.MSO_LINE_DASH_STYLE.SQUARE_DOT
        DASH_STYLE_MIXED = mat2ppt.enum.MSO_LINE_DASH_STYLE.DASH_STYLE_MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.MSO_LINE_DASH_STYLE.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.MSO_LINE_DASH_STYLE.to_xml(value);
        end
    end
end
