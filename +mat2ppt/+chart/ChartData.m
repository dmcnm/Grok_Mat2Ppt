classdef ChartData < mat2ppt.chart.CategoryChartData
%CHARTDATA  Alias for CategoryChartData (python-pptx ChartData).
%
%   Ported from python-pptx 1.0.2: src/pptx/chart/data.py::ChartData

    methods
        function obj = ChartData()
            obj@mat2ppt.chart.CategoryChartData();
        end
    end
end
