function gf = new_chart_graphicFrame(shapeId, name, rId, left, top, width, height)
%NEW_CHART_GRAPHICFRAME  p:graphicFrame referencing chart part rId (P8-W1 shell).
%
%   Ported from python-pptx CT_GraphicalObjectFrame.new_chart_graphicFrame

    left = double(mat2ppt.util.Length.toEmuInt_(left));
    top = double(mat2ppt.util.Length.toEmuInt_(top));
    width = double(mat2ppt.util.Length.toEmuInt_(width));
    height = double(mat2ppt.util.Length.toEmuInt_(height));

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
    graphicData.set("uri", mat2ppt.oxml.chart.CT_ChartSpace.graphic_data_uri());
    chart = mat2ppt.oxml.OxmlElement("c:chart");
    R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
    chart.set(sprintf("{%s}id", R), char(string(rId)));
    graphicData.append(chart);
    graphic.append(graphicData);
    gf.append(graphic);
end
