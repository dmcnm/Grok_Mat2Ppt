classdef Plots < handle
%PLOTS  1-based collection of Plot objects under plotArea (P9-W2).
%
%   Ported from python-pptx chart/chart.py::_Plots

    properties (Access = private)
        items_ cell = {}
        chart_
    end

    methods
        function obj = Plots(plotArea, chart)
            arguments
                plotArea
                chart = []
            end
            obj.chart_ = chart;
            known = ["barChart", "lineChart", "pieChart", "doughnutChart", ...
                "areaChart", "radarChart", "scatterChart", "bubbleChart"];
            obj.items_ = {};
            if isempty(plotArea)
                return
            end
            kids = plotArea.getchildren();
            for i = 1:numel(kids)
                ln = string(kids{i}.localName());
                if any(ln == known)
                    obj.items_{end+1} = mat2ppt.chart.Plot(kids{i}, chart); %#ok<AGROW>
                end
            end
        end

        function n = length(obj)
            n = numel(obj.items_);
        end

        function p = item(obj, idx)
            n = obj.length();
            idx = double(idx);
            if idx < 1 || idx > n || idx ~= floor(idx)
                error("mat2ppt:IndexOutOfRange", ...
                    "plot index %g out of range 1..%d", idx, n);
            end
            p = obj.items_{idx};
        end
    end
end
