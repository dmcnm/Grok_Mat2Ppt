function root = parse_xml(xml)
%PARSE_XML  Parse XML into XmlElement tree (order-preserving OOXML subset).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/__init__.py::parse_xml

    if isstring(xml)
        s = char(xml);
    elseif ischar(xml)
        s = xml(:).';
    else
        u = uint8(xml(:))';
        s = native2unicode(u, "UTF-8");
        s = char(s);
        s = s(:).';
    end
    if ~isempty(s) && s(1) == char(65279)
        s = s(2:end);
    end
    s = strrep(s, char([13 10]), char(10));
    s = strrep(s, char(13), char(10));

    [root, ~] = mat2ppt.oxml.parse_xml_doc_(s, 1);
end
