classdef XmlPart < mat2ppt.opc.Part
%XMLPART  Package part with XML element payload.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/package.py::XmlPart

    properties (Access = protected)
        element_
    end

    methods
        function obj = XmlPart(partname, contentType, package, element)
            obj@mat2ppt.opc.Part(partname, contentType, package, uint8([]));
            obj.element_ = element;
        end

        function b = blob(obj)
            b = mat2ppt.oxml.serialize_part_xml(obj.element_);
        end

        function e = element(obj)
            e = obj.element_;
        end

        function p = part(obj)
            %PART  ProvidesPart: this part.
            p = obj;
        end
    end

    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            mat2ppt.oxml.register_domain_element_classes();
            try
                elm = mat2ppt.oxml.BaseOxmlElement.from_xml_element(elm);
            catch
            end
            obj = mat2ppt.opc.XmlPart(partname, contentType, package, elm);
        end
    end
end
