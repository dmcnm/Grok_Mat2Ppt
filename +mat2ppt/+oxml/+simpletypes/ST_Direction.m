classdef ST_Direction
%ST_DIRECTION  Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_Direction
    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(xmlValue);
        end
        function s = to_xml(value)
            s = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(value);
        end
        function validate(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(value);
        end
    end
end
