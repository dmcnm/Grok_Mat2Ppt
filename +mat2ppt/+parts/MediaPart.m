classdef MediaPart < mat2ppt.opc.Part
%MEDIAPART  Opaque media part (blob; M1 shell).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/media.py::MediaPart

    methods
        function obj = MediaPart(partname, contentType, package, blob)
            obj@mat2ppt.opc.Part(partname, contentType, package, blob);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            obj = mat2ppt.parts.MediaPart(partname, contentType, package, blob);
        end
    end
end
