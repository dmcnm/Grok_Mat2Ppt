classdef ProgIdMember < mat2ppt.enum.BaseEnum
%PROGIDMEMBER  PROG_ID member with OLE metadata (R7-W1 / DEF-011).
%
%   Ported from python-pptx 1.0.2: src/pptx/enum/shapes.py::PROG_ID members

    properties (SetAccess = immutable)
        progId (1,1) string = ""
        icon_filename (1,1) string = ""
        width (1,1) double = 965200   % EMU default
        height (1,1) double = 609600  % EMU default
    end

    methods
        function obj = ProgIdMember(name, value, progId, iconFilename, widthEmu, heightEmu)
            arguments
                name
                value
                progId
                iconFilename
                widthEmu = 965200
                heightEmu = 609600
            end
            obj@mat2ppt.enum.BaseEnum(name, value, "");
            obj.progId = string(progId);
            obj.icon_filename = string(iconFilename);
            obj.width = double(widthEmu);
            obj.height = double(heightEmu);
        end

        function s = prog_id(obj)
            %PROG_ID  COM progId string (python member.progId).
            s = char(obj.progId);
        end

        function f = icon_filename_str(obj)
            f = char(obj.icon_filename);
        end
    end
end
