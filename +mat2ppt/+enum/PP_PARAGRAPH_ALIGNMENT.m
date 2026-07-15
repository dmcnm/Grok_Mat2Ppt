classdef PP_PARAGRAPH_ALIGNMENT
%PP_PARAGRAPH_ALIGNMENT  Paragraph alignment enumeration.
%
%   Ported from python-pptx 1.0.2: src/pptx/enum/text.py::PP_PARAGRAPH_ALIGNMENT
%   Phase 3 subset — members used by text API.

    properties (Constant)
        LEFT = mat2ppt.enum.BaseEnum("LEFT", 1)
        CENTER = mat2ppt.enum.BaseEnum("CENTER", 2)
        RIGHT = mat2ppt.enum.BaseEnum("RIGHT", 3)
        JUSTIFY = mat2ppt.enum.BaseEnum("JUSTIFY", 4)
        DISTRIBUTE = mat2ppt.enum.BaseEnum("DISTRIBUTE", 5)
        THAI_DISTRIBUTE = mat2ppt.enum.BaseEnum("THAI_DISTRIBUTE", 6)
        JUSTIFY_LOW = mat2ppt.enum.BaseEnum("JUSTIFY_LOW", 7)
    end
end
