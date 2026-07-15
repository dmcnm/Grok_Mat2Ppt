classdef Test_p9_w4_replace_data < matlab.unittest.TestCase
    % P9-W4: Chart.replace_data rewrites series + xlsx

    methods (Test)
        function replaceDataUpdatesCachesAndXlsx(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            slide = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            data.add_series("Old", [1, 2]);
            gf = slide.shapes.add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(4), data);
            ch = gf.chart();
            testCase.verifyEqual(string(ch.series_name(1)), "Old");

            data2 = mat2ppt.chart.CategoryChartData();
            data2.set_categories({"East", "West", "North"});
            data2.add_series("NewSales", [10, 20, 30]);
            data2.add_series("NewCost", [1, 2, 3]);
            ch.replace_data(data2);

            testCase.verifyEqual(ch.series_count(), 2);
            testCase.verifyEqual(string(ch.series_name(1)), "NewSales");
            testCase.verifyEqual(string(ch.series_name(2)), "NewCost");
            vals = ch.series().item(1).values();
            testCase.verifyEqual(vals(3), 30, "AbsTol", 1e-9);
            cats = ch.plots().item(1).categories();
            testCase.verifyEqual(string(cats{1}), "East");

            tmp = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_p9_w4_replace_data.delete_quiet_(tmp));
            prs.save(tmp);
            blobs = mat2ppt.opc.read_zip_blobs(tmp);
            chartXml = native2unicode(blobs("ppt/charts/chart1.xml"), "UTF-8");
            testCase.verifyTrue(contains(string(chartXml), "NewSales"));
            testCase.verifyTrue(contains(string(chartXml), "North"));
            % xlsx present
            keys = string(blobs.keys);
            testCase.verifyTrue(any(contains(keys, "Microsoft_Excel_Sheet")));
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
