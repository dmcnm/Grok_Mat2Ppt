classdef ChartPart < mat2ppt.opc.XmlPart
%CHARTPART  Chart package part (c:chartSpace).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/chart.py::ChartPart (P8-W1)

    methods
        function obj = ChartPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end

        function cs = chartSpace(obj)
            cs = obj.element();
        end

        function pa = plotArea(obj)
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(obj.element());
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.ChartPart(partname, contentType, package, elm);
        end

        function obj = from_chartspace(partname, package, chartSpaceElm)
            obj = mat2ppt.parts.ChartPart(partname, ...
                mat2ppt.opc.CONTENT_TYPE.DML_CHART, package, chartSpaceElm);
        end
    end
end

