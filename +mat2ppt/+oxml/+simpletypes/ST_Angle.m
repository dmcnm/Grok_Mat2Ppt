classdef ST_Angle
%ST_ANGLE  Degrees; XML is 60000ths. Ported from python-pptx.
    methods (Static)
        function v = from_xml(xmlValue)
            DEG = 60000; THREE = 360 * DEG;
            rot = mod(str2double(string(xmlValue)), THREE);
            v = double(rot) / DEG;
        end
        function s = to_xml(value)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
            DEG = 60000; THREE = 360 * DEG;
            rot = mod(round(double(value) * DEG), THREE);
            s = char(string(rot));
        end
    end
end
