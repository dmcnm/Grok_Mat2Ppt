classdef XsdBoolean
%XSDBOOLEAN  XML boolean attribute (true/false/1/0).
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::XsdBoolean

    methods (Static)
        function v = from_xml(xmlValue)
            s = char(string(xmlValue));
            switch s
                case {"1", "true"}
                    v = true;
                case {"0", "false"}
                    v = false;
                otherwise
                    error("mat2ppt:InvalidXmlError", "invalid xsd:boolean '%s'", s);
            end
        end

        function s = to_xml(value)
            if value
                s = "1";
            else
                s = "0";
            end
            s = char(s);
        end

        function validate(value)
            if ~(islogical(value) && isscalar(value))
                error("mat2ppt:TypeError", "value must be logical scalar");
            end
        end
    end
end
