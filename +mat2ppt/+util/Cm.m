classdef Cm < mat2ppt.util.Length
%CM  Convenience constructor for length in centimeters.
%
%   L = mat2ppt.util.Cm(cm)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Cm

    methods
        function obj = Cm(cm)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Cm requires a value.");
            end
            e = mat2ppt.util.Length.scaleToEmu_(cm, mat2ppt.util.Length.EMUS_PER_CM);
            obj@mat2ppt.util.Length(e);
        end
    end
end
