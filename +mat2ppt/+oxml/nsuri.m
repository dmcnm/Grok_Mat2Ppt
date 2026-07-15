function uri = nsuri(nspfx)
%NSURI  Namespace URI for a prefix.
%
%   uri = mat2ppt.oxml.nsuri("p")
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::nsuri

    m = mat2ppt.oxml.nsmap_data();
    pfx = char(string(nspfx));
    if ~isKey(m, pfx)
        error("mat2ppt:UnknownNamespacePrefix", ...
            "Unknown namespace prefix '%s'.", pfx);
    end
    uri = m(pfx);
end
