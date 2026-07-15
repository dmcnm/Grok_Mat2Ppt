function sp = new_sp(shapeId, name, left, top, width, height, prst)
%NEW_SP  Minimal p:sp autoshape tree (python-pptx CT_Shape skeleton).
%
%   Ported from python-pptx oxml/shapes/autoshape.py patterns (P5-W2).

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

    % txBody minimal
    txBody = mat2ppt.oxml.OxmlElement("p:txBody");
    txBody.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
    txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    p = mat2ppt.oxml.OxmlElement("a:p");
    txBody.append(p);
    sp.append(txBody);
end
