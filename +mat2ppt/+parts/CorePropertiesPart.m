classdef CorePropertiesPart < mat2ppt.opc.XmlPart
%COREPROPERTIESPART  XmlPart for /docProps/core.xml.
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/coreprops.py::CorePropertiesPart

    methods
        function obj = CorePropertiesPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end

        function cp = core_properties(obj)
            cp = mat2ppt.parts.CoreProperties(obj.element());
        end
    end

    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.CorePropertiesPart(partname, contentType, package, elm);
        end
    end
end
