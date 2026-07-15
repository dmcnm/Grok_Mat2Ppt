function sp = new_placeholder_sp(id_, name, phType, orient, sz, idx)
%NEW_PLACEHOLDER_SP  Minimal p:sp placeholder (python CT_Shape.new_placeholder_sp).
%
%   Built with OxmlElement (no per-node xmlns redeclarations).

    sp = mat2ppt.oxml.OxmlElement("p:sp");
    nvSpPr = mat2ppt.oxml.OxmlElement("p:nvSpPr");
    cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
    cNvPr.set("id", char(string(id_)));
    cNvPr.set("name", char(string(name)));
    nvSpPr.append(cNvPr);
    cNvSpPr = mat2ppt.oxml.OxmlElement("p:cNvSpPr");
    locks = mat2ppt.oxml.OxmlElement("a:spLocks");
    locks.set("noGrp", "1");
    cNvSpPr.append(locks);
    nvSpPr.append(cNvSpPr);
    nvPr = mat2ppt.oxml.OxmlElement("p:nvPr");
    ph = mat2ppt.oxml.OxmlElement("p:ph");
    if ~mat2ppt.isAbsent(phType) && strlength(string(phType)) > 0
        ph.set("type", char(string(phType)));
    end
    if ~mat2ppt.isAbsent(idx) && strlength(string(idx)) > 0
        ph.set("idx", char(string(idx)));
    end
    if ~mat2ppt.isAbsent(orient) && strlength(string(orient)) > 0
        ph.set("orient", char(string(orient)));
    end
    if ~mat2ppt.isAbsent(sz) && strlength(string(sz)) > 0
        ph.set("sz", char(string(sz)));
    end
    nvPr.append(ph);
    nvSpPr.append(nvPr);
    sp.append(nvSpPr);
    sp.append(mat2ppt.oxml.OxmlElement("p:spPr"));

    hasTf = true;
    if ~mat2ppt.isAbsent(phType)
        t = char(string(phType));
        if any(strcmp(t, {'pic', 'tbl', 'chart', 'dgm', 'media', 'clipArt', 'sldImg'}))
            hasTf = false;
        end
    end
    if hasTf
        txBody = mat2ppt.oxml.OxmlElement("p:txBody");
        txBody.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
        txBody.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
        txBody.append(mat2ppt.oxml.OxmlElement("a:p"));
        sp.append(txBody);
    end
end
