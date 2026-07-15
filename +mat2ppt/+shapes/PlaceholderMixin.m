classdef PlaceholderMixin
%PLACEHOLDERMIXIN  Helpers for placeholder shapes (P5-W7).
%
%   Ported from python-pptx placeholder detection patterns.

    methods (Static)
        function tf = element_is_placeholder(shapeElm)
            r = mat2ppt.oxml.evaluate_xpath(shapeElm, ".//p:ph");
            tf = ~isempty(r);
        end

        function t = placeholder_type(shapeElm)
            r = mat2ppt.oxml.evaluate_xpath(shapeElm, ".//p:ph");
            if isempty(r)
                error("mat2ppt:ValueError", "not a placeholder shape");
            end
            raw = r{1}.get("type");
            if mat2ppt.isAbsent(raw)
                t = "obj";  % default body
            else
                t = char(string(raw));
            end
        end
    end
end
