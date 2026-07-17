function pic = new_video_pic(shapeId, shapeName, videoRId, mediaRId, posterRId, x, y, cx, cy)
%NEW_VIDEO_PIC  p:pic for embedded movie (python CT_Picture.new_video_pic).

    x = double(mat2ppt.util.Length.toEmuInt_(x));
    y = double(mat2ppt.util.Length.toEmuInt_(y));
    cx = double(mat2ppt.util.Length.toEmuInt_(cx));
    cy = double(mat2ppt.util.Length.toEmuInt_(cy));
    R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";

    pic = mat2ppt.oxml.OxmlElement("p:pic");
    nv = mat2ppt.oxml.OxmlElement("p:nvPicPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(shapeId)));
    cNvPr.set("name", char(string(shapeName)));
    hlink = mat2ppt.oxml.OxmlElement("a:hlinkClick");
    hlink.set(sprintf("{%s}id", R), "");
    hlink.set("action", "ppaction://media");
    cNvPr.append(hlink);
    nv.append(cNvPr);
    cNvPicPr = mat2ppt.oxml.OxmlElement("p:cNvPicPr");
    locks = mat2ppt.oxml.OxmlElement("a:picLocks");
    locks.set("noChangeAspect", "1");
    cNvPicPr.append(locks);
    nv.append(cNvPicPr);
    nvPr = mat2ppt.oxml.OxmlElement("p:nvPr");
    vf = mat2ppt.oxml.OxmlElement("a:videoFile");
    vf.set(sprintf("{%s}link", R), char(string(videoRId)));
    nvPr.append(vf);
    extLst = mat2ppt.oxml.OxmlElement("p:extLst");
    ext = mat2ppt.oxml.OxmlElement("p:ext");
    ext.set("uri", "{DAA4B4D4-6D71-4841-9C94-3DE7FCFB9230}");
    media = mat2ppt.oxml.OxmlElement( ...
        "{http://schemas.microsoft.com/office/powerpoint/2010/main}media");
    media.set(sprintf("{%s}embed", R), char(string(mediaRId)));
    media.setNsDecls({"p14", "http://schemas.microsoft.com/office/powerpoint/2010/main"});
    ext.append(media);
    extLst.append(ext);
    nvPr.append(extLst);
    nv.append(nvPr);
    pic.append(nv);

    blipFill = mat2ppt.oxml.OxmlElement("p:blipFill");
    blip = mat2ppt.oxml.OxmlElement("a:blip");
    blip.set(sprintf("{%s}embed", R), char(string(posterRId)));
    blipFill.append(blip);
    stretch = mat2ppt.oxml.OxmlElement("a:stretch");
    stretch.append(mat2ppt.oxml.OxmlElement("a:fillRect"));
    blipFill.append(stretch);
    pic.append(blipFill);

    spPr = mat2ppt.oxml.OxmlElement("p:spPr");
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(round(x))));
    off.set("y", char(string(round(y))));
    ext2 = mat2ppt.oxml.OxmlElement("a:ext");
    ext2.set("cx", char(string(round(cx))));
    ext2.set("cy", char(string(round(cy))));
    xfrm.append(off); xfrm.append(ext2);
    spPr.append(xfrm);
    prstGeom = mat2ppt.oxml.OxmlElement("a:prstGeom");
    prstGeom.set("prst", "rect");
    prstGeom.append(mat2ppt.oxml.OxmlElement("a:avLst"));
    spPr.append(prstGeom);
    pic.append(spPr);
end
