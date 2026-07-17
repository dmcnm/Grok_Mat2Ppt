function gf = new_ole_object_graphicFrame(shapeId, name, oleRId, progId, iconRId, x, y, cx, cy, imgW, imgH)
%NEW_OLE_OBJECT_GRAPHICFRAME  p:graphicFrame embedding OLE object (python CT_GraphicalObjectFrame).

    x = double(mat2ppt.util.Length.toEmuInt_(x));
    y = double(mat2ppt.util.Length.toEmuInt_(y));
    cx = double(mat2ppt.util.Length.toEmuInt_(cx));
    cy = double(mat2ppt.util.Length.toEmuInt_(cy));
    imgW = double(mat2ppt.util.Length.toEmuInt_(imgW));
    imgH = double(mat2ppt.util.Length.toEmuInt_(imgH));
    R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
    oleUri = "http://schemas.openxmlformats.org/presentationml/2006/ole";

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
    off.set("x", char(string(round(x))));
    off.set("y", char(string(round(y))));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(round(cx))));
    ext.set("cy", char(string(round(cy))));
    xfrm.append(off); xfrm.append(ext);
    gf.append(xfrm);

    graphic = mat2ppt.oxml.OxmlElement("a:graphic");
    gData = mat2ppt.oxml.OxmlElement("a:graphicData");
    gData.set("uri", oleUri);
    ole = mat2ppt.oxml.OxmlElement("p:oleObj");
    ole.set("showAsIcon", "1");
    ole.set(sprintf("{%s}id", R), char(string(oleRId)));
    ole.set("imgW", char(string(round(imgW))));
    ole.set("imgH", char(string(round(imgH))));
    ole.set("progId", char(string(progId)));
    ole.append(mat2ppt.oxml.OxmlElement("p:embed"));

    pic = mat2ppt.oxml.OxmlElement("p:pic");
    nvPic = mat2ppt.oxml.OxmlElement("p:nvPicPr");
    cNvPr2 = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr2.set("id", "0");
    cNvPr2.set("name", "");
    nvPic.append(cNvPr2);
    nvPic.append(mat2ppt.oxml.OxmlElement("p:cNvPicPr"));
    nvPic.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
    pic.append(nvPic);
    blipFill = mat2ppt.oxml.OxmlElement("p:blipFill");
    blip = mat2ppt.oxml.OxmlElement("a:blip");
    blip.set(sprintf("{%s}embed", R), char(string(iconRId)));
    blipFill.append(blip);
    stretch = mat2ppt.oxml.OxmlElement("a:stretch");
    stretch.append(mat2ppt.oxml.OxmlElement("a:fillRect"));
    blipFill.append(stretch);
    pic.append(blipFill);
    spPr = mat2ppt.oxml.OxmlElement("p:spPr");
    xfrm2 = mat2ppt.oxml.OxmlElement("a:xfrm");
    off2 = mat2ppt.oxml.OxmlElement("a:off");
    off2.set("x", char(string(round(x))));
    off2.set("y", char(string(round(y))));
    ext2 = mat2ppt.oxml.OxmlElement("a:ext");
    ext2.set("cx", char(string(round(cx))));
    ext2.set("cy", char(string(round(cy))));
    xfrm2.append(off2); xfrm2.append(ext2);
    spPr.append(xfrm2);
    prst = mat2ppt.oxml.OxmlElement("a:prstGeom");
    prst.set("prst", "rect");
    prst.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    spPr.append(prst);
    pic.append(spPr);
    ole.append(pic);
    gData.append(ole);
    graphic.append(gData);
    gf.append(graphic);
end
