function clark = resolve_qname_(qname, nsMap)
%RESOLVE_QNAME_  prefix:local or local → Clark {uri}local using nsMap.

    qname = char(qname);
    c = strfind(qname, ':');
    if isempty(c)
        % default ns
        if isKey(nsMap, "#default")
            uri = nsMap("#default");
            clark = sprintf("{%s}%s", uri, qname);
        else
            clark = qname;
        end
    else
        pfx = qname(1:c(1)-1);
        local = qname(c(1)+1:end);
        if ~isKey(nsMap, pfx)
            error("mat2ppt:XMLSyntaxError", "Unknown prefix %s", pfx);
        end
        uri = nsMap(pfx);
        clark = sprintf("{%s}%s", uri, local);
    end
end
