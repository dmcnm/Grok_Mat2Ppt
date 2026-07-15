function tf = has_rel_type(pkg, sourcePartname, reltype)
%HAS_REL_TYPE  True if source part has a relationship of the given Type.
    src = mat2ppt.opc.PackURI(char(string(sourcePartname)));
    relsPn = char(src.rels_uri);
    relsElm = pkg.xml_part_element(relsPn);
    if isempty(relsElm)
        tf = false;
        return
    end
    reltype = char(string(reltype));
    kids = relsElm.getchildren();
    for i = 1:numel(kids)
        el = kids{i};
        if ~strcmp(char(el.localName()), "Relationship")
            continue
        end
        t = el.get("Type");
        if ~mat2ppt.isAbsent(t) && strcmp(char(string(t)), reltype)
            tf = true;
            return
        end
    end
    tf = false;
end
