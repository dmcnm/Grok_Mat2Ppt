function result = evaluate_xpath(elm, expr)
%EVALUATE_XPATH  Minimal XPath subset used by python-pptx.
%
%   Supports:
%     ./pfx:local   direct child
%     .//pfx:local  descendant
%     @attr         attribute on context (returns string cell)
%
%   Ported from python-pptx mini-XPath usage (design subset); expand as inventory grows.

    arguments
        elm (1,1) mat2ppt.oxml.XmlElement
        expr
    end
    expr = strtrim(char(string(expr)));
    result = {};

    if startsWith(expr, "@")
        v = elm.get(expr(2:end));
        if ~mat2ppt.isAbsent(v)
            result = {v};
        end
        return
    end

    if startsWith(expr, ".//")
        tag = expr(4:end);
        result = mat2ppt.oxml.descendants_with_tag_(elm, tag);
        return
    end

    if startsWith(expr, "./")
        tag = expr(3:end);
        result = elm.findall(tag);
        return
    end

    if startsWith(expr, "//")
        tag = expr(3:end);
        result = mat2ppt.oxml.descendants_with_tag_(elm, tag);
        return
    end

    % bare tag = direct child
    result = elm.findall(expr);
end
