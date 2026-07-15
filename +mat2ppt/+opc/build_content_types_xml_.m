function bytesOut = build_content_types_xml_(parts, contentTypes)
%BUILD_CONTENT_TYPES_XML_  [Content_Types].xml matching python-pptx PackageWriter.
%
%   parts: cellstr of pack URIs with leading / (excluding CT and .rels)
%   contentTypes: containers.Map partname -> content type string
%
%   Ported from python-pptx 1.0.2: opc/serialized.py::_ContentTypesItem

    CT_RELS = "application/vnd.openxmlformats-package.relationships+xml";
    CT_XML = "application/xml";
    dct = mat2ppt.opc.default_content_types_();

    % CaseInsensitiveDict seed: always include rels + xml defaults
    defaults = containers.Map("KeyType", "char", "ValueType", "char");
    defaults("rels") = CT_RELS;
    defaults("xml") = CT_XML;
    overrides = containers.Map("KeyType", "char", "ValueType", "char");

    for i = 1:numel(parts)
        pn = char(string(parts{i}));
        if pn(1) ~= "/"
            pn = ["/" pn];
            pn = char(pn);
        end
        if ~isKey(contentTypes, pn)
            continue
        end
        ct = char(string(contentTypes(pn)));
        [~, ~, ext] = fileparts(pn);
        if ~isempty(ext) && ext(1) == "."
            ext = ext(2:end);
        end
        ext = lower(char(ext));
        key = sprintf("%s|%s", ext, ct);
        if isKey(dct, key)
            defaults(ext) = ct;
        else
            overrides(pn) = ct;
        end
    end

    % Build XML: Defaults sorted by ext, Overrides sorted by partname
    CT_NS = "http://schemas.openxmlformats.org/package/2006/content-types";
    root = mat2ppt.oxml.XmlElement(sprintf("{%s}Types", CT_NS));
    root.setNsDecls({"", CT_NS});

    extKeys = sort(defaults.keys);
    for i = 1:numel(extKeys)
        ext = extKeys{i};
        el = mat2ppt.oxml.XmlElement(sprintf("{%s}Default", CT_NS));
        el.set("Extension", ext);
        el.set("ContentType", defaults(ext));
        root.append(el);
    end

    ovKeys = sort(overrides.keys);
    for i = 1:numel(ovKeys)
        pn = ovKeys{i};
        el = mat2ppt.oxml.XmlElement(sprintf("{%s}Override", CT_NS));
        el.set("PartName", pn);
        el.set("ContentType", overrides(pn));
        root.append(el);
    end

    bytesOut = mat2ppt.oxml.serialize_part_xml(root);
end
