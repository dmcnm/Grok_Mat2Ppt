classdef XsdAnyUri
%XSDANYURI  URI / pack path attribute.
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::XsdAnyUri

    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(xmlValue);
        end
        function s = to_xml(value)
            s = mat2ppt.oxml.simpletypes.BaseSimpleType.validate_string(value);
        end
    end
end
