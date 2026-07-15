function e = OxmlElement(nsptag_str, nsmap)
%OXMLELEMENT  Create a loose element for a namespace-prefixed tag.
%
%   e = mat2ppt.oxml.OxmlElement("a:t")
%
%   Tag is stored as Clark name. Optional nsmap reserved for future nsdecl
%   tracking (currently unused; serializer invents decls from tag/attrs).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/xmlchemy.py::OxmlElement

    if nargin < 2
        nsmap = []; %#ok<NASGU>
    end
    e = mat2ppt.oxml.XmlElement(nsptag_str);
end
