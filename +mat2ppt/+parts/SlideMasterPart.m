classdef SlideMasterPart < mat2ppt.opc.XmlPart
%SLIDEMASTERPART  Thin XmlPart for slide master (M1).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/slide.py::SlideMasterPart (shell)

    methods
        function obj = SlideMasterPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.SlideMasterPart(partname, contentType, package, elm);
        end
    end
end
