function xfrm = get_or_add_xfrm(spPr)
%GET_OR_ADD_XFRM  a:xfrm under p:spPr (or create).
    xfrm = spPr.find("a:xfrm");
    if isempty(xfrm)
        xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
        spPr.append(xfrm);
    end
end
