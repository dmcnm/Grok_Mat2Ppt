classdef SlidePart < mat2ppt.opc.XmlPart
%SLIDEPART  Thin XmlPart for slide (M1 shell; authoring in P6).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/slide.py::SlidePart (shell)

    methods
        function obj = SlidePart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.SlidePart(partname, contentType, package, elm);
        end
    end
end
