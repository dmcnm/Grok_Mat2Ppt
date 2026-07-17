classdef Test_r5_chart_residual < matlab.unittest.TestCase
    %TEST_R5_CHART_RESIDUAL  Area/XY/Bubble/Radar + chart_title (R5).

    methods (Test)
        function area_and_radar_writers(tc)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            a = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.AREA_STACKED, data);
            ax = char(string(a.xml()));
            tc.verifyTrue(contains(ax, "areaChart"));
            tc.verifyTrue(contains(ax, 'grouping val="stacked"'));
            r = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.RADAR_FILLED, data);
            tc.verifyTrue(contains(char(string(r.xml())), 'radarStyle val="filled"'));
        end

        function xy_and_bubble_writers(tc)
            xy = mat2ppt.chart.XyChartData();
            xy.add_series("S1");
            xy.add_data_point(1, 0.5, 1.5);
            xy.add_data_point(1, 1.0, 2.0);
            w = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.XY_SCATTER_LINES, xy);
            wx = char(string(w.xml()));
            tc.verifyTrue(contains(wx, "scatterChart"));
            tc.verifyTrue(contains(wx, "xVal"));
            bub = mat2ppt.chart.BubbleChartData();
            bub.add_series("B");
            bub.add_data_point(1, 1, 2, 10);
            bw = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.BUBBLE, bub);
            bx = char(string(bw.xml()));
            tc.verifyTrue(contains(bx, "bubbleChart"));
            tc.verifyTrue(contains(bx, "bubbleSize"));
        end

        function add_chart_area_and_title(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("S", [3, 4]);
            gf = s.shapes().add_chart(mat2ppt.enum.XL_CHART_TYPE.AREA, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(3), data);
            ch = gf.chart();
            tc.verifyEqual(ch.chart_type().value, mat2ppt.enum.XL_CHART_TYPE.AREA.value);
            tc.verifyFalse(ch.has_title());
            ch.chart_title();
            tc.verifyTrue(ch.has_title());
            ch.set_chart_style(10);
            tc.verifyEqual(ch.chart_style(), 10);
        end
    end
end
