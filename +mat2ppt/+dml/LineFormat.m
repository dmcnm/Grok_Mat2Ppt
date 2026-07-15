classdef LineFormat < handle
%LINEFORMAT  Line properties API surface.
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/line.py::LineFormat

    properties (Access = private)
        parent_
        fill_
        width_ = []
        dashStyle_ = []
    end

    properties (Dependent)
        width
        dash_style
    end

    methods
        function obj = LineFormat(parent)
            if nargin >= 1
                obj.parent_ = parent;
            end
            obj.fill_ = mat2ppt.dml.FillFormat();
        end

        function f = fill(obj)
            f = obj.fill_;
        end

        function w = get.width(obj)
            w = obj.width_;
        end

        function set.width(obj, w)
            if mat2ppt.isAbsent(w)
                obj.width_ = [];
            else
                if ~isa(w, "mat2ppt.util.Length")
                    w = mat2ppt.util.Emu(w);
                end
                obj.width_ = w;
            end
        end

        function d = get.dash_style(obj)
            d = obj.dashStyle_;
        end

        function set.dash_style(obj, d)
            obj.dashStyle_ = d;
        end
    end
end
