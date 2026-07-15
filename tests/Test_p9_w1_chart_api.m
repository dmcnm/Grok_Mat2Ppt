classdef Test_p9_w1_chart_api < matlab.unittest.TestCase
    % P9-W1: Chart shell + GraphicFrame.has_chart/chart

    methods (Test)
        function chartFromAddChart(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            gf = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(4), data);
            testCase.verifyTrue(gf.has_chart());
            testCase.verifyFalse(gf.has_table());
            testCase.verifyEqual(gf.shape_type().value, ...
                mat2ppt.enum.MSO_SHAPE_TYPE.CHART.value);

            ch = gf.chart();
            testCase.verifyTrue(isa(ch, "mat2ppt.chart.Chart"));
            testCase.verifyEqual(ch.series_count(), 1);
            testCase.verifyEqual(string(ch.series_name(1)), "Sales");
            testCase.verifyEqual(ch.chart_type().value, ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED.value);
            testCase.verifyTrue(ch.has_category_axis());
            testCase.verifyTrue(ch.has_value_axis());
            testCase.verifyFalse(ch.has_legend());  % column template has no legend
            testCase.verifyError(@() ch.series_name(0), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() ch.series_name(2), "mat2ppt:IndexOutOfRange");
        end

        function lineChartHasLegend(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.ChartData();
            data.set_categories({"A", "B"});
            data.add_series("L1", [1, 2]);
            gf = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.LINE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(3), data);
            ch = gf.chart();
            testCase.verifyTrue(ch.has_legend());
            testCase.verifyEqual(ch.chart_type().value, ...
                mat2ppt.enum.XL_CHART_TYPE.LINE.value);
        end
    end
end
