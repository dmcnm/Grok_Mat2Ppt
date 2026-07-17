function id = slide_id_for_partname_(prs, partname)
%SLIDE_ID_FOR_PARTNAME_  p:sldId/@id for slide partname, or error if missing.
    partname = char(string(partname));
    pkg = prs.package();
    presPn = "/ppt/presentation.xml";
    presElm = prs.presentation_element();
    sldIdLst = presElm.find("p:sldIdLst");
    if isempty(sldIdLst)
        kids = presElm.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "sldIdLst")
                sldIdLst = kids{i};
                break
            end
        end
    end
    if isempty(sldIdLst)
        error("mat2ppt:ValueError", "Presentation has no sldIdLst; cannot resolve slide_id.");
    end
    for i = 1:numel(sldIdLst.getchildren())
        el = sldIdLst.child(i);
        if ~strcmp(char(el.localName()), "sldId")
            continue
        end
        rid = mat2ppt.opc.rId_attr(el);
        if isempty(rid)
            continue
        end
        pn = mat2ppt.opc.related_partname(pkg, presPn, rid);
        if strcmp(char(string(pn)), partname)
            raw = el.get("id");
            if mat2ppt.isAbsent(raw)
                error("mat2ppt:InvalidPackage", "sldId missing id attribute");
            end
            id = str2double(string(raw));
            return
        end
    end
    error("mat2ppt:ValueError", "No sldId entry for slide part %s", partname);
end
