function bytesOut = serialize_rels_sorted_(relsElm)
%SERIALIZE_RELS_SORTED_  .rels bytes with Relationship children in rId order.
%
%   Ported from python-pptx 1.0.2: opc/package.py::_Relationships.xml

    PR = "http://schemas.openxmlformats.org/package/2006/relationships";
    root = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationships", PR));
    root.setNsDecls({"", PR});

    kids = relsElm.getchildren();
    % Collect rId + element data
    rIds = strings(0);
    reltype = strings(0);
    target = strings(0);
    targetMode = strings(0);  % "" if absent
    for i = 1:numel(kids)
        el = kids{i};
        if ~strcmp(char(el.localName()), "Relationship")
            continue
        end
        rIds(end+1) = string(el.get("Id")); %#ok<AGROW>
        reltype(end+1) = string(el.get("Type")); %#ok<AGROW>
        target(end+1) = string(el.get("Target")); %#ok<AGROW>
        tm = el.get("TargetMode");
        if mat2ppt.isAbsent(tm)
            targetMode(end+1) = ""; %#ok<AGROW>
        else
            targetMode(end+1) = string(tm); %#ok<AGROW>
        end
    end

    % Sort by numerical rId (rIdN -> N), else 0
    nums = zeros(1, numel(rIds));
    for i = 1:numel(rIds)
        rid = char(rIds(i));
        if startsWith(string(rid), "rId") && all(isstrprop(rid(4:end), "digit"))
            nums(i) = str2double(rid(4:end));
        else
            nums(i) = 0;
        end
    end
    [~, ord] = sortrows([nums(:), (1:numel(rIds))']);

    for j = 1:numel(ord)
        i = ord(j);
        el = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationship", PR));
        el.set("Id", char(rIds(i)));
        el.set("Type", char(reltype(i)));
        el.set("Target", char(target(i)));
        if strlength(targetMode(i)) > 0
            el.set("TargetMode", char(targetMode(i)));
        end
        root.append(el);
    end

    bytesOut = mat2ppt.oxml.serialize_part_xml(root);
end
