function sp = new_sp(shapeId, name, left, top, width, height, prst)
%NEW_SP  p:sp autoshape (python CT_Shape.new_autoshape_sp).
%
%   Includes p:style and centered bodyPr like python-pptx 1.0.2.

    if nargin < 7 || mat2ppt.isAbsent(prst)
        prst = "rect";
    end
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
    nvSpPr.append(mat2ppt.oxml.OxmlElement("p:cNvSpPr"));
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
    prstGeom.set("prst", char(string(prst)));
    prstGeom.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    spPr.append(prstGeom);
    sp.append(spPr);

    % default autoshape style (python new_autoshape_sp)
    style = mat2ppt.oxml.OxmlElement("p:style");
    lnRef = mat2ppt.oxml.OxmlElement("a:lnRef");
    lnRef.set("idx", "1");
    sc = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc.set("val", "accent1");
    lnRef.append(sc);
    style.append(lnRef);
    fillRef = mat2ppt.oxml.OxmlElement("a:fillRef");
    fillRef.set("idx", "3");
    sc2 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc2.set("val", "accent1");
    fillRef.append(sc2);
    style.append(fillRef);
    effectRef = mat2ppt.oxml.OxmlElement("a:effectRef");
    effectRef.set("idx", "2");
    sc3 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc3.set("val", "accent1");
    effectRef.append(sc3);
    style.append(effectRef);
    fontRef = mat2ppt.oxml.OxmlElement("a:fontRef");
    fontRef.set("idx", "minor");
    sc4 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc4.set("val", "lt1");
    fontRef.append(sc4);
    style.append(fontRef);
    sp.append(style);

    txBody = mat2ppt.oxml.OxmlElement("p:txBody");
    bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
    bodyPr.set("rtlCol", "0");
    bodyPr.set("anchor", "ctr");
    txBody.append(bodyPr);
    txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    p = mat2ppt.oxml.OxmlElement("a:p");
    pPr = mat2ppt.oxml.OxmlElement("a:pPr");
    pPr.set("algn", "ctr");
    p.append(pPr);
    txBody.append(p);
    sp.append(txBody);
end
