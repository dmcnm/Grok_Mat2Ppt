classdef Test_p8_w1_chart_space < matlab.unittest.TestCase
    % P8-W1: chartSpace foundations (parse + minimal factory)

    methods (Test)
        function parseOracleChartSpace(testCase)
            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p8_w1_chart_space\oracle.pptx';
            testCase.assumeTrue(isfile(oracle));
            blobs = mat2ppt.opc.read_zip_blobs(oracle);
            testCase.verifyTrue(isKey(blobs, "ppt/charts/chart1.xml"));
            cs = mat2ppt.oxml.chart.CT_ChartSpace.from_xml_bytes(blobs("ppt/charts/chart1.xml"));
            testCase.verifyEqual(string(cs.localName()), "chartSpace");
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(cs);
            testCase.verifyFalse(isempty(ch));
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(cs);
            testCase.verifyFalse(isempty(pa));
            nBar = mat2ppt.oxml.chart.CT_ChartSpace.count_local(pa, "barChart");
            testCase.verifyEqual(nBar, 1);
            vals = mat2ppt.oxml.chart.CT_ChartSpace.collect_v_texts(cs);
            % categories A,B and series S1 and values 1.0, 2.0
            testCase.verifyTrue(any(vals == "A"));
            testCase.verifyTrue(any(vals == "B"));
            testCase.verifyTrue(any(vals == "S1"));
            testCase.verifyTrue(any(vals == "1.0") || any(vals == "1"));
            testCase.verifyTrue(any(vals == "2.0") || any(vals == "2"));
            % embedding present
            testCase.verifyTrue(isKey(blobs, "ppt/embeddings/Microsoft_Excel_Sheet1.xlsx"));
        end

        function newMinimalChartSpace(testCase)
            cs = mat2ppt.oxml.chart.CT_ChartSpace.new_minimal();
            testCase.verifyEqual(string(cs.localName()), "chartSpace");
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(cs);
            testCase.verifyFalse(isempty(pa));
            part = mat2ppt.parts.ChartPart.from_chartspace( ...
                "/ppt/charts/chart1.xml", [], cs);
            testCase.verifyEqual(string(part.chartSpace().localName()), "chartSpace");
            testCase.verifyFalse(isempty(part.plotArea()));
        end

        function chartGraphicFrameShell(testCase)
            gf = mat2ppt.oxml.shapes.new_chart_graphicFrame(2, "Chart 1", "rId2", ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(3));
            testCase.verifyEqual(string(gf.localName()), "graphicFrame");
            r = mat2ppt.oxml.evaluate_xpath(gf, ".//a:graphicData");
            testCase.verifyFalse(isempty(r));
            uri = string(r{1}.get("uri"));
            testCase.verifyEqual(uri, string(mat2ppt.oxml.chart.CT_ChartSpace.graphic_data_uri()));
        end
    end
end
