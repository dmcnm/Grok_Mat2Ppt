function [val, pos] = read_quoted_(s, pos)
    n = length(s);
    if pos > n || (s(pos) ~= '"' && s(pos) ~= "'")
        error("mat2ppt:XMLSyntaxError", "Expected quote at %d", pos);
    end
    q = s(pos);
    pos = pos + 1;
    start = pos;
    while pos <= n && s(pos) ~= q
        pos = pos + 1;
    end
    if pos > n
        error("mat2ppt:XMLSyntaxError", "Unterminated string");
    end
    val = s(start:pos-1);
    val = mat2ppt.oxml.unescape_xml_(val);
    pos = pos + 1;
end
