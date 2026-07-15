classdef Emu < mat2ppt.util.Length
%EMU  Convenience constructor for length in English Metric Units.
%
%   L = mat2ppt.util.Emu(emu)
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Emu

    methods
        function obj = Emu(emu)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Emu requires a value.");
            end
            % Python: Length.__new__(cls, int(emu))
            e = mat2ppt.util.Length.toEmuInt_(emu);
            obj@mat2ppt.util.Length(e);
        end
    end
end
