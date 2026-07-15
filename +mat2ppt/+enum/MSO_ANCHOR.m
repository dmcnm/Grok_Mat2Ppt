classdef MSO_ANCHOR
%MSO_ANCHOR  Alias of mat2ppt.enum.MSO_VERTICAL_ANCHOR.
%
%   Ported from python-pptx 1.0.2: MSO_ANCHOR = MSO_VERTICAL_ANCHOR

    properties (Constant)
        TOP = mat2ppt.enum.MSO_VERTICAL_ANCHOR.TOP
        MIDDLE = mat2ppt.enum.MSO_VERTICAL_ANCHOR.MIDDLE
        BOTTOM = mat2ppt.enum.MSO_VERTICAL_ANCHOR.BOTTOM
        MIXED = mat2ppt.enum.MSO_VERTICAL_ANCHOR.MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.MSO_VERTICAL_ANCHOR.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.MSO_VERTICAL_ANCHOR.to_xml(value);
        end
    end
end
