function partname = related_partname_by_type(pkg, sourcePartname, reltype)
%RELATED_PARTNAME_BY_TYPE  First internal target of given relationship Type.
    src = mat2ppt.opc.PackURI(char(string(sourcePartname)));
    relsPn = char(src.rels_uri);
    relsElm = pkg.xml_part_element(relsPn);
    if isempty(relsElm)
        error("mat2ppt:KeyError", "No relationships for %s", char(src));
    end
    reltype = char(string(reltype));
    kids = relsElm.getchildren();
    for i = 1:numel(kids)
        el = kids{i};
        if ~strcmp(char(el.localName()), "Relationship")
            continue
        end
        t = el.get("Type");
        if mat2ppt.isAbsent(t) || ~strcmp(char(string(t)), reltype)
            continue
        end
        target = el.get("Target");
        if mat2ppt.isAbsent(target)
            continue
        end
        absu = mat2ppt.opc.PackURI.from_rel_ref(src.baseURI, char(string(target)));
        partname = char(absu);
        return
    end
    error("mat2ppt:KeyError", "No relationship type %s on %s", reltype, char(src));
end
