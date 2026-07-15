function m = pfxmap_data()
%PFXMAP_DATA  Namespace URI → prefix map (inverse of nsmap_data).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::pfxmap

    persistent cache
    if isempty(cache)
        forward = mat2ppt.oxml.nsmap_data();
        pfxKeys = forward.keys;   % cell of prefixes
        uriVals = forward.values; % cell of URIs
        % invert: URI → prefix
        cache = containers.Map(uriVals, pfxKeys, 'UniformValues', true);
    end
    m = cache;
end
