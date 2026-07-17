function grpSp = new_grpSp(shapeId, name)
%NEW_GRPSP  Empty p:grpSp (python CT_GroupShape.new_grpSp).

    grpSp = mat2ppt.oxml.OxmlElement("p:grpSp");
    nv = mat2ppt.oxml.OxmlElement("p:nvGrpSpPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(name)));
    nv.append(cNvPr);
    nv.append(mat2ppt.oxml.OxmlElement("p:cNvGrpSpPr"));
    nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    grpSp.append(nv);

    grpSpPr = mat2ppt.oxml.OxmlElement("p:grpSpPr");
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", "0"); off.set("y", "0");
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", "0"); ext.set("cy", "0");
    chOff = mat2ppt.oxml.OxmlElement("a:chOff");
    chOff.set("x", "0"); chOff.set("y", "0");
    chExt = mat2ppt.oxml.OxmlElement("a:chExt");
    chExt.set("cx", "0"); chExt.set("cy", "0");
    xfrm.append(off); xfrm.append(ext); xfrm.append(chOff); xfrm.append(chExt);
    grpSpPr.append(xfrm);
    grpSp.append(grpSpPr);
end
