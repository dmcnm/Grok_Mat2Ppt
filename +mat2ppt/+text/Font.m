classdef Font < handle
%FONT  Character formatting (python-pptx text.Font surface).
%
%   When constructed without an element, acts as a free-standing property bag
%   (tests / pre-xmlchemy). With a rPr-like XmlElement, property access will
%   map onto attributes as the oxml text layer lands.
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::Font

    properties (Access = private)
        rPr_ = []  % optional XmlElement
    end

    properties
        % [] = absent/inherit (None); logical true/false when set
        bold = []
        italic = []
        name = []       % string or []
        size = []       % Length or []
        underline = []  % logical, BaseXmlEnum, or []
        language_id = []
    end

    methods
        function obj = Font(rPr)
            if nargin >= 1 && ~mat2ppt.isAbsent(rPr)
                obj.rPr_ = rPr;
            end
        end

        function e = element(obj)
            e = obj.rPr_;
        end
    end
end
