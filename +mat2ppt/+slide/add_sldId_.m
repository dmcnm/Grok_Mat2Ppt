function sldId = add_sldId_(presElm, rId)
%ADD_SLDID_  Append p:sldId under p:sldIdLst (create list if needed).
%
%   Slide id starts at 256 (python CT_SlideIdList._next_id).

    sldIdLst = presElm.find("p:sldIdLst");
    if isempty(sldIdLst)
        kids = presElm.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "sldIdLst")
                sldIdLst = kids{i};
                break
            end
        end
    end
    if isempty(sldIdLst)
        sldIdLst = mat2ppt.oxml.OxmlElement("p:sldIdLst");
        % insert before sldSz if present
        kids = presElm.getchildren();
        insertAt = numel(kids) + 1;
        for i = 1:numel(kids)
            ln = char(kids{i}.localName());
            if any(strcmp(ln, {'sldSz', 'notesSz', 'defaultTextStyle'}))
                insertAt = i;
                break
            end
        end
        % rebuild children with insert
        for i = numel(kids):-1:1
            presElm.remove(kids{i});
        end
        for i = 1:insertAt-1
            presElm.append(kids{i});
        end
        presElm.append(sldIdLst);
        for i = insertAt:numel(kids)
            presElm.append(kids{i});
        end
    end

    used = 255;
    for i = 1:numel(sldIdLst.getchildren())
        el = sldIdLst.child(i);
        if ~strcmp(char(el.localName()), "sldId")
            continue
        end
        raw = el.get("id");
        if ~mat2ppt.isAbsent(raw)
            used = max(used, str2double(raw));
        end
    end
    nextId = used + 1;
    if nextId < 256
        nextId = 256;
    end

    sldId = mat2ppt.oxml.OxmlElement("p:sldId");
    sldId.set("id", char(string(nextId)));
    sldId.set(mat2ppt.oxml.qn("r:id"), char(string(rId)));
    sldIdLst.append(sldId);
end
