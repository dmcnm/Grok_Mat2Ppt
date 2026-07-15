function [pfxOfUri, rootDecls] = ns_plan_for_part_(root, usedUris)
%NS_PLAN_FOR_PART_  Map URI→prefix and ordered xmlns decls for part root.
%
%   Prefer prefixes declared in the tree (lxml identity). Fall back to
%   preferred OOXML prefixes for synthesized trees.

    CT = "http://schemas.openxmlformats.org/package/2006/content-types";
    PR = "http://schemas.openxmlformats.org/package/2006/relationships";
    A = "http://schemas.openxmlformats.org/drawingml/2006/main";
    R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
    P = "http://schemas.openxmlformats.org/presentationml/2006/main";
    CP = "http://schemas.openxmlformats.org/package/2006/metadata/core-properties";
    DC = "http://purl.org/dc/elements/1.1/";
    DCT = "http://purl.org/dc/terms/";
    XSI = "http://www.w3.org/2001/XMLSchema-instance";
    P14 = "http://schemas.microsoft.com/office/powerpoint/2010/main";

    [~, ~, rootUri] = mat2ppt.oxml.split_clark_(root.tag);
    rootUri = char(rootUri);

    pfxOfUri = containers.Map("KeyType", "char", "ValueType", "char");
    rootDecls = strings(0);

    % 1) Prefixes declared anywhere in the tree (document order, first wins)
    stack = {root};
    while ~isempty(stack)
        e = stack{end};
        stack(end) = [];
        if e.hasNsDecls()
            decls = e.getNsDecls();
            for i = 1:size(decls, 1)
                pfx = char(string(decls{i, 1}));
                uri = char(string(decls{i, 2}));
                if ~isKey(pfxOfUri, uri)
                    pfxOfUri(uri) = pfx;
                end
            end
        end
        kids = e.getchildren();
        for i = numel(kids):-1:1
            stack{end+1} = kids{i}; %#ok<AGROW>
        end
    end

    % Root decls string list (for synthesized trees without stored decls)
    if root.hasNsDecls()
        decls = root.getNsDecls();
        for i = 1:size(decls, 1)
            pfx = char(string(decls{i, 1}));
            uri = char(string(decls{i, 2}));
            if isempty(pfx)
                rootDecls(end+1) = sprintf('xmlns="%s"', uri); %#ok<AGROW>
            else
                rootDecls(end+1) = sprintf('xmlns:%s="%s"', pfx, uri); %#ok<AGROW>
            end
        end
    end

    useDefault = false;
    if strcmp(rootUri, CT) || strcmp(rootUri, PR)
        useDefault = true;
        if ~isKey(pfxOfUri, rootUri)
            pfxOfUri(rootUri) = "";
        end
        if isempty(rootDecls)
            rootDecls(end+1) = sprintf('xmlns="%s"', rootUri); %#ok<AGROW>
        end
    end

    preferred = {
        A, "a"
        R, "r"
        P, "p"
        CP, "cp"
        DC, "dc"
        DCT, "dcterms"
        XSI, "xsi"
        P14, "p14"
        CT, "ct"
        PR, "pr"
        };

    for i = 1:size(preferred, 1)
        uri = preferred{i, 1};
        pfx = preferred{i, 2};
        if ~any(usedUris == string(uri))
            continue
        end
        if isKey(pfxOfUri, uri)
            continue
        end
        if useDefault && strcmp(uri, rootUri)
            continue
        end
        pfxOfUri(uri) = pfx;
        if isempty(rootDecls) || ~root.hasNsDecls()
            rootDecls(end+1) = sprintf('xmlns:%s="%s"', pfx, uri); %#ok<AGROW>
        end
    end

    % Any remaining URIs
    for i = 1:numel(usedUris)
        uri = char(usedUris(i));
        if isKey(pfxOfUri, uri)
            continue
        end
        pm = mat2ppt.oxml.pfxmap_data();
        if isKey(pm, uri)
            pfx = pm(uri);
        else
            pfx = sprintf("ns%d", i);
        end
        pfxOfUri(uri) = pfx;
        if isempty(rootDecls) || ~root.hasNsDecls()
            if strlength(string(pfx)) == 0
                rootDecls(end+1) = sprintf('xmlns="%s"', uri); %#ok<AGROW>
            else
                rootDecls(end+1) = sprintf('xmlns:%s="%s"', pfx, uri); %#ok<AGROW>
            end
        end
    end
end
