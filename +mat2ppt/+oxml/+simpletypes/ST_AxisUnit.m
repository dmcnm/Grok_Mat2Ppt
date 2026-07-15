classdef ST_AxisUnit
%ST_AXISUNIT  Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_AxisUnit
    methods (Static)
        function v = from_xml(xmlValue)
            v = str2double(string(xmlValue));
        end
        function s = to_xml(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
            s = char(string(double(value)));
        end
        function validate(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
        end
    end
end
