function bytesOut = serialize_part_xml(part_elm)
%SERIALIZE_PART_XML  UTF-8 XML bytes matching lxml etree.tostring UTF-8 standalone.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::serialize_part_xml

    arguments
        part_elm (1,1) mat2ppt.oxml.XmlElement
    end

    % Collect all namespace URIs used in the tree (tags + clark attrs)
    usedUris = mat2ppt.oxml.collect_ns_uris_(part_elm);

    % Build prefix map for this part (lxml-compatible)
    [pfxOfUri, rootDecls] = mat2ppt.oxml.ns_plan_for_part_(part_elm, usedUris);

    body = mat2ppt.oxml.serialize_element_lxml_(part_elm, pfxOfUri, rootDecls, true);
    decl = "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" + newline;
    xmlStr = decl + body;
    bytesOut = uint8(unicode2native(char(xmlStr), "UTF-8"));
end
