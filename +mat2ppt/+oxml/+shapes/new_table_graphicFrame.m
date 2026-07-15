function gf = new_table_graphicFrame(shapeId, name, rows, cols, left, top, width, height)
%NEW_TABLE_GRAPHICFRAME  p:graphicFrame containing a:tbl (python CT_GraphicalObjectFrame).
%
%   Ported from python-pptx oxml/shapes/graphfrm.py::new_table_graphicFrame (P7-W1)

    left = double(mat2ppt.util.Length.toEmuInt_(left));
    top = double(mat2ppt.util.Length.toEmuInt_(top));
    width = double(mat2ppt.util.Length.toEmuInt_(width));
    height = double(mat2ppt.util.Length.toEmuInt_(height));
    rows = double(rows);
    cols = double(cols);

    gf = mat2ppt.oxml.OxmlElement("p:graphicFrame");
    nv = mat2ppt.oxml.OxmlElement("p:nvGraphicFramePr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(name)));
    nv.append(cNvPr);
    cNvG = mat2ppt.oxml.OxmlElement("p:cNvGraphicFramePr");
    locks = mat2ppt.oxml.OxmlElement("a:graphicFrameLocks");
    locks.set("noGrp", "1");
    cNvG.append(locks);
    nv.append(cNvG);
    nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    gf.append(nv);

    xfrm = mat2ppt.oxml.OxmlElement("p:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(round(left))));
    off.set("y", char(string(round(top))));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(round(width))));
    ext.set("cy", char(string(round(height))));
    xfrm.append(off);
    xfrm.append(ext);
    gf.append(xfrm);

    graphic = mat2ppt.oxml.OxmlElement("a:graphic");
    graphicData = mat2ppt.oxml.OxmlElement("a:graphicData");
    graphicData.set("uri", "http://schemas.openxmlformats.org/drawingml/2006/table");
    tbl = mat2ppt.oxml.shapes.new_tbl_(rows, cols, width, height);
    graphicData.append(tbl);
    graphic.append(graphicData);
    gf.append(graphic);
end
