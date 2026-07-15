classdef SlideLayoutPart < mat2ppt.opc.XmlPart
%SLIDELAYOUTPART  Thin XmlPart for slide layout (M1).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/slide.py::SlideLayoutPart (shell)

    methods
        function obj = SlideLayoutPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.SlideLayoutPart(partname, contentType, package, elm);
        end
    end
end
