function [pfx, local, uri] = split_clark_(tag)
%SPLIT_CLARK_  Parse Clark {uri}local or plain local into prefix, local, uri.

    tag = char(string(tag));
    if ~isempty(tag) && tag(1) == '{'
        close = find(tag == '}', 1, 'first');
        uri = string(tag(2:close-1));
        local = string(tag(close+1:end));
        pm = mat2ppt.oxml.pfxmap_data();
        if isKey(pm, char(uri))
            pfx = string(pm(char(uri)));
        else
            % invent stable prefix for unknown uri
            pfx = "ns0";
        end
    elseif contains(string(tag), ":")
        nspt = mat2ppt.oxml.NamespacePrefixedTag(tag);
        pfx = nspt.nspfx;
        local = nspt.local_part;
        uri = nspt.nsuri;
    else
        pfx = "";
        local = string(tag);
        uri = "";
    end
end
