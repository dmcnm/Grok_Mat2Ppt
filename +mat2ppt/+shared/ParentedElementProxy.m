classdef ParentedElementProxy < mat2ppt.shared.ElementProxy
%PARENTEDELEMENTPROXY  Element proxy with parent (ProvidesPart).
%
%   Ported from python-pptx 1.0.2: src/pptx/shared.py::ParentedElementProxy

    properties (Access = protected)
        parent_
    end

    methods
        function obj = ParentedElementProxy(element, parent)
            arguments
                element (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ElementProxy(element);
            obj.parent_ = parent;
        end

        function p = parent(obj)
            p = obj.parent_;
        end

        function p = part(obj)
            %PART  Package part via parent.part chain.
            if ismethod(obj.parent_, "part") || isprop(obj.parent_, "part")
                p = obj.parent_.part;
            elseif ismethod(obj.parent_, "package")
                p = obj.parent_;
            else
                error("mat2ppt:AttributeError", "parent does not provide .part");
            end
        end
    end
end
