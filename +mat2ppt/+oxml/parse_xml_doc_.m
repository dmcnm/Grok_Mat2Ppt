function [elm, pos] = parse_xml_doc_(s, pos)
%PARSE_XML_DOC_  Skip prolog and parse root element.

    n = numel(s);
    pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
    if pos <= n && s(pos) == '<' && pos < n && s(pos+1) == '?'
        rest = s(pos:n);
        endp = strfind(rest, '?>');
        if isempty(endp)
            error("mat2ppt:XMLSyntaxError", "Unterminated XML declaration");
        end
        pos = pos + endp(1) + 1;  % position after '>'
        pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
    end
    while pos <= n
        pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
        if pos+3 <= n && all(s(pos:pos+3) == '<!--')
            rest = s(pos:n);
            endp = strfind(rest, '-->');
            if isempty(endp)
                error("mat2ppt:XMLSyntaxError", "Unterminated comment");
            end
            pos = pos + endp(1) + 2;
            continue
        end
        break
    end
    if pos > n || s(pos) ~= '<'
        error("mat2ppt:XMLSyntaxError", "Expected root element at pos %d of %d", pos, n);
    end
    nsStack = {containers.Map("KeyType", "char", "ValueType", "char")};
    [elm, pos] = mat2ppt.oxml.parse_element_(s, pos, nsStack);
end
