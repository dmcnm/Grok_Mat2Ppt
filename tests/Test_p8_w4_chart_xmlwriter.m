classdef Test_p8_w4_chart_xmlwriter < matlab.unittest.TestCase
    % P8-W4: ChartXmlWriter bar/col/line series caches

    methods (Test)
        function columnClusteredXml(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            w = mat2ppt.chart.ChartXmlWriter( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, data);
            xml = string(char(w.xml()));
            testCase.verifyTrue(contains(xml, "c:barChart"));
            testCase.verifyTrue(contains(xml, 'barDir val="col"'));
            testCase.verifyTrue(contains(xml, 'grouping val="clustered"'));
            testCase.verifyTrue(contains(xml, "Sheet1!$B$1"));
            testCase.verifyTrue(contains(xml, "Sheet1!$A$2:$A$3"));
            testCase.verifyTrue(contains(xml, "Sheet1!$B$2:$B$3"));
            testCase.verifyTrue(contains(xml, ">Sales<"));
            testCase.verifyTrue(contains(xml, ">East<"));
            testCase.verifyTrue(contains(xml, "1.2"));
            % parseable as chartSpace
            el = mat2ppt.oxml.parse_xml(char(xml));
            tag = string(el.tag);
            testCase.verifyTrue(contains(tag, "chartSpace"));
        end

        function barClusteredXml(testCase)
            data = mat2ppt.chart.ChartData();
            data.set_categories(["A", "B"]);
            data.add_series("S1", [3, 4]);
            w = mat2ppt.chart.ChartXmlWriter( ...
                mat2ppt.enum.XL_CHART_TYPE.BAR_CLUSTERED, data);
            xml = string(char(w.xml()));
            testCase.verifyTrue(contains(xml, 'barDir val="bar"'));
            testCase.verifyTrue(contains(xml, 'axPos val="l"'));  % cat ax left for bar
        end

        function lineChartXml(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"X", "Y", "Z"});
            data.add_series("L1", [1, 2, 3]);
            data.add_series("L2", [4, 5, 6]);
            w = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.LINE, data);
            xml = string(char(w.xml()));
            testCase.verifyTrue(contains(xml, "c:lineChart"));
            testCase.verifyTrue(contains(xml, 'grouping val="standard"'));
            testCase.verifyTrue(contains(xml, 'idx val="0"'));
            testCase.verifyTrue(contains(xml, 'idx val="1"'));
            testCase.verifyTrue(contains(xml, "Sheet1!$C$2:$C$4"));
            testCase.verifyTrue(contains(xml, "c:legend"));
        end

        function pieChartXml(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("Share", [40, 60]);
            w = mat2ppt.chart.ChartXmlWriter(mat2ppt.enum.XL_CHART_TYPE.PIE, data);
            xml = string(char(w.xml()));
            testCase.verifyTrue(contains(xml, "c:pieChart"));
            testCase.verifyTrue(contains(xml, 'varyColors val="1"'));
            testCase.verifyTrue(contains(xml, ">Share<"));
            testCase.verifyTrue(contains(xml, "40"));
        end

        function unsupportedTypeErrors(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A"});
            data.add_series("S", 1);
            testCase.verifyError(@() mat2ppt.chart.ChartXmlWriter( ...
                mat2ppt.enum.XL_CHART_TYPE.XY_SCATTER, data), "mat2ppt:notYetPorted");
        end
    end
end
