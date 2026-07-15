function m = namespaces(varargin)
%NAMESPACES  Subset map of namespace prefixes to URIs.
%
%   m = mat2ppt.oxml.namespaces("a", "p")
%
%   Returns containers.Map. Alias: mat2ppt.oxml.nsmap (same function).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::namespaces

    full = mat2ppt.oxml.nsmap_data();
    keys = cell(1, nargin);
    vals = cell(1, nargin);
    for i = 1:nargin
        pfx = char(string(varargin{i}));
        if ~isKey(full, pfx)
            error("mat2ppt:UnknownNamespacePrefix", ...
                "Unknown namespace prefix '%s'.", pfx);
        end
        keys{i} = pfx;
        vals{i} = full(pfx);
    end
    if nargin == 0
        m = containers.Map('KeyType', 'char', 'ValueType', 'char');
    else
        m = containers.Map(keys, vals, 'UniformValues', true);
    end
end
