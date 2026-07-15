classdef PresentationPart < mat2ppt.opc.XmlPart
%PRESENTATIONPART  Thin XmlPart for presentation main (M1).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/presentation.py (shell)

    methods
        function obj = PresentationPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.PresentationPart(partname, contentType, package, elm);
        end
    end
end
