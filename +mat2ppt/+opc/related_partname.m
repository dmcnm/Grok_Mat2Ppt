function partname = related_partname(pkg, sourcePartname, rId)
%RELATED_PARTNAME  Absolute pack URI of internal relationship target.
%
%   partname = mat2ppt.opc.related_partname(pkg, "/ppt/presentation.xml", "rId1")
%
%   P6-W2: read-only rel navigation for slides/masters/layouts (no add_rel yet).

    arguments
        pkg (1,1) mat2ppt.opc.OpcPackage
        sourcePartname
        rId
    end
    rId = char(string(rId));
    src = mat2ppt.opc.PackURI(char(string(sourcePartname)));
    relsPn = char(src.rels_uri);
    relsElm = pkg.xml_part_element(relsPn);
    if isempty(relsElm)
        error("mat2ppt:KeyError", "No relationships part for %s", char(src));
    end
    kids = relsElm.getchildren();
    for i = 1:numel(kids)
        el = kids{i};
        if ~strcmp(char(el.localName()), "Relationship")
            continue
        end
        id = el.get("Id");
        if mat2ppt.isAbsent(id) || ~strcmp(char(string(id)), rId)
            continue
        end
        mode = el.get("TargetMode");
        if ~mat2ppt.isAbsent(mode) && strcmpi(char(string(mode)), "External")
            error("mat2ppt:ValueError", "Relationship %s is External", rId);
        end
        target = el.get("Target");
        if mat2ppt.isAbsent(target)
            error("mat2ppt:InvalidPackage", "Relationship %s missing Target", rId);
        end
        absu = mat2ppt.opc.PackURI.from_rel_ref(src.baseURI, char(string(target)));
        partname = char(absu);
        return
    end
    error("mat2ppt:KeyError", "No relationship %s on %s", rId, char(src));
end
