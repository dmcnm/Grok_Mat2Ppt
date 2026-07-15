classdef CategoryWorkbookWriter < handle
%CATEGORYWORKBOOKWRITER  Build embedded chart xlsx from CategoryChartData (P8-W3).
%
%   writer = mat2ppt.chart.CategoryWorkbookWriter(chartData)
%   blob = writer.xlsx_blob()   % uint8 row of .xlsx package
%
%   Layout matches python-pptx CategoryWorkbookWriter for single-level
%   categories (categories in col A from row 2; series headers row 1 from B).
%   Byte identity vs xlsxwriter is NOT required (D-xlsx ASSUMED-APPROVED).
%
%   Ported from python-pptx 1.0.2: src/pptx/chart/xlsx.py::CategoryWorkbookWriter

    properties (Access = private)
        chartData_
    end

    methods
        function obj = CategoryWorkbookWriter(chartData)
            arguments
                chartData mat2ppt.chart.CategoryChartData
            end
            obj.chartData_ = chartData;
        end

        function blob = xlsx_blob(obj)
            %XLSX_BLOB  uint8 row vector of a valid .xlsx workbook.
            data = obj.chartData_;
            if data.category_count() < 1
                error("mat2ppt:ValueError", "chart data contains no categories");
            end
            if data.series_count() < 1
                error("mat2ppt:ValueError", "chart data contains no series");
            end
            T = data.as_table();
            % writecell prefers char/numeric; normalize empty top-left
            if isempty(T{1, 1}) || (isstring(T{1, 1}) && strlength(T{1, 1}) == 0)
                T{1, 1} = '';
            end
            for i = 1:numel(T)
                v = T{i};
                if isstring(v)
                    T{i} = char(v);
                elseif iscell(v)
                    T{i} = char(string(v));
                end
            end

            tmp = [tempname() '.xlsx'];
            cleaner = onCleanup(@() mat2ppt.chart.CategoryWorkbookWriter.delete_quiet_(tmp));
            writecell(T, tmp);
            fid = fopen(tmp, "r");
            if fid < 0
                error("mat2ppt:IOError", "Cannot read temp xlsx %s", tmp);
            end
            blob = fread(fid, inf, "*uint8")';
            fclose(fid);
            if isempty(blob)
                error("mat2ppt:IOError", "xlsx_blob is empty");
            end
        end

        function ref = categories_ref(obj)
            ref = obj.chartData_.categories_ref();
        end

        function ref = series_name_ref(obj, seriesIdx)
            ref = obj.chartData_.series_name_ref(seriesIdx);
        end

        function ref = values_ref(obj, seriesIdx)
            ref = obj.chartData_.values_ref(seriesIdx);
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
