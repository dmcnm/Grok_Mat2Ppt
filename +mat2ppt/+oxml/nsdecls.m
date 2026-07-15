function s = nsdecls(varargin)
%NSDECLS  Space-separated xmlns:pfx="uri" declarations in prefix order.
%
%   s = mat2ppt.oxml.nsdecls("a", "p")
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::nsdecls

    full = mat2ppt.oxml.nsmap_data();
    parts = strings(1, nargin);
    for i = 1:nargin
        pfx = char(string(varargin{i}));
        if ~isKey(full, pfx)
            error("mat2ppt:UnknownNamespacePrefix", ...
                "Unknown namespace prefix '%s'.", pfx);
        end
        parts(i) = sprintf('xmlns:%s="%s"', pfx, full(pfx));
    end
    s = char(join(parts, " "));
end
