function clark = qn(namespace_prefixed_tag)
%QN  Clark-notation qualified name for a prefix:local tag.
%
%   clark = mat2ppt.oxml.qn("p:cSld")
%   % -> "{http://schemas.openxmlformats.org/presentationml/2006/main}cSld"
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::qn

    nsptag = mat2ppt.oxml.NamespacePrefixedTag(namespace_prefixed_tag);
    clark = nsptag.clark_name;
end
