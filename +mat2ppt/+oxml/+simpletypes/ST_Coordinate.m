classdef ST_Coordinate
%ST_COORDINATE  EMU length attribute (int).
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_Coordinate

    methods (Static)
        function v = from_xml(xmlValue)
            v = mat2ppt.util.Emu(str2double(string(xmlValue)));
        end

        function s = to_xml(value)
            if isa(value, "mat2ppt.util.Length")
                emu = value.emu;
            else
                emu = double(value);
            end
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(emu);
            s = char(string(round(emu)));
        end

        function validate(value)
            if isa(value, "mat2ppt.util.Length")
                mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(value.emu);
            else
                mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(value);
            end
        end
    end
end
