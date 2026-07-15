classdef RELATIONSHIP_TYPE
%RELATIONSHIP_TYPE  Office Open XML relationship type URIs (subset).
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/constants.py::RELATIONSHIP_TYPE

    properties (Constant)
        SLIDE = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"
        SLIDE_LAYOUT = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"
        SLIDE_MASTER = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"
        NOTES_SLIDE = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesSlide"
        NOTES_MASTER = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesMaster"
        IMAGE = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"
        THEME = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
        HYPERLINK = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink"
    end
end


