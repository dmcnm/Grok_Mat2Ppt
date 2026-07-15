classdef simpletypes
%SIMPLETYPES  Namespace for oxml simple-type converters (P3-W5 / M1 subset+).
%
%   Use mat2ppt.oxml.simpletypes.ST_Coordinate etc. via nested static methods
%   on this class and companion functions in +simpletypes package folder.
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/simpletypes.py
%
%   Prefer package functions under +mat2ppt/+oxml/+simpletypes/.

    methods (Static)
        function v = from_xml(typeName, xmlValue)
            fcn = str2func("mat2ppt.oxml.simpletypes." + string(typeName) + ".from_xml");
            v = fcn(xmlValue);
        end

        function s = to_xml(typeName, value)
            fcn = str2func("mat2ppt.oxml.simpletypes." + string(typeName) + ".to_xml");
            s = fcn(value);
        end
    end
end
