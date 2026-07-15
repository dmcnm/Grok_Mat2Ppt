classdef Test_p8_w7_plot_series < matlab.unittest.TestCase
    % P8-W7: CT_Plot / CT_Series helpers on generated column chart XML

    methods (Test)
        function plotSeriesFromGeneratedXml(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            data.add_series("Cost", [0.5, 0.8]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED);
            cs = mat2ppt.oxml.parse_xml(xml);
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(cs);
            plot = mat2ppt.oxml.chart.CT_Plot.first_plot(pa);
            testCase.verifyFalse(isempty(plot));
            testCase.verifyEqual(string(plot.localName()), "barChart");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Plot.barDir_val(plot)), "col");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Plot.grouping_val(plot)), "clustered");
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Plot.series_count(plot), 2);

            sers = mat2ppt.oxml.chart.CT_Plot.series_elements(plot);
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Series.idx_val(sers{1}), 0);
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Series.order_val(sers{2}), 1);
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Series.series_name(sers{1})), "Sales");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Series.series_name(sers{2})), "Cost");
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Series.cat_ptCount_val(sers{1}), 2);
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Series.val_ptCount_val(sers{1}), 2);
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Series.cat_formula(sers{1})), "Sheet1!$A$2:$A$3");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Series.val_formula(sers{2})), "Sheet1!$C$2:$C$3");

            cats = mat2ppt.oxml.chart.CT_Series.cat_point_labels(sers{1});
            testCase.verifyEqual(string(cats{1}), "East");
            testCase.verifyEqual(string(cats{2}), "West");
            vals = mat2ppt.oxml.chart.CT_Series.val_point_values(sers{1});
            testCase.verifyEqual(vals(1), 1.2, "AbsTol", 1e-9);
            testCase.verifyEqual(vals(2), 2.3, "AbsTol", 1e-9);

            dPt = mat2ppt.oxml.chart.CT_Series.new_dPt(3);
            testCase.verifyEqual(string(dPt.localName()), "dPt");
        end

        function piePlotType(testCase)
            data = mat2ppt.chart.ChartData();
            data.set_categories({"A", "B"});
            data.add_series("S", [40, 60]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.PIE);
            cs = mat2ppt.oxml.parse_xml(xml);
            plot = mat2ppt.oxml.chart.CT_Plot.first_plot( ...
                mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(cs));
            testCase.verifyEqual(string(plot.localName()), "pieChart");
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Plot.series_count(plot), 1);
        end
    end
end
