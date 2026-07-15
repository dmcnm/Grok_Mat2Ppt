classdef Test_p8_w3_chart_xlsx < matlab.unittest.TestCase
    % P8-W3: CategoryWorkbookWriter / xlsx_blob (D-xlsx structural)

    methods (Test)
        function blobIsValidXlsxZip(testCase)
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            blob = data.xlsx_blob();
            testCase.verifyTrue(isa(blob, "uint8"));
            testCase.verifyGreaterThan(numel(blob), 100);
            % ZIP local file header magic
            testCase.verifyEqual(blob(1:2), uint8([80, 75])); % 'PK'

            tmp = [tempname() '.xlsx'];
            cleaner = onCleanup(@() Test_p8_w3_chart_xlsx.delete_quiet_(tmp));
            fid = fopen(tmp, "w");
            fwrite(fid, blob, "uint8");
            fclose(fid);

            C = readcell(tmp);
            testCase.verifyEqual(string(C{1, 2}), "Sales");
            testCase.verifyEqual(string(C{2, 1}), "East");
            testCase.verifyEqual(string(C{3, 1}), "West");
            testCase.verifyEqual(double(C{2, 2}), 1.2, "AbsTol", 1e-9);
            testCase.verifyEqual(double(C{3, 2}), 2.3, "AbsTol", 1e-9);
        end

        function multiSeriesRoundTrip(testCase)
            data = mat2ppt.chart.ChartData();
            data.set_categories(["Q1", "Q2", "Q3"]);
            data.add_series("A", [10, 20, 30]);
            data.add_series("B", [11, 21, 31]);
            w = mat2ppt.chart.CategoryWorkbookWriter(data);
            blob = w.xlsx_blob();
            testCase.verifyEqual(string(w.values_ref(2)), "Sheet1!$C$2:$C$4");

            tmp = [tempname() '.xlsx'];
            cleaner = onCleanup(@() Test_p8_w3_chart_xlsx.delete_quiet_(tmp));
            fid = fopen(tmp, "w");
            fwrite(fid, blob, "uint8");
            fclose(fid);
            C = readcell(tmp);
            testCase.verifyEqual(size(C, 1), 4);
            testCase.verifyEqual(size(C, 2), 3);
            testCase.verifyEqual(string(C{1, 3}), "B");
            testCase.verifyEqual(double(C{4, 3}), 31, "AbsTol", 1e-9);
        end

        function emptyDataErrors(testCase)
            data = mat2ppt.chart.CategoryChartData();
            testCase.verifyError(@() data.xlsx_blob(), "mat2ppt:ValueError");
            data.set_categories({"OnlyCat"});
            testCase.verifyError(@() data.xlsx_blob(), "mat2ppt:ValueError");
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
