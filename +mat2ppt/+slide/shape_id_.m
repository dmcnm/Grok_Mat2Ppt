function idv = shape_id_(elm)
%SHAPE_ID_  Numeric p:cNvPr@id if present, else [].
    idv = [];
    ln = char(elm.localName());
    if ~any(strcmp(ln, {'sp', 'pic', 'cxnSp', 'grpSp', 'graphicFrame'}))
        return
    end
    kids = elm.getchildren();
    for i = 1:numel(kids)
        if endsWith(string(kids{i}.localName()), "Pr") || ...
                any(strcmp(char(kids{i}.localName()), {'nvSpPr', 'nvPicPr', 'nvCxnSpPr', 'nvGrpSpPr', 'nvGraphicFramePr'}))
            g = kids{i}.getchildren();
            for j = 1:numel(g)
                if strcmp(char(g{j}.localName()), "cNvPr")
                    raw = g{j}.get("id");
                    if ~mat2ppt.isAbsent(raw)
                        idv = str2double(raw);
                    end
                    return
                end
            end
        end
    end
end
