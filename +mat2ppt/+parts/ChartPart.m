classdef ChartPart < mat2ppt.opc.XmlPart
%CHARTPART  Thin XmlPart (M1 shell; charts in P8/P9).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/chart.py::ChartPart

    methods
        function obj = ChartPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.ChartPart(partname, contentType, package, elm);
        end
    end
end
