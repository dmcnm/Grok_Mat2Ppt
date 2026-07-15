classdef Test_p8_w8_axis_legend < matlab.unittest.TestCase
    % P8-W8: axis / dLbls / legend helpers

    methods (Test)
        function axesOnColumnChart(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("S", [1, 2]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED);
            cs = mat2ppt.oxml.parse_xml(xml);
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(cs);
            axes = mat2ppt.oxml.chart.CT_Axis.list_axes(pa);
            testCase.verifyEqual(numel(axes), 2);
            catAx = mat2ppt.oxml.chart.CT_Axis.find_catAx(pa);
            valAx = mat2ppt.oxml.chart.CT_Axis.find_valAx(pa);
            testCase.verifyFalse(isempty(catAx));
            testCase.verifyFalse(isempty(valAx));
            testCase.verifyEqual(mat2ppt.oxml.chart.CT_Axis.axId_val(catAx), -2068027336);
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Axis.axPos_val(catAx)), "b");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Axis.axPos_val(valAx)), "l");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Axis.orientation_val(catAx)), "minMax");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Axis.crosses_val(valAx)), "autoZero");
        end

        function legendOnLineChart(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"X", "Y"});
            data.add_series("L", [3, 4]);
            xml = data.xml_string(mat2ppt.enum.XL_CHART_TYPE.LINE);
            cs = mat2ppt.oxml.parse_xml(xml);
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(cs);
            leg = mat2ppt.oxml.chart.CT_Legend.find_legend(ch);
            testCase.verifyFalse(isempty(leg));
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Legend.legendPos_val(leg)), "r");
            leg2 = mat2ppt.oxml.chart.CT_Legend.new_legend("b");
            testCase.verifyEqual(string(mat2ppt.oxml.chart.CT_Legend.legendPos_val(leg2)), "b");
        end

        function dLblsFactory(testCase)
            d = mat2ppt.oxml.chart.CT_DLbls.new_dLbls();
            testCase.verifyEqual(string(d.localName()), "dLbls");
            testCase.verifyFalse(mat2ppt.oxml.chart.CT_DLbls.show_flag(d, "showVal"));
            testCase.verifyTrue(mat2ppt.oxml.chart.CT_DLbls.show_flag(d, "showLeaderLines"));
        end
    end
end
