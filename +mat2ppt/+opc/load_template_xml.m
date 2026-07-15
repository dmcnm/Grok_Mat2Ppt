function elm = load_template_xml(name)
%LOAD_TEMPLATE_XML  Parse a resources/templates XML file to XmlElement.
    path = mat2ppt.template_path(name);
    fid = fopen(path, "rb");
    if fid < 0
        error("mat2ppt:TemplateNotFound", "Cannot open template %s", path);
    end
    cleaner = onCleanup(@() fclose(fid));
    bytes = fread(fid, inf, "*uint8");
    elm = mat2ppt.oxml.parse_xml(bytes);
end
