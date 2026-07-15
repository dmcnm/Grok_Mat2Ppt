classdef CT_Plot
%CT_PLOT  Helpers for c:barChart / c:lineChart / c:pieChart etc. (P8-W7).
%
%   Ported subset from python-pptx oxml/chart/plot.py::BaseChartElement

    methods (Static)
        function plot = first_plot(plotArea)
            %FIRST_PLOT  First recognized xChart child of plotArea, or [].
            if isempty(plotArea)
                plot = [];
                return
            end
            known = ["barChart", "lineChart", "pieChart", "doughnutChart", ...
                "areaChart", "radarChart", "scatterChart", "bubbleChart"];
            kids = plotArea.getchildren();
            for i = 1:numel(kids)
                ln = string(kids{i}.localName());
                if any(ln == known)
                    plot = kids{i};
                    return
                end
            end
            plot = [];
        end

        function sers = series_elements(plotElm)
            %SERIES_ELEMENTS  c:ser children in document order.
            sers = {};
            if isempty(plotElm)
                return
            end
            kids = plotElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "ser")
                    sers{end+1} = kids{i}; %#ok<AGROW>
                end
            end
        end

        function n = series_count(plotElm)
            n = numel(mat2ppt.oxml.chart.CT_Plot.series_elements(plotElm));
        end

        function v = child_val(plotElm, localName, defaultVal)
            %CHILD_VAL  @val of first child with localName, or defaultVal.
            if nargin < 3
                defaultVal = [];
            end
            v = defaultVal;
            if isempty(plotElm)
                return
            end
            kids = plotElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), char(string(localName)))
                    got = kids{i}.get("val");
                    if ~mat2ppt.isAbsent(got)
                        v = char(string(got));
                    end
                    return
                end
            end
        end

        function v = barDir_val(plotElm)
            v = mat2ppt.oxml.chart.CT_Plot.child_val(plotElm, "barDir", "col");
        end

        function v = grouping_val(plotElm, defaultVal)
            if nargin < 2 || isempty(defaultVal)
                % bar defaults clustered; line/area default standard
                ln = "";
                if ~isempty(plotElm)
                    ln = string(plotElm.localName());
                end
                if ln == "barChart"
                    defaultVal = "clustered";
                else
                    defaultVal = "standard";
                end
            end
            v = mat2ppt.oxml.chart.CT_Plot.child_val(plotElm, "grouping", defaultVal);
        end

        function n = cat_pt_count(plotElm)
            %CAT_PT_COUNT  ptCount under first series cat cache.
            sers = mat2ppt.oxml.chart.CT_Plot.series_elements(plotElm);
            if isempty(sers)
                n = 0;
                return
            end
            n = mat2ppt.oxml.chart.CT_Series.cat_ptCount_val(sers{1});
        end
    end
end
