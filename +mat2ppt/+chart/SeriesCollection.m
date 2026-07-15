classdef SeriesCollection < handle
%SERIESCOLLECTION  1-based collection of CategorySeries on a plot (P9-W2).
%
%   Ported from python-pptx chart/series.py::SeriesCollection
%   MATLAB public index is **1-based** (python 0-based).

    properties (Access = private)
        plotElm_
        plot_    % parent Plot
        items_ cell = {}
    end

    methods
        function obj = SeriesCollection(plotElm, plot)
            arguments
                plotElm
                plot = []
            end
            obj.plotElm_ = plotElm;
            obj.plot_ = plot;
            sers = mat2ppt.oxml.chart.CT_Plot.series_elements(plotElm);
            obj.items_ = cell(1, numel(sers));
            for i = 1:numel(sers)
                obj.items_{i} = mat2ppt.chart.CategorySeries(sers{i}, plot);
            end
        end

        function n = length(obj)
            n = numel(obj.items_);
        end

        function n = numel(obj)
            n = obj.length();
        end

        function s = item(obj, idx)
            %ITEM  1-based series access.
            n = obj.length();
            idx = double(idx);
            if idx < 1 || idx > n || idx ~= floor(idx)
                error("mat2ppt:IndexOutOfRange", ...
                    "series index %g out of range 1..%d", idx, n);
            end
            s = obj.items_{idx};
        end

        function names = names(obj)
            names = cell(1, obj.length());
            for i = 1:obj.length()
                names{i} = obj.items_{i}.name();
            end
        end
    end
end
