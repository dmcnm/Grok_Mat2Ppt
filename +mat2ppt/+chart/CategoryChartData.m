classdef CategoryChartData < handle
%CATEGORYCHARTDATA  Categories + series values for category charts (P8-W2).
%
%   data = mat2ppt.chart.CategoryChartData()
%   data.categories = {"East", "West"};  % or data.set_categories(...)
%   data.add_series("Sales", [1.2, 2.3]);
%
%   Public series indexing is **1-based**.
%   Ported from python-pptx 1.0.2: src/pptx/chart/data.py::CategoryChartData

    properties (Access = private)
        catLabels_ cell = {}   % string labels
        seriesList_ cell = {}  % each: struct('name',...,'values',...,'number_format',...)
    end

    methods
        function obj = CategoryChartData()
        end

        function set_categories(obj, labels)
            %SET_CATEGORIES  Replace category labels (string/cell/string array).
            obj.catLabels_ = mat2ppt.chart.CategoryChartData.normalize_labels_(labels);
        end

        function labels = get_categories(obj)
            labels = obj.catLabels_;
        end

        function n = category_count(obj)
            n = numel(obj.catLabels_);
        end

        function s = add_series(obj, name, values, numberFormat)
            %ADD_SERIES  Append series with numeric values (row or column vector).
            arguments
                obj
                name
                values = []
                numberFormat = []
            end
            name = char(string(name));
            vals = double(values(:))';
            s = struct( ...
                "name", name, ...
                "values", vals, ...
                "number_format", numberFormat);
            obj.seriesList_{end+1} = s; %#ok<AGROW>
        end

        function n = series_count(obj)
            n = numel(obj.seriesList_);
        end

        function s = series(obj, idx)
            %SERIES  1-based series struct.
            n = obj.series_count();
            idx = double(idx);
            if idx < 1 || idx > n || idx ~= floor(idx)
                error("mat2ppt:IndexOutOfRange", ...
                    "series index %g out of range 1..%d", idx, n);
            end
            s = obj.seriesList_{idx};
        end

        function ref = categories_ref(obj)
            %CATEGORIES_REF  Excel range for category labels (no header).
            n = obj.category_count();
            if n < 1
                error("mat2ppt:ValueError", "chart data contains no categories");
            end
            % sprintf keeps a single char vector (H1: never mix string "" with []).
            ref = sprintf('Sheet1!$A$2:$A$%d', n + 1);
        end

        function ref = series_name_ref(obj, seriesIdx)
            %SERIES_NAME_REF  Excel cell for series name (column header).
            col = mat2ppt.chart.CategoryChartData.col_letter_(seriesIdx + 1); % B=2 for first series
            ref = sprintf('Sheet1!$%s$1', col);
        end

        function ref = values_ref(obj, seriesIdx)
            %VALUES_REF  Excel range for series values (no header).
            s = obj.series(seriesIdx);
            n = numel(s.values);
            if n < 1
                n = obj.category_count();
            end
            col = mat2ppt.chart.CategoryChartData.col_letter_(seriesIdx + 1);
            ref = sprintf('Sheet1!$%s$2:$%s$%d', col, col, n + 1);
        end

        function blob = xlsx_blob(obj)
            %XLSX_BLOB  Embedded Excel package bytes (delegates to workbook writer).
            w = mat2ppt.chart.CategoryWorkbookWriter(obj);
            blob = w.xlsx_blob();
        end

        function xml = xml_string(obj, chartType)
            %XML_STRING  Full c:chartSpace document for chartType.
            w = mat2ppt.chart.ChartXmlWriter(chartType, obj);
            xml = w.xml();
        end

        function blob = xml_bytes(obj, chartType)
            %XML_BYTES  UTF-8 uint8 of chart XML document.
            xml = obj.xml_string(chartType);
            blob = unicode2native(char(xml), "UTF-8");
            blob = uint8(blob(:)');
        end

        function T = as_table(obj)
            %AS_TABLE  Cell matrix: header row + category | series columns.
            ns = obj.series_count();
            nc = obj.category_count();
            T = cell(nc + 1, ns + 1);
            T{1, 1} = "";
            for j = 1:ns
                T{1, j + 1} = obj.seriesList_{j}.name;
            end
            for i = 1:nc
                T{i + 1, 1} = char(string(obj.catLabels_{i}));
                for j = 1:ns
                    vals = obj.seriesList_{j}.values;
                    if i <= numel(vals)
                        T{i + 1, j + 1} = vals(i);
                    else
                        T{i + 1, j + 1} = [];
                    end
                end
            end
        end
    end

    methods (Static, Access = private)
        function labels = normalize_labels_(labels)
            if isstring(labels)
                labels = cellstr(labels(:));
            elseif ischar(labels)
                labels = {labels};
            elseif isnumeric(labels)
                labels = arrayfun(@(x) char(string(x)), labels(:), "UniformOutput", false);
            elseif iscell(labels)
                labels = labels(:);
                for i = 1:numel(labels)
                    labels{i} = char(string(labels{i}));
                end
            else
                error("mat2ppt:TypeError", "Unsupported categories type");
            end
        end

        function col = col_letter_(n)
            % 1 -> A, 2 -> B, ... 27 -> AA (Excel style). Returns char row.
            n = double(n);
            if n < 1 || n > 16384
                error("mat2ppt:ValueError", "column_number must be in range 1-16384");
            end
            col = '';  % char empty — not "" (string), which breaks [ ] concat
            while n > 0
                n = n - 1;
                col = [char('A' + mod(n, 26)), col]; %#ok<AGROW>
                n = floor(n / 26);
            end
        end
    end
end
