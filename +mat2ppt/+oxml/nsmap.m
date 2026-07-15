function m = nsmap(varargin)
%NSMAP  Alias for namespaces (compact use with element factories).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::nsmap

    m = mat2ppt.oxml.namespaces(varargin{:});
end
