function sp = new_placeholder_sp(id_, name, phType, orient, sz, idx)
%NEW_PLACEHOLDER_SP  Minimal p:sp placeholder (python CT_Shape.new_placeholder_sp).
%
%   phType/orient/sz/idx may be [] to omit optional ph attributes.

    ns = mat2ppt.oxml.nsdecls("a", "p");
    nameEsc = mat2ppt.oxml.escape_xml_attr_(char(string(name)));
    lines = {
        ['<p:sp ' ns '>']
        '  <p:nvSpPr>'
        ['    <p:cNvPr id="' num2str(id_) '" name="' nameEsc '"/>']
        '    <p:cNvSpPr>'
        '      <a:spLocks noGrp="1"/>'
        '    </p:cNvSpPr>'
        '    <p:nvPr/>'
        '  </p:nvSpPr>'
        '  <p:spPr/>'
        '</p:sp>'
        };
    sp = mat2ppt.oxml.parse_xml(strjoin(lines, newline));
    % locate nvPr and add p:ph
    nvSpPr = sp.find("p:nvSpPr");
    if isempty(nvSpPr)
        kids = sp.getchildren();
        nvSpPr = kids{1};
    end
    nvPr = [];
    gk = nvSpPr.getchildren();
    for i = 1:numel(gk)
        if strcmp(char(gk{i}.localName()), "nvPr")
            nvPr = gk{i};
            break
        end
    end
    if isempty(nvPr)
        nvPr = mat2ppt.oxml.OxmlElement("p:nvPr");
        nvSpPr.append(nvPr);
    end
    ph = mat2ppt.oxml.OxmlElement("p:ph");
    if ~mat2ppt.isAbsent(phType) && strlength(string(phType)) > 0
        ph.set("type", char(string(phType)));
    end
    if ~mat2ppt.isAbsent(idx)
        ph.set("idx", char(string(idx)));
    end
    if ~mat2ppt.isAbsent(orient) && strlength(string(orient)) > 0
        ph.set("orient", char(string(orient)));
    end
    if ~mat2ppt.isAbsent(sz) && strlength(string(sz)) > 0
        ph.set("sz", char(string(sz)));
    end
    nvPr.append(ph);

    hasTf = true;
    if ~mat2ppt.isAbsent(phType)
        t = char(string(phType));
        if any(strcmp(t, {"pic", "tbl", "chart", "dgm", "media", "clipArt", "sldImg"}))
            hasTf = false;
        end
    end
    if hasTf
        tbLines = {
            ['<p:txBody ' mat2ppt.oxml.nsdecls("a", "p") '>']
            '  <a:bodyPr/>'
            '  <a:lstStyle/>'
            '  <a:p/>'
            '</p:txBody>'
            };
        tb = mat2ppt.oxml.parse_xml(strjoin(tbLines, newline));
        sp.append(tb);
    end
end
