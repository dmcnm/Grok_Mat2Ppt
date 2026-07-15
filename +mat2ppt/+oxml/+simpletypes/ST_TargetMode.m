classdef ST_TargetMode
%ST_TARGETMODE  Relationship TargetMode Internal|External.
%
%   Ported from python-pptx 1.0.2: oxml/simpletypes.py::ST_TargetMode

    methods (Static)
        function v = from_xml(xmlValue)
            s = char(string(xmlValue));
            if strcmp(s, "External")
                v = "External";
            else
                v = "Internal";
            end
        end
        function s = to_xml(value)
            s = char(string(value));
            if ~strcmp(s, "External") && ~strcmp(s, "Internal")
                error("mat2ppt:ValueError", "TargetMode must be Internal or External");
            end
        end
    end
end
