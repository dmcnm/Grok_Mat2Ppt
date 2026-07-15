function spPr = ensure_spPr(shapeElm)
%ENSURE_SPPR  p:spPr child of sp/pic/cxnSp.
    spPr = shapeElm.find("p:spPr");
    if isempty(spPr)
        % try any spPr local name
        kids = shapeElm.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "spPr")
                spPr = kids{i};
                return
            end
        end
        spPr = mat2ppt.oxml.OxmlElement("p:spPr");
        shapeElm.append(spPr);
    end
end
