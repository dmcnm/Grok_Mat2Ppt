function tf = is_xml_part_content_type(ct)
%IS_XML_PART_CONTENT_TYPE  True if python-pptx PartFactory maps CT to XmlPart subclass.
%
%   Content types registered in pptx/__init__.py content_type_to_part_class_map
%   that use XmlPart (not base Part/Image/Media blob).

    ct = char(string(ct));
    xmlTypes = {
        'application/vnd.ms-powerpoint.presentation.macroEnabled.main+xml'
        'application/vnd.openxmlformats-officedocument.drawingml.chart+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.notesMaster+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.slide+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.slideshow.main+xml'
        'application/vnd.openxmlformats-officedocument.presentationml.template.main+xml'
        'application/vnd.openxmlformats-package.core-properties+xml'
        };
    tf = any(strcmp(ct, xmlTypes));
end
