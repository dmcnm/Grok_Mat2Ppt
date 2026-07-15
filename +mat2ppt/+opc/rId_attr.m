function rid = rId_attr(elm)
%RID_ATTR  Read r:id relationship attribute (Clark or prefixed).
    rid = elm.get(mat2ppt.oxml.qn("r:id"));
    if mat2ppt.isAbsent(rid)
        rid = elm.get("r:id");
    end
    if mat2ppt.isAbsent(rid)
        rid = [];
    else
        rid = char(string(rid));
    end
end
