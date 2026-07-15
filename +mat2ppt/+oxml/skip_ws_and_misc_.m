function pos = skip_ws_and_misc_(s, pos)
    n = numel(s);
    while pos <= n
        c = s(pos);
        if c ~= ' ' && c ~= sprintf('\t') && c ~= sprintf('\n') && c ~= sprintf('\r')
            break
        end
        pos = pos + 1;
    end
end

