classdef NotesSlidePart < mat2ppt.opc.XmlPart
%NOTESSLIDEPART  Thin XmlPart (M1 shell).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/slide.py::NotesSlidePart

    methods
        function obj = NotesSlidePart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.NotesSlidePart(partname, contentType, package, elm);
        end
    end
end
