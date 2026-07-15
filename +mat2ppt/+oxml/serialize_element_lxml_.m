function s = serialize_element_lxml_(elm, pfxOfUri, rootDecls, isRoot)
%SERIALIZE_ELEMENT_LXML_  Serialize with lxml-like names and ns decls.

    arguments
        elm
        pfxOfUri
        rootDecls
        isRoot (1,1) logical
    end

    [~, local, uri] = mat2ppt.oxml.split_clark_(elm.tag);
    local = char(local);
    uri = char(uri);

    if strlength(string(uri)) == 0
        openName = local;
    else
        if isKey(pfxOfUri, uri)
            pfx = pfxOfUri(uri);
        else
            pfx = "";
        end
        if strlength(string(pfx)) == 0
            openName = local;  % default ns
        else
            openName = sprintf("%s:%s", pfx, local);
        end
    end

    % attributes — special order for Relationship
    [anames, avals] = elm.attribItems();
    if strcmp(local, "Relationship")
        [anames, avals] = mat2ppt.oxml.order_relationship_attrs_(anames, avals);
    end

    attrParts = strings(0);
    for i = 1:numel(anames)
        an = anames{i};
        av = mat2ppt.oxml.escape_xml_attr_(avals{i});
        if ~isempty(an) && an(1) == '{'
            [~, alocal, auri] = mat2ppt.oxml.split_clark_(string(an));
            auri = char(auri);
            if isKey(pfxOfUri, auri)
                apfx = pfxOfUri(auri);
            else
                apfx = "";
            end
            if strlength(string(apfx)) == 0
                attrParts(end+1) = sprintf('%s="%s"', alocal, av); %#ok<AGROW>
            else
                attrParts(end+1) = sprintf('%s:%s="%s"', apfx, alocal, av); %#ok<AGROW>
            end
        else
            attrParts(end+1) = sprintf('%s="%s"', an, av); %#ok<AGROW>
        end
    end

    % Namespace decls: on any element that carried them in the source document
    % (lxml keeps local xmlns:p14 etc. on the declaring element).
    % On part roots, also merge rootDecls for URIs introduced later (e.g. c:chart
    % on a template slide that only had a/p/r) so Office does not repair/drop them.
    declParts = strings(0);
    if elm.hasNsDecls()
        decls = elm.getNsDecls();
        for i = 1:size(decls, 1)
            pfx = char(string(decls{i, 1}));
            u = char(string(decls{i, 2}));
            if isempty(pfx)
                declParts(end+1) = sprintf('xmlns="%s"', u); %#ok<AGROW>
            else
                declParts(end+1) = sprintf('xmlns:%s="%s"', pfx, u); %#ok<AGROW>
            end
        end
    end
    if isRoot && ~isempty(rootDecls)
        for i = 1:numel(rootDecls)
            d = rootDecls(i);
            if ~any(declParts == d)
                declParts(end+1) = d; %#ok<AGROW>
            end
        end
    end

    head = "<" + string(openName);
    if ~isempty(declParts)
        head = head + " " + join(declParts, " ");
    end
    if ~isempty(attrParts)
        head = head + " " + join(attrParts, " ");
    end

    kids = elm.getchildren();
    hasKids = ~isempty(kids);
    hasText = ~mat2ppt.isAbsent(elm.text);

    if ~hasKids && ~hasText
        s = head + "/>";
        return
    end

    s = head + ">";
    if hasText
        s = s + string(mat2ppt.oxml.escape_xml_text_(elm.text));
    end
    for i = 1:numel(kids)
        s = s + mat2ppt.oxml.serialize_element_lxml_(kids{i}, pfxOfUri, strings(0), false);
        if ~mat2ppt.isAbsent(kids{i}.tail)
            s = s + string(mat2ppt.oxml.escape_xml_text_(kids{i}.tail));
        end
    end
    s = s + sprintf("</%s>", openName);
end
