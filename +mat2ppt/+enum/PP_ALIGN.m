classdef PP_ALIGN
%PP_ALIGN  Alias of mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.
%
%   Ported from python-pptx 1.0.2: PP_ALIGN = PP_PARAGRAPH_ALIGNMENT

    properties (Constant)
        CENTER = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.CENTER
        DISTRIBUTE = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.DISTRIBUTE
        JUSTIFY = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.JUSTIFY
        JUSTIFY_LOW = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.JUSTIFY_LOW
        LEFT = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.LEFT
        RIGHT = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.RIGHT
        THAI_DISTRIBUTE = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.THAI_DISTRIBUTE
        MIXED = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.to_xml(value);
        end
    end
end
