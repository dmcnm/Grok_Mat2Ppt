classdef ST_Percentage
%ST_PERCENTAGE  Percentage as float 0..1 stored as percent literal or 1000ths.
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_Percentage (common path)

    methods (Static)
        function v = from_xml(xmlValue)
            s = char(string(xmlValue));
            if endsWith(s, "%")
                v = str2double(s(1:end-1)) / 100.0;
            else
                % OOXML often uses 1000ths of a percent (e.g. 50000 = 50%)
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
    end
end
