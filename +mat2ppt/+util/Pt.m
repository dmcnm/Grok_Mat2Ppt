classdef Pt < mat2ppt.util.Length
%PT  Convenience constructor for length in points.
%
%   L = mat2ppt.util.Pt(points)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Pt

    methods
        function obj = Pt(points)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Pt requires a value.");
            end
            e = mat2ppt.util.Length.scaleToEmu_(points, mat2ppt.util.Length.EMUS_PER_PT);
            obj@mat2ppt.util.Length(e);
        end
    end
end
