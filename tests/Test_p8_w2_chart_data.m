classdef Test_p8_w2_chart_data < matlab.unittest.TestCase
    % P8-W2: CategoryChartData model (1-based series)

    methods (Test)
        function categoriesAndSeries(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"A", "B"});
            testCase.verifyEqual(data.category_count(), 2);
            data.add_series("S1", [1.0, 2.0]);
            testCase.verifyEqual(data.series_count(), 1);
            s = data.series(1);
            testCase.verifyEqual(string(s.name), "S1");
            testCase.verifyEqual(s.values, [1.0, 2.0]);
            testCase.verifyEqual(string(data.categories_ref()), "Sheet1!$A$2:$A$3");
            testCase.verifyEqual(string(data.values_ref(1)), "Sheet1!$B$2:$B$3");
            testCase.verifyEqual(string(data.series_name_ref(1)), "Sheet1!$B$1");
            T = data.as_table();
            testCase.verifyEqual(size(T), [3, 2]);
            testCase.verifyEqual(string(T{2, 1}), "A");
            testCase.verifyEqual(T{3, 2}, 2.0);
        end

        function multiSeriesRefs(testCase)
            data = mat2ppt.chart.ChartData();
            data.set_categories(["East", "West", "North"]);
            data.add_series("Q1", [10, 20, 30]);
            data.add_series("Q2", [11, 21, 31]);
            testCase.verifyEqual(data.series_count(), 2);
            testCase.verifyEqual(string(data.values_ref(2)), "Sheet1!$C$2:$C$4");
            testCase.verifyEqual(string(data.series_name_ref(2)), "Sheet1!$C$1");
            testCase.verifyError(@() data.series(0), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() data.series(3), "mat2ppt:IndexOutOfRange");
        end

        function emptyCategoriesRefErrors(testCase)
            data = mat2ppt.chart.CategoryChartData();
            testCase.verifyError(@() data.categories_ref(), "mat2ppt:ValueError");
        end
    end
end
