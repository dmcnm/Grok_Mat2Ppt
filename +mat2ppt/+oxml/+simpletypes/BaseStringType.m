classdef BaseStringType
%BASESTRINGTYPE  Ported from python-pptx oxml/simpletypes.py
    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(xmlValue);
        end
        function s = to_xml(value)
            s = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(value);
        end
        function validate(value), mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(value); end
    end
end
