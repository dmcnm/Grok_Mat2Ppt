classdef PartElementProxy < mat2ppt.shared.ElementProxy
%PARTELEMENTPROXY  Proxy for a part's root element.
%
%   Ported from python-pptx 1.0.2: src/pptx/shared.py::PartElementProxy

    properties (Access = protected)
        part_
    end

    methods
        function obj = PartElementProxy(element, part)
            arguments
                element (1,1) mat2ppt.oxml.XmlElement
                part
            end
            obj@mat2ppt.shared.ElementProxy(element);
            obj.part_ = part;
        end

        function p = part(obj)
            p = obj.part_;
        end
    end
end
