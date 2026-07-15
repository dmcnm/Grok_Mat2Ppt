classdef FillFormat < handle
%FILLFORMAT  Fill properties API surface (requires oxml fill parent for live XML).
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/fill.py::FillFormat
%   Deep shell: type tracking + solid/background without full CT_* graph.

    properties (Access = private)
        parentElm_ = []
        type_ = []  % MSO_FILL_TYPE member or []
        foreRgb_ = []  % RGBColor or []
    end

    methods
        function obj = FillFormat(parentElm)
            if nargin >= 1
                obj.parentElm_ = parentElm;
            end
        end

        function t = type(obj)
            t = obj.type_;
        end

        function solid(obj)
            obj.type_ = mat2ppt.enum.MSO_FILL.SOLID;
        end

        function background(obj)
            obj.type_ = mat2ppt.enum.MSO_FILL.BACKGROUND;
        end

        function c = fore_color_rgb(obj)
            %FORE_COLOR_RGB  Provisional RGB accessor until ColorFormat lands fully.
            c = obj.foreRgb_;
        end

        function set_fore_color_rgb(obj, rgb)
            arguments
                obj
                rgb (1,1) mat2ppt.dml.RGBColor
            end
            obj.solid();
            obj.foreRgb_ = rgb;
        end
    end

    methods (Static)
        function f = from_fill_parent(parentElm)
            f = mat2ppt.dml.FillFormat(parentElm);
        end
    end
end
