function [name, pos] = read_name_(s, pos)
    n = length(s);
    start = pos;
    while pos <= n
        c = s(pos);
        if isspace(c) || c == '=' || c == '>' || c == '/' || c == '"' || c == "'"
            break
        end
        pos = pos + 1;
    end
    name = s(start:pos-1);
    if isempty(name)
        error("mat2ppt:XMLSyntaxError", "Expected name at %d", start);
    end
end
