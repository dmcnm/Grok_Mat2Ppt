classdef NotesMasterPart < mat2ppt.opc.XmlPart
%NOTESMASTERPART  Thin XmlPart (M1 shell).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/slide.py::NotesMasterPart

    methods
        function obj = NotesMasterPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.NotesMasterPart(partname, contentType, package, elm);
        end
    end
end
