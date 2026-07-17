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
            %FIRST_PLOT  First Plot object (or [] if none).
            ps = obj.plots();
            if ps.length() < 1
                plot = [];
            else
                plot = ps.item(1);
            end
        end

        function ps = plots(obj)
            %PLOTS  1-based |Plots| collection under plotArea.
            ps = mat2ppt.chart.Plots(obj.plotArea(), obj);
        end

        function sc = series(obj)
            %SERIES  SeriesCollection of first plot (python Chart.series).
            p = obj.first_plot();
            if isempty(p)
                error("mat2ppt:ValueError", "chart has no plot");
            end
            sc = p.series();
        end

        function n = series_count(obj)
            sc = obj.series();
            n = sc.length();
        end

        function sers = series_elements(obj)
            %SERIES_ELEMENTS  Raw c:ser cells (document order).
            p = obj.first_plot();
            if isempty(p)
                sers = {};
                return
            end
            sers = mat2ppt.oxml.chart.CT_Plot.series_elements(p.element());
        end

        function name = series_name(obj, idx)
            %SERIES_NAME  1-based series name from cache.
            sc = obj.series();
            name = sc.item(idx).name();
        end

        function tf = has_legend(obj)
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            leg = mat2ppt.oxml.chart.CT_Legend.find_legend(ch);
            tf = ~isempty(leg);
        end

        function leg = legend(obj)
            %LEGEND  |Legend| or [] if absent.
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            legElm = mat2ppt.oxml.chart.CT_Legend.find_legend(ch);
            if isempty(legElm)
                leg = [];
            else
                leg = mat2ppt.chart.Legend(legElm);
            end
        end

        function set_has_legend(obj, value)
            %SET_HAS_LEGEND  Add default legend or remove (python has_legend).
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            if isempty(ch)
                error("mat2ppt:ValueError", "chart element missing");
            end
            if ~logical(value)
                kids = ch.getchildren();
                for i = numel(kids):-1:1
                    if strcmp(char(kids{i}.localName()), "legend")
                        ch.remove(kids{i});
                    end
                end
                return
            end
            if obj.has_legend()
                return
            end
            leg = mat2ppt.oxml.chart.CT_Legend.new_legend("r");
            % insert before dispBlanksAs if present
            kids = ch.getchildren();
            insertIdx = numel(kids) + 1;
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "dispBlanksAs")
                    insertIdx = i;
                    break
                end
            end
            ch.insert(insertIdx, leg);
        end

        function tf = has_category_axis(obj)
            pa = obj.plotArea();
            tf = ~isempty(mat2ppt.oxml.chart.CT_Axis.find_catAx(pa));
        end

        function tf = has_value_axis(obj)
            pa = obj.plotArea();
            tf = ~isempty(mat2ppt.oxml.chart.CT_Axis.find_valAx(pa));
        end

        function ax = category_axis(obj)
            %CATEGORY_AXIS  |Axis| for catAx (or dateAx/valAx fallback).
            pa = obj.plotArea();
            elm = mat2ppt.oxml.chart.CT_Axis.find_catAx(pa);
            if isempty(elm)
                axes = mat2ppt.oxml.chart.CT_Axis.list_axes(pa);
                if isempty(axes)
                    error("mat2ppt:ValueError", "chart has no category axis");
                end
                elm = axes{1};
            end
            ax = mat2ppt.chart.Axis(elm);
        end

        function ax = value_axis(obj)
            %VALUE_AXIS  |Axis| for valAx.
            pa = obj.plotArea();
            elm = mat2ppt.oxml.chart.CT_Axis.find_valAx(pa);
            if isempty(elm)
                error("mat2ppt:ValueError", "chart has no value axis");
            end
            ax = mat2ppt.chart.Axis(elm);
        end

        function replace_data(obj, chartData)
            %REPLACE_DATA  Rebuild series caches + (optional) xlsx from chartData (P9-W4).
            arguments
                obj
                chartData mat2ppt.chart.CategoryChartData
            end
            ct = obj.chart_type();
            newCs = mat2ppt.oxml.parse_xml(chartData.xml_string(ct));
            % preserve externalData from old chartSpace
            oldExt = [];
            kidsOld = obj.chartSpace_.getchildren();
            for i = 1:numel(kidsOld)
                if strcmp(char(kidsOld{i}.localName()), "externalData")
                    oldExt = kidsOld{i};
                    break
                end
            end
            % clear chartSpace children
            kids = obj.chartSpace_.getchildren();
            for i = numel(kids):-1:1
                obj.chartSpace_.remove(kids{i});
            end
            % append rebuilt content
            newKids = newCs.getchildren();
            for i = 1:numel(newKids)
                obj.chartSpace_.append(newKids{i});
            end
            if ~isempty(oldExt)
                % re-attach preserved externalData (xlsx rel)
                obj.chartSpace_.append(oldExt);
            end
            % refresh embedded workbook when package available
            if ~isempty(obj.chartPart_) && isstruct(obj.chartPart_) ...
                    && isfield(obj.chartPart_, "package") && isfield(obj.chartPart_, "partname")
                pkg = obj.chartPart_.package;
                chartPn = obj.chartPart_.partname;
                try
                    xlsxPn = mat2ppt.opc.related_partname_by_type(pkg, chartPn, ...
                        mat2ppt.opc.RELATIONSHIP_TYPE.PACKAGE);
                    if ~isempty(xlsxPn)
                        pkg.add_blob_part(xlsxPn, chartData.xlsx_blob(), ...
                            mat2ppt.opc.CONTENT_TYPE.SML_SHEET);
                    end
                catch
                end
                % ensure xml map refreshed
                pkg.replace_xml_part(chartPn, obj.chartSpace_);
            end
        end

        function ct = chart_type(obj)
            %CHART_TYPE  Best-effort XL_CHART_TYPE for first plot (shell).
            XL = mat2ppt.enum.XL_CHART_TYPE;
            plot = obj.first_plot();
            if isempty(plot)
                error("mat2ppt:ValueError", "chart has no plot");
            end
            ln = plot.plot_type();
            switch ln
                case "barChart"
                    barDir = plot.barDir();
                    grp = plot.grouping();
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
                case "areaChart"
                    ct = XL.AREA;
                case "radarChart"
                    ct = XL.RADAR;
                case "scatterChart"
                    ct = XL.XY_SCATTER;
                case "bubbleChart"
                    ct = XL.BUBBLE;
                otherwise
                    error("mat2ppt:notYetPorted", ...
                        "chart_type for plot %s not yet mapped", ln);
            end
        end

        function tf = has_title(obj)
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            t = ch.find("c:title");
            if isempty(t)
                kids = ch.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "title")
                        tf = true; return
                    end
                end
                tf = false;
            else
                tf = true;
            end
        end

        function titleElm = chart_title(obj)
            %CHART_TITLE  Ensure c:title exists; return element (R5-W6).
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(obj.chartSpace_);
            titleElm = ch.find("c:title");
            if isempty(titleElm)
                kids = ch.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "title")
                        titleElm = kids{i}; break
                    end
                end
            end
            if isempty(titleElm)
                titleElm = mat2ppt.oxml.OxmlElement("c:title");
                tx = mat2ppt.oxml.OxmlElement("c:tx");
                rich = mat2ppt.oxml.OxmlElement("c:rich");
                rich.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
                rich.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
                p = mat2ppt.oxml.OxmlElement("a:p");
                rich.append(p);
                tx.append(rich);
                titleElm.append(tx);
                % insert after autoTitleDeleted if present
                ch.append(titleElm);
            end
        end

        function v = chart_style(obj)
            %CHART_STYLE  c:style@val or [] (R5-W6).
            cs = obj.chartSpace_;
            st = cs.find("c:style");
            if isempty(st)
                kids = cs.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "style")
                        st = kids{i}; break
                    end
                end
            end
            if isempty(st)
                v = [];
            else
                raw = st.get("val");
                if mat2ppt.isAbsent(raw), v = []; else, v = str2double(string(raw)); end
            end
        end

        function set_chart_style(obj, value)
            cs = obj.chartSpace_;
            % remove existing
            kids = cs.getchildren();
            for i = numel(kids):-1:1
                if strcmp(char(kids{i}.localName()), "style")
                    cs.remove(kids{i});
                end
            end
            if mat2ppt.isAbsent(value), return; end
            st = mat2ppt.oxml.OxmlElement("c:style");
            st.set("val", char(string(round(double(value)))));
            cs.append(st);
        end
    end
end
