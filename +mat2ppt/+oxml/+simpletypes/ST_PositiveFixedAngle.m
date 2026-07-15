classdef ST_PositiveFixedAngle
%ST_POSITIVEFIXEDANGLE  Delegates to ST_Angle.
    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.oxml.simpletypes.ST_Angle.from_xml(xmlValue);
        end
        function s = to_xml(value)
            s = mat2ppt.oxml.simpletypes.ST_Angle.to_xml(value);
        end
    end
end
