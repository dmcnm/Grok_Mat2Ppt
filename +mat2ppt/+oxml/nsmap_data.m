function m = nsmap_data()
%NSMAP_DATA  Prefix → namespace URI map for PowerPoint OOXML.
%
%   m = mat2ppt.oxml.nsmap_data()
%
%   Returns a containers.Map (char keys → char URIs). Private data for ns
%   helpers; mirrors python-pptx _nsmap.
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::_nsmap

    persistent cache
    if isempty(cache)
        keys = {
            'a', 'c', 'cp', 'ct', 'dc', 'dcmitype', 'dcterms', 'ep', 'i', 'm', ...
            'mo', 'mv', 'o', 'p', 'pd', 'pic', 'pr', 'r', 'sl', 'v', 've', ...
            'w', 'w10', 'wne', 'wp', 'xsi'
            };
        vals = {
            'http://schemas.openxmlformats.org/drawingml/2006/main'
            'http://schemas.openxmlformats.org/drawingml/2006/chart'
            'http://schemas.openxmlformats.org/package/2006/metadata/core-properties'
            'http://schemas.openxmlformats.org/package/2006/content-types'
            'http://purl.org/dc/elements/1.1/'
            'http://purl.org/dc/dcmitype/'
            'http://purl.org/dc/terms/'
            'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties'
            'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image'
            'http://schemas.openxmlformats.org/officeDocument/2006/math'
            'http://schemas.microsoft.com/office/mac/office/2008/main'
            'urn:schemas-microsoft-com:mac:vml'
            'urn:schemas-microsoft-com:office:office'
            'http://schemas.openxmlformats.org/presentationml/2006/main'
            'http://schemas.openxmlformats.org/drawingml/2006/presentationDrawing'
            'http://schemas.openxmlformats.org/drawingml/2006/picture'
            'http://schemas.openxmlformats.org/package/2006/relationships'
            'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
            'http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout'
            'urn:schemas-microsoft-com:vml'
            'http://schemas.openxmlformats.org/markup-compatibility/2006'
            'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
            'urn:schemas-microsoft-com:office:word'
            'http://schemas.microsoft.com/office/word/2006/wordml'
            'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing'
            'http://www.w3.org/2001/XMLSchema-instance'
            };
        cache = containers.Map(keys, vals, 'UniformValues', true);
    end
    m = cache;
end
