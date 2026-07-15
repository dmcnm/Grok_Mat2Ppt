classdef Test_p8_w6_add_chart < matlab.unittest.TestCase
    % P8-W6: add_chart package wiring + structural L0/L1 probes (D-xlsx)

    methods (Test)
        function addColumnChartParts(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            sh = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(4), data);
            testCase.verifyTrue(isa(sh, "mat2ppt.shapes.GraphicFrame"));

            tmp = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_p8_w6_add_chart.delete_quiet_(tmp));
            prs.save(tmp);

            blobs = mat2ppt.opc.read_zip_blobs(tmp);
            keys = string(blobs.keys);
            testCase.verifyTrue(any(keys == "ppt/charts/chart1.xml"));
            testCase.verifyTrue(any(contains(keys, "ppt/embeddings/Microsoft_Excel_Sheet")));
            chartXml = native2unicode(blobs("ppt/charts/chart1.xml"), "UTF-8");
            testCase.verifyTrue(contains(string(chartXml), "barChart") || ...
                contains(string(chartXml), "c:barChart"));
            testCase.verifyTrue(contains(string(chartXml), "Sales"));
            testCase.verifyTrue(contains(string(chartXml), "externalData") || ...
                contains(string(chartXml), "c:externalData"));
            testCase.verifyTrue(contains(string(chartXml), "Sheet1!$B$2:$B$3"));

            % chart rels point at xlsx package
            relKey = "ppt/charts/_rels/chart1.xml.rels";
            testCase.verifyTrue(any(keys == relKey));
            relXml = native2unicode(blobs(relKey), "UTF-8");
            testCase.verifyTrue(contains(string(relXml), "package") || ...
                contains(string(relXml), "Microsoft_Excel_Sheet"));
        end
    end

    methods (Static, Access = private)
        function delete_quiet_(path)
            if isfile(path)
                try
                    delete(path);
                catch
                end
            end
        end
    end
end
