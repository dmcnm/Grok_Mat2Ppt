function sp = new_freeform_sp(shapeId, name, x, y, cx, cy)
%NEW_FREEFORM_SP  p:sp with empty a:custGeom (python CT_Shape.new_freeform_sp).

    x = double(mat2ppt.util.Length.toEmuInt_(x));
    y = double(mat2ppt.util.Length.toEmuInt_(y));
    cx = double(mat2ppt.util.Length.toEmuInt_(cx));
    cy = double(mat2ppt.util.Length.toEmuInt_(cy));

    sp = mat2ppt.oxml.OxmlElement("p:sp");
    nv = mat2ppt.oxml.OxmlElement("p:nvSpPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(name)));
    nv.append(cNvPr);
    nv.append(mat2ppt.oxml.OxmlElement("p:cNvSpPr"));
    nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    sp.append(nv);

    spPr = mat2ppt.oxml.OxmlElement("p:spPr");
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(round(x))));
    off.set("y", char(string(round(y))));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(round(cx))));
    ext.set("cy", char(string(round(cy))));
    xfrm.append(off); xfrm.append(ext);
    spPr.append(xfrm);

    cust = mat2ppt.oxml.OxmlElement("a:custGeom");
    cust.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    cust.append(mat2ppt.oxml.OxmlElement("a:gdLst"));
    cust.append(mat2ppt.oxml.OxmlElement("a:ahLst"));
    cust.append(mat2ppt.oxml.OxmlElement("a:cxnLst"));
    rect = mat2ppt.oxml.OxmlElement("a:rect");
    rect.set("l", "l"); rect.set("t", "t"); rect.set("r", "r"); rect.set("b", "b");
    cust.append(rect);
    cust.append(mat2ppt.oxml.OxmlElement("a:pathLst"));
    spPr.append(cust);
    sp.append(spPr);

    style = mat2ppt.oxml.OxmlElement("p:style");
    lnRef = mat2ppt.oxml.OxmlElement("a:lnRef"); lnRef.set("idx", "1");
    sc = mat2ppt.oxml.OxmlElement("a:schemeClr"); sc.set("val", "accent1"); lnRef.append(sc);
    style.append(lnRef);
    fillRef = mat2ppt.oxml.OxmlElement("a:fillRef"); fillRef.set("idx", "3");
    sc2 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sc2.set("val", "accent1"); fillRef.append(sc2);
    style.append(fillRef);
    effectRef = mat2ppt.oxml.OxmlElement("a:effectRef"); effectRef.set("idx", "2");
    sc3 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sc3.set("val", "accent1"); effectRef.append(sc3);
    style.append(effectRef);
    fontRef = mat2ppt.oxml.OxmlElement("a:fontRef"); fontRef.set("idx", "minor");
    sc4 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sc4.set("val", "lt1"); fontRef.append(sc4);
    style.append(fontRef);
    sp.append(style);

    txBody = mat2ppt.oxml.OxmlElement("p:txBody");
    bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
    bodyPr.set("rtlCol", "0"); bodyPr.set("anchor", "ctr");
    txBody.append(bodyPr);
    txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    p = mat2ppt.oxml.OxmlElement("a:p");
    pPr = mat2ppt.oxml.OxmlElement("a:pPr"); pPr.set("algn", "ctr");
    p.append(pPr);
    txBody.append(p);
    sp.append(txBody);
end
