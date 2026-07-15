classdef ElementProxy < handle
%ELEMENTPROXY  Base for objects that proxy an XmlElement.
%
%   Ported from python-pptx 1.0.2: src/pptx/shared.py::ElementProxy

    properties (Access = protected)
        element_  % mat2ppt.oxml.XmlElement
    end

    methods
        function obj = ElementProxy(element)
            arguments
                element (1,1) mat2ppt.oxml.XmlElement
            end
            obj.element_ = element;
        end

        function e = element(obj)
            %ELEMENT  Proxied XmlElement.
            e = obj.element_;
        end

        function tf = eq(a, b)
            if ~isa(b, "mat2ppt.shared.ElementProxy")
                tf = false;
                return
            end
            tf = a.element_ == b.element_;
        end

        function tf = ne(a, b)
            tf = ~eq(a, b);
        end
    end
end
