function uris = collect_ns_uris_(elm)
%COLLECT_NS_URIS_  Unique namespace URIs in element subtree (stable order).

    uris = strings(0);
    stack = {elm};
    while ~isempty(stack)
        e = stack{end};
        stack(end) = [];
        [~, ~, uri] = mat2ppt.oxml.split_clark_(e.tag);
        if strlength(uri) > 0
            uris(end+1) = uri; %#ok<AGROW>
        end
        [anames, ~] = e.attribItems();
        for i = 1:numel(anames)
            an = anames{i};
            if ~isempty(an) && an(1) == '{'
                [~, ~, auri] = mat2ppt.oxml.split_clark_(string(an));
                if strlength(auri) > 0
                    uris(end+1) = auri; %#ok<AGROW>
                end
            end
        end
        kids = e.getchildren();
        for i = numel(kids):-1:1
            stack{end+1} = kids{i}; %#ok<AGROW>
        end
    end
    % unique stable
    seen = containers.Map("KeyType", "char", "ValueType", "logical");
    out = strings(0);
    for i = 1:numel(uris)
        k = char(uris(i));
        if ~isKey(seen, k)
            seen(k) = true;
            out(end+1) = uris(i); %#ok<AGROW>
        end
    end
    uris = out;
end
