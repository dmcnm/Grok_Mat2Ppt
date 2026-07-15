classdef Test_p9_w5_chart_matrix < matlab.unittest.TestCase
    % P9-W5: multi-type chart package matrix (structural L0; D-xlsx)

    methods (Test)
        function columnLinePiePackages(testCase)
            types = { ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, "barChart"; ...
                mat2ppt.enum.XL_CHART_TYPE.BAR_CLUSTERED, "barChart"; ...
                mat2ppt.enum.XL_CHART_TYPE.LINE, "lineChart"; ...
                mat2ppt.enum.XL_CHART_TYPE.PIE, "pieChart" ...
                };
            for i = 1:size(types, 1)
                prs = mat2ppt.Presentation();
                blank = prs.slide_layouts().get_by_name("Blank");
                slide = prs.slides().add_slide(blank);
                data = mat2ppt.chart.CategoryChartData();
                data.set_categories({"Q1", "Q2"});
                data.add_series("S1", [5, 7]);
                ct = types{i, 1};
                expectPlot = types{i, 2};
                gf = slide.shapes.add_chart(ct, ...
                    mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                    mat2ppt.util.Inches(6), mat2ppt.util.Inches(4), data);
                ch = gf.chart();
                testCase.verifyEqual(string(ch.plots().item(1).plot_type()), string(expectPlot));
                testCase.verifyEqual(ch.series_count(), 1);
                testCase.verifyEqual(ch.chart_type().value, ct.value);

                tmp = [tempname() '.pptx'];
                cleaner = onCleanup(@() Test_p9_w5_chart_matrix.delete_quiet_(tmp));
                prs.save(tmp);
                blobs = mat2ppt.opc.read_zip_blobs(tmp);
                keys = string(blobs.keys);
                testCase.verifyTrue(any(keys == "ppt/charts/chart1.xml"), ...
                    sprintf("missing chart for type %s", ct.name));
                testCase.verifyTrue(any(contains(keys, "Microsoft_Excel_Sheet")), ...
                    sprintf("missing xlsx for type %s", ct.name));
                xml = string(native2unicode(blobs("ppt/charts/chart1.xml"), "UTF-8"));
                testCase.verifyTrue(contains(xml, expectPlot));
                testCase.verifyTrue(contains(xml, "S1"));
                testCase.verifyTrue(contains(xml, "externalData") || contains(xml, "c:externalData"));
            end
        end
    end

    methods (Static, Access = private)
        function delete_quiet_(path)
            if isfile(path)
                try, delete(path); catch, end
            end
        end
    end
end
