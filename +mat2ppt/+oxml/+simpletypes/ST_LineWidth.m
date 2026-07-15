classdef ST_LineWidth
%ST_LINEWIDTH  Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_LineWidth
    methods (Static)
        function v = from_xml(xmlValue)
            v = str2double(string(xmlValue));
        end
        function s = to_xml(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(value);
            s = char(string(round(double(value))));
        end
        function validate(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(value);
        end
    end
end
