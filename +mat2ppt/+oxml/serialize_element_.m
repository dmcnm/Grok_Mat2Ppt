function s = serialize_element_(elm, ancestorNs)
%SERIALIZE_ELEMENT_  Serialize element tree to unicode string (no decl).
%
%   Package-private helper for serialize_part_xml.
%   ancestorNs: containers.Map prefix→uri already declared on ancestors.

    arguments
        elm (1,1) mat2ppt.oxml.XmlElement
        ancestorNs
    end

    [pfx, local, uri] = mat2ppt.oxml.split_clark_(elm.tag);
    % Determine ns declarations needed on this element
    decls = strings(0);
    if ancestorNs.Count == 0
        inScope = containers.Map("KeyType", "char", "ValueType", "char");
    else
        inScope = containers.Map(ancestorNs.keys, ancestorNs.values, "UniformValues", true);
    end

    if strlength(uri) > 0
        needDecl = true;
        if isKey(inScope, char(pfx)) && strcmp(inScope(char(pfx)), char(uri))
            needDecl = false;
        end
        % also if same uri bound to this prefix anywhere — keep simple: redeclare if not exact
        if needDecl
            decls(end+1) = sprintf('xmlns:%s="%s"', pfx, uri); %#ok<AGROW>
            inScope(char(pfx)) = char(uri);
        end
        openName = sprintf("%s:%s", pfx, local);
    else
        openName = local;
    end

    % attributes
    [anames, avals] = elm.attribItems();
    attrParts = strings(0);
    for i = 1:numel(anames)
        an = anames{i};
        av = mat2ppt.oxml.escape_xml_attr_(avals{i});
        % Clark attr names
        if ~isempty(an) && an(1) == '{'
            [apfx, alocal, auri] = mat2ppt.oxml.split_clark_(string(an));
            if ~isKey(inScope, char(apfx)) || ~strcmp(inScope(char(apfx)), char(auri))
                decls(end+1) = sprintf('xmlns:%s="%s"', apfx, auri); %#ok<AGROW>
                inScope(char(apfx)) = char(auri);
            end
            attrParts(end+1) = sprintf('%s:%s="%s"', apfx, alocal, av); %#ok<AGROW>
        else
            attrParts(end+1) = sprintf('%s="%s"', an, av); %#ok<AGROW>
        end
    end

    head = "<" + openName;
    if ~isempty(decls)
        head = head + " " + join(decls, " ");
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
        s = s + mat2ppt.oxml.serialize_element_(kids{i}, inScope);
        if ~mat2ppt.isAbsent(kids{i}.tail)
            s = s + string(mat2ppt.oxml.escape_xml_text_(kids{i}.tail));
        end
    end
    s = s + sprintf("</%s>", openName);
end
