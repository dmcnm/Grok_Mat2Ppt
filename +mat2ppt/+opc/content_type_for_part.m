function ct = content_type_for_part(partname, defaults, overrides)
%CONTENT_TYPE_FOR_PART  Resolve content type for a pack URI path.

    pn = char(string(partname));
    if pn(1) ~= "/", pn = ["/" pn]; pn = char(pn); end
    if isKey(overrides, pn)
        ct = overrides(pn);
        return
    end
    % extension
    [~, ~, ext] = fileparts(pn);
    if ~isempty(ext) && ext(1) == ".", ext = ext(2:end); end
    ext = lower(ext);
    if isKey(defaults, ext)
        ct = defaults(ext);
    else
        ct = "application/octet-stream";
    end
end
