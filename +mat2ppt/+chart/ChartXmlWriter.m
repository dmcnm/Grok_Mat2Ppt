function writer = ChartXmlWriter(chartType, chartData)
%CHARTXMLWRITER  Factory returning a chart XML builder for chartType (P8-W4).
%
%   w = mat2ppt.chart.ChartXmlWriter(XL_CHART_TYPE.COLUMN_CLUSTERED, data)
%   xml = w.xml()   % full c:chartSpace document string
%
%   Slice A (this WP): bar/column family + line family with series caches.
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

    if any(ctVal == barCol)
        writer = mat2ppt.chart.BarChartXmlWriter(chartType, chartData);
    elseif any(ctVal == lineTypes)
        writer = mat2ppt.chart.LineChartXmlWriter(chartType, chartData);
    else
        error("mat2ppt:notYetPorted", ...
            "XML writer for chart type %s not yet implemented (P8-W4/W5)", ctName);
    end
end
