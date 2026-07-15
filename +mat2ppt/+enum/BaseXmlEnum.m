classdef BaseXmlEnum < mat2ppt.enum.BaseEnum
%BASEXMLENUM  Integer enum member with XML attribute mapping.
%
%   Ported from python-pptx 1.0.2: src/pptx/enum/base.py::BaseXmlEnum

    properties (SetAccess = immutable)
        xml_value (1,1) string = ""
    end

    methods
        function obj = BaseXmlEnum(name, value, xmlValue, doc)
            if nargin < 4
                doc = "";
            end
            obj@mat2ppt.enum.BaseEnum(name, value, doc);
            if nargin >= 3 && ~mat2ppt.isAbsent(xmlValue)
                obj.xml_value = string(xmlValue);
            end
        end
    end
end
