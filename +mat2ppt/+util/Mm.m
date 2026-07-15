classdef Mm < mat2ppt.util.Length
%MM  Convenience constructor for length in millimeters.
%
%   L = mat2ppt.util.Mm(mm)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Mm

    methods
        function obj = Mm(mm)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Mm requires a value.");
            end
            e = mat2ppt.util.Length.scaleToEmu_(mm, mat2ppt.util.Length.EMUS_PER_MM);
            obj@mat2ppt.util.Length(e);
        end
    end
end
