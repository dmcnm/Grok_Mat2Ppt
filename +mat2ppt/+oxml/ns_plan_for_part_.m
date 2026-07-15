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
    C = "http://schemas.openxmlformats.org/drawingml/2006/chart";
    CP = "http://schemas.openxmlformats.org/package/2006/metadata/core-properties";
    DC = "http://purl.org/dc/elements/1.1/";
    DCT = "http://purl.org/dc/terms/";
    XSI = "http://www.w3.org/2001/XMLSchema-instance";
    P14 = "http://schemas.microsoft.com/office/powerpoint/2010/main";

    [~, ~, rootUri] = mat2ppt.oxml.split_clark_(root.tag);
    rootUri = char(rootUri);

    pfxOfUri = containers.Map("KeyType", "char", "ValueType", "char");
    rootDecls = strings(0);
    % URIs that already have an xmlns somewhere (root or descendant). Do not
    % re-promote those to the root (p14 stays local on template parts).
    declaredAnywhere = containers.Map("KeyType", "char", "ValueType", "logical");

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
                declaredAnywhere(uri) = true;
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
        declaredAnywhere(rootUri) = true;
    end

    preferred = {
        A, "a"
        R, "r"
        P, "p"
        C, "c"
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
        if ~isKey(pfxOfUri, uri)
            if useDefault && strcmp(uri, rootUri)
                continue
            end
            pfxOfUri(uri) = pfx;
        end
        % Emit root xmlns only if URI is used and never declared in the tree.
        % Example: c:chart on a template slide that only declared a/p/r.
        if ~isKey(declaredAnywhere, uri)
            pfxUse = pfxOfUri(uri);
            if strlength(string(pfxUse)) == 0
                rootDecls(end+1) = sprintf('xmlns="%s"', uri); %#ok<AGROW>
            else
                rootDecls(end+1) = sprintf('xmlns:%s="%s"', pfxUse, uri); %#ok<AGROW>
            end
            declaredAnywhere(uri) = true;
        end
    end

    % Any remaining URIs
    for i = 1:numel(usedUris)
        uri = char(usedUris(i));
        if ~isKey(pfxOfUri, uri)
            pm = mat2ppt.oxml.pfxmap_data();
            if isKey(pm, uri)
                pfx = pm(uri);
            else
                pfx = sprintf("ns%d", i);
            end
            pfxOfUri(uri) = pfx;
        end
        if ~isKey(declaredAnywhere, uri)
            pfx = pfxOfUri(uri);
            if strlength(string(pfx)) == 0
                rootDecls(end+1) = sprintf('xmlns="%s"', uri); %#ok<AGROW>
            else
                rootDecls(end+1) = sprintf('xmlns:%s="%s"', pfx, uri); %#ok<AGROW>
            end
            declaredAnywhere(uri) = true;
        end
    end
end
