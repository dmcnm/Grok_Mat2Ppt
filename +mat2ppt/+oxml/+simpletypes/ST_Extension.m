classdef ST_Extension
%ST_EXTENSION  File extension without leading dot.
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_Extension

    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(xmlValue);
            if startsWith(v, ".")
                v = v(2:end);
            end
        end
        function s = to_xml(value)
            s = mat2ppt.oxml.simpletypes.ST_Extension.from_xml(value);
        end
    end
end
