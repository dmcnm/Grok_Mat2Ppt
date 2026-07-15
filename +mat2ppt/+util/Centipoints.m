classdef Centipoints < mat2ppt.util.Length
%CENTIPOINTS  Convenience constructor for length in hundredths of a point.
%
%   L = mat2ppt.util.Centipoints(centipoints)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Centipoints

    methods
        function obj = Centipoints(centipoints)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Centipoints requires a value.");
            end
            e = mat2ppt.util.Length.scaleToEmu_(centipoints, mat2ppt.util.Length.EMUS_PER_CENTIPOINT);
            obj@mat2ppt.util.Length(e);
        end
    end
end
