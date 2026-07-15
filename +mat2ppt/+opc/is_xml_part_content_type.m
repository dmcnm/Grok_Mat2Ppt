function tf = is_xml_part_content_type(ct)
%IS_XML_PART_CONTENT_TYPE  True if PartFactory maps CT to an XmlPart subclass.
%
%   Matches python-pptx: registered XmlPart types re-serialize; Image/Media/Part opaque.

    tf = mat2ppt.opc.PartFactory.is_xml_part_class(ct);
end
