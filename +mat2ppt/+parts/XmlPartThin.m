classdef XmlPartThin < mat2ppt.opc.XmlPart
%XMLPARTTHIN  Shared thin XmlPart constructor for domain parts (M1).
%
%   Subclasses only establish identity for PartFactory map.

    methods
        function obj = XmlPartThin(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end

    methods (Static)
        function obj = load_as(clsName, partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            ctor = str2func(clsName);
            obj = ctor(partname, contentType, package, elm);
        end
    end
end
