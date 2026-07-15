classdef CT_SolidColorFillProperties < mat2ppt.oxml.BaseOxmlElement
%CT_SOLIDCOLORFILLPROPERTIES  a:solidFill (P5-W10).
%
%   Ported from python-pptx oxml/dml/fill.py pattern

    methods
        function obj = CT_SolidColorFillProperties(tag)
            if nargin < 1, tag = "a:solidFill"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function srgb = get_or_change_to_srgbClr(obj)
            % Remove other color choices, ensure srgbClr
            kids = obj.getchildren();
            for i = numel(kids):-1:1
                ln = char(kids{i}.localName());
                if ~strcmp(ln, "srgbClr")
                    obj.remove(kids{i});
                end
            end
            srgb = obj.find("a:srgbClr");
            if isempty(srgb)
                srgb = mat2ppt.oxml.dml.CT_SRgbColor.new("000000");
                obj.append(srgb);
            end
        end
    end
end
