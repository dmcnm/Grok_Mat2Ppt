classdef Adjustment < handle
%ADJUSTMENT  Autoshape adjustment handle value.
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/autoshape.py::Adjustment

    properties
        name (1,1) string = ""
        def_val (1,1) double = 0
        actual = []  % [] = use def_val
    end

    properties (Dependent)
        effective_value
    end

    methods
        function obj = Adjustment(name, defVal, actual)
            if nargin >= 1, obj.name = string(name); end
            if nargin >= 2, obj.def_val = double(defVal); end
            if nargin >= 3, obj.actual = actual; end
        end

        function v = get.effective_value(obj)
            if mat2ppt.isAbsent(obj.actual)
                raw = obj.def_val;
            else
                raw = double(obj.actual);
            end
            v = raw / 100000.0;
        end
        function set.effective_value(obj, value)
            if ~isnumeric(value) || ~isscalar(value)
                error("mat2ppt:ValueError", "adjustment value must be numeric");
            end
            obj.actual = round(double(value) * 100000.0);
        end
    end
end
