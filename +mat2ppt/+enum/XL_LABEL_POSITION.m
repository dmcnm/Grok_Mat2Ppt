classdef XL_LABEL_POSITION
%XL_LABEL_POSITION  Alias of mat2ppt.enum.XL_DATA_LABEL_POSITION.
%
%   Ported from python-pptx 1.0.2: XL_LABEL_POSITION = XL_DATA_LABEL_POSITION

    properties (Constant)
        ABOVE = mat2ppt.enum.XL_DATA_LABEL_POSITION.ABOVE
        BELOW = mat2ppt.enum.XL_DATA_LABEL_POSITION.BELOW
        BEST_FIT = mat2ppt.enum.XL_DATA_LABEL_POSITION.BEST_FIT
        CENTER = mat2ppt.enum.XL_DATA_LABEL_POSITION.CENTER
        INSIDE_BASE = mat2ppt.enum.XL_DATA_LABEL_POSITION.INSIDE_BASE
        INSIDE_END = mat2ppt.enum.XL_DATA_LABEL_POSITION.INSIDE_END
        LEFT = mat2ppt.enum.XL_DATA_LABEL_POSITION.LEFT
        MIXED = mat2ppt.enum.XL_DATA_LABEL_POSITION.MIXED
        OUTSIDE_END = mat2ppt.enum.XL_DATA_LABEL_POSITION.OUTSIDE_END
        RIGHT = mat2ppt.enum.XL_DATA_LABEL_POSITION.RIGHT
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.XL_DATA_LABEL_POSITION.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.XL_DATA_LABEL_POSITION.to_xml(value);
        end
    end
end
