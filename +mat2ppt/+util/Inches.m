classdef Inches < mat2ppt.util.Length
%INCHES  Convenience constructor for length in inches.
%
%   L = mat2ppt.util.Inches(inches)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Inches

    methods
        function obj = Inches(inches)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Inches requires a value.");
            end
            e = mat2ppt.util.Length.scaleToEmu_(inches, mat2ppt.util.Length.EMUS_PER_INCH);
            obj@mat2ppt.util.Length(e);
        end
    end
end
