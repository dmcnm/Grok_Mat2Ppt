classdef FreeformBuilder < handle
%FREEFORMBUILDER  Freeform path builder shell (P5-W9).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/freeform.py (minimal shell).
%   convert_to_shape requires full custGeom — expands with geometry WP.

    properties (Access = private)
        shapes_
        startX_
        startY_
        penX_
        penY_
        ops_ = {}  % cell of structs
    end

    methods
        function obj = FreeformBuilder(shapes, startX, startY, scale)
            obj.shapes_ = shapes;
            obj.startX_ = double(mat2ppt.util.Length.toEmuInt_(startX));
            obj.startY_ = double(mat2ppt.util.Length.toEmuInt_(startY));
            obj.penX_ = obj.startX_;
            obj.penY_ = obj.startY_;
            if nargin >= 4 && ~mat2ppt.isAbsent(scale)
                % scale reserved
            end
        end

        function move_to(obj, x, y)
            obj.penX_ = double(mat2ppt.util.Length.toEmuInt_(x));
            obj.penY_ = double(mat2ppt.util.Length.toEmuInt_(y));
            obj.ops_{end+1} = struct("op", "move", "x", obj.penX_, "y", obj.penY_); %#ok<AGROW>
        end

        function line_to(obj, x, y)
            obj.penX_ = double(mat2ppt.util.Length.toEmuInt_(x));
            obj.penY_ = double(mat2ppt.util.Length.toEmuInt_(y));
            obj.ops_{end+1} = struct("op", "line", "x", obj.penX_, "y", obj.penY_); %#ok<AGROW>
        end

        function n = operation_count(obj)
            n = numel(obj.ops_);
        end
    end
end
