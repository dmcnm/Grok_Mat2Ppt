classdef Chart < handle
%CHART  User-facing chart proxy over c:chartSpace (P9-W1).
%
%   ch = graphicFrame.chart()
%   ch.has_legend() / ch.series_count() / ch.chart_type()
%
%   Public series indexing is **1-based**.
%   Ported shell from python-pptx 1.0.2: src/pptx/chart/chart.py::Chart

    properties (Access = private)
        chartSpace_
        chartPart_   % optional; may be []
    end

    methods
        function obj = Chart(chartSpace, chartPart)
            arguments
                chartSpace
                chartPart = []
            end
            obj.chartSpace_ = chartSpace;
            obj.chartPart_ = chartPart;
        end

        function cs = chartSpace(obj)
            cs = obj.chartSpace_;
        end

        function pa = plotArea(obj)
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(obj.chartSpace_);
        end

        function plot = first_plot(obj)
            plot = mat2ppt.oxml.chart.CT_Plot.first_plot(obj.plotArea());
        end

        function n = series_count(obj)
            plot = obj.first_plot();
            n = mat2ppt.oxml.chart.CT_Plot.series_count(plot);
        end

        function sers = series_elements(obj)
            %SERIES_ELEMENTS  Raw c:ser cells (document order).
            sers = mat2ppt.oxml.chart.CT_Plot.series_elements(obj.first_plot());
        end

        function name = series_name(obj, idx)
            %SERIES_NAME  1-based series name from cache.
            sers = obj.series_elements();
            n = numel(sers);
            idx = double(idx);
            if idx < 1 || idx > n || idx ~= floor(idx)
                error("mat2ppt:IndexOutOfRange", ...
                    "series index %g out of range 1..%d", idx, n);
            end
            name = mat2ppt.oxml.chart.CT_Series.series_name(sers{idx});
        end

        function tf = has_legend(obj)
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            leg = mat2ppt.oxml.chart.CT_Legend.find_legend(ch);
            tf = ~isempty(leg);
        end

        function tf = has_category_axis(obj)
            pa = obj.plotArea();
            tf = ~isempty(mat2ppt.oxml.chart.CT_Axis.find_catAx(pa));
        end

        function tf = has_value_axis(obj)
            pa = obj.plotArea();
            tf = ~isempty(mat2ppt.oxml.chart.CT_Axis.find_valAx(pa));
        end

        function ct = chart_type(obj)
            %CHART_TYPE  Best-effort XL_CHART_TYPE for first plot (shell).
            XL = mat2ppt.enum.XL_CHART_TYPE;
            plot = obj.first_plot();
            if isempty(plot)
                error("mat2ppt:ValueError", "chart has no plot");
            end
            ln = char(string(plot.localName()));
            switch ln
                case "barChart"
                    barDir = mat2ppt.oxml.chart.CT_Plot.barDir_val(plot);
                    grp = mat2ppt.oxml.chart.CT_Plot.grouping_val(plot);
                    if strcmp(barDir, "bar")
                        if strcmp(grp, "stacked")
                            ct = XL.BAR_STACKED;
                        elseif strcmp(grp, "percentStacked")
                            ct = XL.BAR_STACKED_100;
                        else
                            ct = XL.BAR_CLUSTERED;
                        end
                    else
                        if strcmp(grp, "stacked")
                            ct = XL.COLUMN_STACKED;
                        elseif strcmp(grp, "percentStacked")
                            ct = XL.COLUMN_STACKED_100;
                        else
                            ct = XL.COLUMN_CLUSTERED;
                        end
                    end
                case "lineChart"
                    ct = XL.LINE;
                case "pieChart"
                    ct = XL.PIE;
                case "doughnutChart"
                    ct = XL.DOUGHNUT;
                otherwise
                    error("mat2ppt:notYetPorted", ...
                        "chart_type for plot %s not yet mapped (P9 residual)", ln);
            end
        end
    end
end
