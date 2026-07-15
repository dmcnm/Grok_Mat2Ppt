classdef BaseEnum < handle
%BASEENUM  Integer-valued enumeration member (python-pptx enum.base.BaseEnum).
%
%   Ported from python-pptx 1.0.2: src/pptx/enum/base.py::BaseEnum (subset)

    properties (SetAccess = immutable)
        name (1,1) string
        value (1,1) double
        doc (1,1) string = ""
    end

    methods
        function obj = BaseEnum(name, value, doc)
            obj.name = string(name);
            obj.value = double(value);
            if nargin >= 3
                obj.doc = string(doc);
            end
        end

        function tf = eq(a, b)
            if isa(a, "mat2ppt.enum.BaseEnum") && isa(b, "mat2ppt.enum.BaseEnum")
                tf = a.value == b.value && strcmp(class(a), class(b));
            elseif isa(a, "mat2ppt.enum.BaseEnum")
                tf = a.value == double(b);
            else
                tf = double(a) == b.value;
            end
        end

        function s = char(obj), s = char(obj.name); end
        function s = string(obj), s = obj.name; end
    end
end
