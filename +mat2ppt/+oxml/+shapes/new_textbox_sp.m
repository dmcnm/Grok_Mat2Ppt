function sp = new_textbox_sp(shapeId, name, left, top, width, height)
%NEW_TEXTBOX_SP  p:sp text box (python CT_Shape.new_textbox_sp).

    left = double(mat2ppt.util.Length.toEmuInt_(left));
    top = double(mat2ppt.util.Length.toEmuInt_(top));
    width = double(mat2ppt.util.Length.toEmuInt_(width));
    height = double(mat2ppt.util.Length.toEmuInt_(height));

    sp = mat2ppt.oxml.OxmlElement("p:sp");
    nvSpPr = mat2ppt.oxml.OxmlElement("p:nvSpPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(name)));
    nvSpPr.append(cNvPr);
    cNvSpPr = mat2ppt.oxml.OxmlElement("p:cNvSpPr");
    cNvSpPr.set("txBox", "1");
    nvSpPr.append(cNvSpPr);
    nvSpPr.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    sp.append(nvSpPr);

    spPr = mat2ppt.oxml.OxmlElement("p:spPr");
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(round(left))));
    off.set("y", char(string(round(top))));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(round(width))));
    ext.set("cy", char(string(round(height))));
    xfrm.append(off);
    xfrm.append(ext);
    spPr.append(xfrm);
    prstGeom = mat2ppt.oxml.OxmlElement("a:prstGeom");
    prstGeom.set("prst", "rect");
    prstGeom.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    spPr.append(prstGeom);
    spPr.append(mat2ppt.oxml.OxmlElement("a:noFill"));
    sp.append(spPr);

    txBody = mat2ppt.oxml.OxmlElement("p:txBody");
    bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
    bodyPr.set("wrap", "none");
    bodyPr.append(mat2ppt.oxml.OxmlElement("a:spAutoFit"));
    txBody.append(bodyPr);
    txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    txBody.append(mat2ppt.oxml.OxmlElement("a:p"));
    sp.append(txBody);
end
