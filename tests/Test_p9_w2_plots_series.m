classdef Test_p9_w2_plots_series < matlab.unittest.TestCase
    % P9-W2: Plots / SeriesCollection / CategorySeries (1-based)

    methods (Test)
        function multiSeriesCollections(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West", "North"});
            data.add_series("Sales", [10, 20, 30]);
            data.add_series("Cost", [1, 2, 3]);
            gf = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(4), data);
            ch = gf.chart();
            ps = ch.plots();
            testCase.verifyEqual(ps.length(), 1);
            plot = ps.item(1);
            testCase.verifyEqual(string(plot.plot_type()), "barChart");
            testCase.verifyEqual(string(plot.barDir()), "col");
            testCase.verifyEqual(string(plot.grouping()), "clustered");
            cats = plot.categories();
            testCase.verifyEqual(numel(cats), 3);
            testCase.verifyEqual(string(cats{1}), "East");

            sc = ch.series();
            testCase.verifyEqual(sc.length(), 2);
            testCase.verifyEqual(string(sc.item(1).name()), "Sales");
            testCase.verifyEqual(string(sc.item(2).name()), "Cost");
            testCase.verifyEqual(sc.item(1).index(), 0);  % XML 0-based
            vals = sc.item(1).values();
            testCase.verifyEqual(vals(1), 10, "AbsTol", 1e-9);
            testCase.verifyEqual(vals(3), 30, "AbsTol", 1e-9);
            testCase.verifyEqual(string(sc.item(2).values_ref()), "Sheet1!$C$2:$C$4");
            testCase.verifyError(@() sc.item(0), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() ps.item(2), "mat2ppt:IndexOutOfRange");
        end

        function dataLabelsToggle(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("S", [1, 2]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.LINE);
            cs = mat2ppt.oxml.parse_xml(xml);
            ch = mat2ppt.chart.Chart(cs);
            plot = ch.plots().item(1);
            testCase.verifyFalse(plot.has_data_labels());
            plot.set_has_data_labels(true);
            testCase.verifyTrue(plot.has_data_labels());
            plot.set_has_data_labels(false);
            testCase.verifyFalse(plot.has_data_labels());
        end
    end
end
