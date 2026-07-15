classdef Font < handle
%FONT  Character formatting (subset of python-pptx text.Font).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::Font (thin shell)

    properties
        bold = []       % [] = absent/inherit; true/false set
        italic = []
        name = []       % string or []
        size = []       % Length or []
    end

    methods
        function obj = Font()
        end
    end
end
