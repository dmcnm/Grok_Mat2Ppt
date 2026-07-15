classdef Plot < handle
%PLOT  One xChart element (barChart/lineChart/…) (P9-W2).
%
%   Ported from python-pptx chart/plot.py::_BasePlot

    properties (Access = private)
        plotElm_
        chart_
    end

    methods
        function obj = Plot(plotElm, chart)
            arguments
                plotElm
                chart = []
            end
            obj.plotElm_ = plotElm;
            obj.chart_ = chart;
        end

        function elm = element(obj)
            elm = obj.plotElm_;
        end

        function ch = chart(obj)
            ch = obj.chart_;
        end

        function ln = plot_type(obj)
            %PLOT_TYPE  Local name e.g. "barChart".
            ln = char(string(obj.plotElm_.localName()));
        end

        function sc = series(obj)
            %SERIES  |SeriesCollection| (1-based).
            sc = mat2ppt.chart.SeriesCollection(obj.plotElm_, obj);
        end

        function cats = categories(obj)
            %CATEGORIES  Cellstr labels from first series (common case).
            sc = obj.series();
            if sc.length() < 1
                cats = {};
                return
            end
            cats = sc.item(1).categories();
        end

        function n = category_count(obj)
            n = mat2ppt.oxml.chart.CT_Plot.cat_pt_count(obj.plotElm_);
        end

        function v = barDir(obj)
            v = mat2ppt.oxml.chart.CT_Plot.barDir_val(obj.plotElm_);
        end

        function v = grouping(obj)
            v = mat2ppt.oxml.chart.CT_Plot.grouping_val(obj.plotElm_);
        end

        function tf = has_data_labels(obj)
            kids = obj.plotElm_.getchildren();
            tf = false;
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "dLbls")
                    tf = true;
                    return
                end
            end
        end

        function set_has_data_labels(obj, value)
            %SET_HAS_DATA_LABELS  Add/remove default c:dLbls (python has_data_labels).
            if ~logical(value)
                kids = obj.plotElm_.getchildren();
                for i = numel(kids):-1:1
                    if strcmp(char(kids{i}.localName()), "dLbls")
                        obj.plotElm_.remove(kids{i});
                    end
                end
                return
            end
            if obj.has_data_labels()
                return
            end
            dLbls = mat2ppt.oxml.chart.CT_DLbls.new_dLbls();
            % show values by default when enabling (python)
            kids = dLbls.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "showVal")
                    kids{i}.set("val", "1");
                end
            end
            % insert before first axId if present (1-based child index)
            kids = obj.plotElm_.getchildren();
            insertIdx = numel(kids) + 1;
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "axId")
                    insertIdx = i;
                    break
                end
            end
            obj.plotElm_.insert(insertIdx, dLbls);
        end

        function dl = data_labels(obj)
            %DATA_LABELS  |DataLabels|; errors if none (enable via set_has_data_labels).
            kids = obj.plotElm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "dLbls")
                    dl = mat2ppt.chart.DataLabels(kids{i});
                    return
                end
            end
            error("mat2ppt:ValueError", ...
                "plot has no data labels, set_has_data_labels(true) first");
        end
    end
end
