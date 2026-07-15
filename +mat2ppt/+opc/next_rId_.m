function rId = next_rId_(relsElm)
%NEXT_RID_  Next rIdN for a Relationships element (max existing + 1).
    maxN = 0;
    kids = relsElm.getchildren();
    for i = 1:numel(kids)
        el = kids{i};
        if ~strcmp(char(el.localName()), "Relationship")
            continue
        end
        idv = el.get("Id");
        if mat2ppt.isAbsent(idv)
            continue
        end
        rid = char(string(idv));
        if startsWith(string(rid), "rId") && strlength(string(rid)) > 3
            n = str2double(rid(4:end));
            if ~isnan(n) && n > maxN
                maxN = n;
            end
        end
    end
    rId = sprintf("rId%d", maxN + 1);
end
