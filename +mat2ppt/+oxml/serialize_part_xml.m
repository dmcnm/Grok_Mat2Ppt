function bytesOut = serialize_part_xml(part_elm)
%SERIALIZE_PART_XML  UTF-8 XML bytes with standalone declaration (part file).
%
%   bytesOut = mat2ppt.oxml.serialize_part_xml(elm)
%
%   Matches lxml etree.tostring(..., encoding='UTF-8', standalone=True)
%   as used by python-pptx opc.oxml.serialize_part_xml — including single
%   quotes in the XML declaration when that is lxml's output form.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::serialize_part_xml

    arguments
        part_elm (1,1) mat2ppt.oxml.XmlElement
    end

    body = mat2ppt.oxml.serialize_element_(part_elm, containers.Map('KeyType','char','ValueType','char'));
    % lxml 5.3.0 / python-pptx: single-quoted declaration + newline before root
    decl = "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" + newline;
    xmlStr = decl + body;
    bytesOut = unicode2native(char(xmlStr), "UTF-8");
    bytesOut = uint8(bytesOut);
end
