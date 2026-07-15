classdef Test_p9_w3_axis_legend < matlab.unittest.TestCase
    % P9-W3: Axis / Legend / DataLabels public surface

    methods (Test)
        function categoryAndValueAxes(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("S", [1, 2]);
            gf = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(3), data);
            ch = gf.chart();
            catAx = ch.category_axis();
            valAx = ch.value_axis();
            testCase.verifyEqual(string(catAx.axis_kind()), "catAx");
            testCase.verifyEqual(string(valAx.axis_kind()), "valAx");
            testCase.verifyEqual(string(catAx.axPos()), "b");
            testCase.verifyEqual(string(valAx.axPos()), "l");
            testCase.verifyTrue(valAx.has_major_gridlines());
            testCase.verifyEqual(string(catAx.orientation()), "minMax");
        end

        function legendAndDataLabels(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"X", "Y"});
            data.add_series("L", [3, 4]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.LINE);
            ch = mat2ppt.chart.Chart(mat2ppt.oxml.parse_xml(xml));
            testCase.verifyTrue(ch.has_legend());
            leg = ch.legend();
            testCase.verifyEqual(string(leg.position()), "r");
            leg.set_position("b");
            testCase.verifyEqual(string(leg.position()), "b");
            ch.set_has_legend(false);
            testCase.verifyFalse(ch.has_legend());
            ch.set_has_legend(true);
            testCase.verifyTrue(ch.has_legend());

            plot = ch.plots().item(1);
            plot.set_has_data_labels(true);
            dl = plot.data_labels();
            testCase.verifyTrue(dl.show_value());
            dl.set_show_value(false);
            testCase.verifyFalse(dl.show_value());
            dl.set_show_category_name(true);
            testCase.verifyTrue(dl.show_category_name());
        end

        function pieHasNoValueAxis(testCase)
            data = mat2ppt.chart.ChartData();
            data.set_categories({"A", "B"});
            data.add_series("Share", [40, 60]);
            ch = mat2ppt.chart.Chart(mat2ppt.oxml.parse_xml( ...
                data.xml_string(mat2ppt.enum.XL_CHART_TYPE.PIE)));
            testCase.verifyError(@() ch.value_axis(), "mat2ppt:ValueError");
            testCase.verifyError(@() ch.category_axis(), "mat2ppt:ValueError");
        end
    end
end
