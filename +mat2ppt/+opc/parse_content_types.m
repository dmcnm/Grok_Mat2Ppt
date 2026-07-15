function [defaults, overrides] = parse_content_types(blob)
%PARSE_CONTENT_TYPES  Parse [Content_Types].xml bytes.
%
%   defaults: containers.Map ext(lowercase)->contentType
%   overrides: containers.Map partname(with leading /)->contentType

    root = mat2ppt.oxml.parse_xml(blob);
    defaults = containers.Map("KeyType", "char", "ValueType", "char");
    overrides = containers.Map("KeyType", "char", "ValueType", "char");
    kids = root.getchildren();
    for i = 1:numel(kids)
        el = kids{i};
        ln = char(el.localName());
        if strcmp(ln, "Default")
            ext = el.get("Extension");
            ct = el.get("ContentType");
            defaults(lower(ext)) = ct;
        elseif strcmp(ln, "Override")
            pn = el.get("PartName");
            ct = el.get("ContentType");
            overrides(pn) = ct;
        end
    end
end
