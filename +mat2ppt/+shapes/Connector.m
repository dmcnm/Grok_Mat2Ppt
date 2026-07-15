classdef Connector < mat2ppt.shapes.BaseShape
%CONNECTOR  Connector shape (p:cxnSp).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/connector.py (P5-W5)

    methods
        function obj = Connector(cxnSp, parent)
            obj@mat2ppt.shapes.BaseShape(cxnSp, parent);
        end
        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.LINE;
        end
    end
end
