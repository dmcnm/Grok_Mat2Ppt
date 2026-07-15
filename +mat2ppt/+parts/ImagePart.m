classdef ImagePart < mat2ppt.opc.Part
%IMAGEPART  Opaque image part (blob; M1 shell).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/image.py::ImagePart

    methods
        function obj = ImagePart(partname, contentType, package, blob)
            obj@mat2ppt.opc.Part(partname, contentType, package, blob);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            obj = mat2ppt.parts.ImagePart(partname, contentType, package, blob);
        end
    end
end
