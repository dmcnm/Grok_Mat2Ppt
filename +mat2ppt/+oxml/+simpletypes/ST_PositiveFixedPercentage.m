classdef ST_PositiveFixedPercentage
%ST_POSITIVEFIXEDPERCENTAGE  Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_PositiveFixedPercentage
    methods (Static)
        function v = from_xml(xmlValue)
            s = char(string(xmlValue));
            if endsWith(s, "%%")
                v = str2double(s(1:end-1)) / 100.0;
            else
                n = str2double(s);
                if abs(n) > 1
                    v = n / 100000.0;
                else
                    v = n;
                end
            end
        end
        function s = to_xml(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
            s = char(string(round(double(value) * 100000)));
        end
        function validate(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
        end
    end
end
