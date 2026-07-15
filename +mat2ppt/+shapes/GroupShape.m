classdef GroupShape < mat2ppt.shapes.BaseShape
%GROUPSHAPE  Group shape (p:grpSp).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/group.py (P5-W6)

    methods
        function obj = GroupShape(grpSp, parent)
            obj@mat2ppt.shapes.BaseShape(grpSp, parent);
        end
        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.GROUP;
        end
    end
end
