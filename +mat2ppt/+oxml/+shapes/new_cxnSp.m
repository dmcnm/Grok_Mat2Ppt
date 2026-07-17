function cxnSp = new_cxnSp(shapeId, name, prst, x, y, cx, cy, flipH, flipV)
%NEW_CXNSP  p:cxnSp connector (python CT_Connector.new_cxnSp).
%
%   Ported from python-pptx 1.0.2: oxml/shapes/connector.py

    x = double(mat2ppt.util.Length.toEmuInt_(x));
    y = double(mat2ppt.util.Length.toEmuInt_(y));
    cx = double(mat2ppt.util.Length.toEmuInt_(cx));
    cy = double(mat2ppt.util.Length.toEmuInt_(cy));
    if nargin < 8, flipH = false; end
    if nargin < 9, flipV = false; end

    cxnSp = mat2ppt.oxml.OxmlElement("p:cxnSp");
    nv = mat2ppt.oxml.OxmlElement("p:nvCxnSpPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(name)));
    nv.append(cNvPr);
    nv.append(mat2ppt.oxml.OxmlElement("p:cNvCxnSpPr"));
    nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    cxnSp.append(nv);

    spPr = mat2ppt.oxml.OxmlElement("p:spPr");
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    if flipH
        xfrm.set("flipH", "1");
    end
    if flipV
        xfrm.set("flipV", "1");
    end
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(round(x))));
    off.set("y", char(string(round(y))));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(round(cx))));
    ext.set("cy", char(string(round(cy))));
    xfrm.append(off);
    xfrm.append(ext);
    spPr.append(xfrm);
    prstGeom = mat2ppt.oxml.OxmlElement("a:prstGeom");
    prstGeom.set("prst", char(string(prst)));
    prstGeom.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    spPr.append(prstGeom);
    cxnSp.append(spPr);

    % style (python new_cxnSp)
    style = mat2ppt.oxml.OxmlElement("p:style");
    lnRef = mat2ppt.oxml.OxmlElement("a:lnRef");
    lnRef.set("idx", "2");
    sc = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc.set("val", "accent1");
    lnRef.append(sc);
    style.append(lnRef);
    fillRef = mat2ppt.oxml.OxmlElement("a:fillRef");
    fillRef.set("idx", "0");
    sc2 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc2.set("val", "accent1");
    fillRef.append(sc2);
    style.append(fillRef);
    effectRef = mat2ppt.oxml.OxmlElement("a:effectRef");
    effectRef.set("idx", "1");
    sc3 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc3.set("val", "accent1");
    effectRef.append(sc3);
    style.append(effectRef);
    fontRef = mat2ppt.oxml.OxmlElement("a:fontRef");
    fontRef.set("idx", "minor");
    sc4 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sc4.set("val", "tx1");
    fontRef.append(sc4);
    style.append(fontRef);
    cxnSp.append(style);
end
