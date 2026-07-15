function tx = new_tc_txBody_()
%NEW_TC_TXBODY_  Minimal a:txBody for a table cell.
    tx = mat2ppt.oxml.OxmlElement("a:txBody");
    tx.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
    tx.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
    tx.append(mat2ppt.oxml.OxmlElement("a:p"));
end
