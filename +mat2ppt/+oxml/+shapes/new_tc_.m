function tc = new_tc_()
%NEW_TC_  Empty a:tc with txBody + tcPr (python CT_TableCell.new).
    tc = mat2ppt.oxml.OxmlElement("a:tc");
    txBody = mat2ppt.oxml.OxmlElement("a:txBody");
    txBody.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
    txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    txBody.append(mat2ppt.oxml.OxmlElement("a:p"));
    tc.append(txBody);
    tc.append(mat2ppt.oxml.OxmlElement("a:tcPr"));
end
