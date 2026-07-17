function writer = ChartXmlWriter(chartType, chartData)
%CHARTXMLWRITER  Factory for chart XML builders (P8 + R5 residual types).
%
%   Ported from python-pptx 1.0.2: chart/xmlwriter.py::ChartXmlWriter

    XL = mat2ppt.enum.XL_CHART_TYPE;
    ct = chartType;
    if isa(ct, "mat2ppt.enum.BaseEnum")
        ctVal = ct.value;
        ctName = char(ct.name);
    else
        ctVal = double(ct);
        ctName = sprintf('%g', ctVal);
    end

    barCol = [ ...
        XL.BAR_CLUSTERED.value, XL.BAR_STACKED.value, XL.BAR_STACKED_100.value, ...
        XL.COLUMN_CLUSTERED.value, XL.COLUMN_STACKED.value, XL.COLUMN_STACKED_100.value];
    lineTypes = [ ...
        XL.LINE.value, XL.LINE_MARKERS.value, XL.LINE_MARKERS_STACKED.value, ...
        XL.LINE_MARKERS_STACKED_100.value, XL.LINE_STACKED.value, XL.LINE_STACKED_100.value];
    pieTypes = [ ...
        XL.PIE.value, XL.PIE_EXPLODED.value, ...
        XL.DOUGHNUT.value, XL.DOUGHNUT_EXPLODED.value];
    areaTypes = [XL.AREA.value, XL.AREA_STACKED.value, XL.AREA_STACKED_100.value];
    radarTypes = [XL.RADAR.value, XL.RADAR_FILLED.value, XL.RADAR_MARKERS.value];
    xyTypes = [ ...
        XL.XY_SCATTER.value, XL.XY_SCATTER_LINES.value, XL.XY_SCATTER_LINES_NO_MARKERS.value, ...
        XL.XY_SCATTER_SMOOTH.value, XL.XY_SCATTER_SMOOTH_NO_MARKERS.value];
    bubbleTypes = [XL.BUBBLE.value, XL.BUBBLE_THREE_D_EFFECT.value];

    if any(ctVal == barCol)
        writer = mat2ppt.chart.BarChartXmlWriter(chartType, chartData);
    elseif any(ctVal == lineTypes)
        writer = mat2ppt.chart.LineChartXmlWriter(chartType, chartData);
    elseif any(ctVal == pieTypes)
        writer = mat2ppt.chart.PieChartXmlWriter(chartType, chartData);
    elseif any(ctVal == areaTypes)
        writer = mat2ppt.chart.AreaChartXmlWriter(chartType, chartData);
    elseif any(ctVal == radarTypes)
        writer = mat2ppt.chart.RadarChartXmlWriter(chartType, chartData);
    elseif any(ctVal == xyTypes)
        writer = mat2ppt.chart.XyChartXmlWriter(chartType, chartData);
    elseif any(ctVal == bubbleTypes)
        writer = mat2ppt.chart.BubbleChartXmlWriter(chartType, chartData);
    else
        error("mat2ppt:notYetPorted", ...
            "XML writer for chart type %s not yet implemented", ctName);
    end
end
