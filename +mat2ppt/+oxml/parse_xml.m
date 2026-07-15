function root = parse_xml(xml)
%PARSE_XML  Parse XML string/bytes into mat2ppt.oxml.XmlElement tree.
%
%   root = mat2ppt.oxml.parse_xml(xml)
%
%   OOXML-oriented subset: elements, attributes, text, namespaces.
%   Uses Java DocumentBuilder (available in base MATLAB) as the tokenizer
%   front-end, then maps to XmlElement with document order preserved.
%   remove_blank_text-like behavior is NOT applied here (caller/parser
%   flags may refine later to match lxml oxml_parser).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/__init__.py::parse_xml
%   (behavior twin; implementation uses Java DOM in base MATLAB).

    if isstring(xml) || ischar(xml)
        xmlBytes = unicode2native(char(xml), "UTF-8");
    else
        xmlBytes = uint8(xml);
    end

    % Java parse
    factory = javaMethod("newInstance", "javax.xml.parsers.DocumentBuilderFactory");
    factory.setNamespaceAware(true);
    factory.setValidating(false);
    try
        factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
    catch
    end
    builder = factory.newDocumentBuilder();
    jbytes = xmlBytes(:);
    bis = java.io.ByteArrayInputStream(jbytes);
    try
        doc = builder.parse(bis);
    catch ME
        error("mat2ppt:XMLSyntaxError", "XML parse failed: %s", ME.message);
    end
    jroot = doc.getDocumentElement();
    root = mat2ppt.oxml.java_node_to_element_(jroot);
end
