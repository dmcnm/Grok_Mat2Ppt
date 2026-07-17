classdef Table < handle
%TABLE  Table inside a graphic frame (a:tbl).
%
%   Ported from python-pptx 1.0.2: src/pptx/table.py::Table (P7-W1 subset)
%   Public indexing is **1-based** (Mat2Ppt policy).

    properties (Access = private)
        tbl_
        parent_  % GraphicFrame
    end

    methods
        function obj = Table(tblElm, parent)
            arguments
                tblElm (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj.tbl_ = tblElm;
            obj.parent_ = parent;
        end

        function e = element(obj)
            e = obj.tbl_;
        end

        function n = row_count(obj)
            n = 0;
            kids = obj.tbl_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tr")
                    n = n + 1;
                end
            end
        end

        function n = column_count(obj)
            grid = obj.tblGrid_();
            n = 0;
            if isempty(grid), return; end
            kids = grid.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "gridCol")
                    n = n + 1;
                end
            end
        end

        function c = cell(obj, rowIdx, colIdx)
            %CELL  1-based row and column indices.
            arguments
                obj
                rowIdx (1,1) double
                colIdx (1,1) double
            end
            nr = obj.row_count();
            nc = obj.column_count();
            if rowIdx < 1 || rowIdx > nr || colIdx < 1 || colIdx > nc || ...
                    rowIdx ~= floor(rowIdx) || colIdx ~= floor(colIdx)
                error("mat2ppt:IndexOutOfRange", ...
                    "cell(%g,%g) out of range. Valid rows 1..%d cols 1..%d (1-based).", ...
                    rowIdx, colIdx, nr, nc);
            end
            tr = obj.tr_at_(rowIdx);
            tc = obj.tc_at_(tr, colIdx);
            c = mat2ppt.table.TableCell(tc, obj);
        end

        function coll = rows(obj)
            %ROWS  1-based collection of |TableRow|.
            items = {};
            kids = obj.tbl_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tr")
                    items{end+1} = mat2ppt.table.TableRow(kids{i}, obj); %#ok<AGROW>
                end
            end
            coll = mat2ppt.shared.Collection();
            coll.set_items_(items);
        end

        function coll = columns(obj)
            %COLUMNS  1-based collection of |TableColumn|.
            items = {};
            grid = obj.tblGrid_();
            if ~isempty(grid)
                kids = grid.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "gridCol")
                        items{end+1} = mat2ppt.table.TableColumn(kids{i}, obj); %#ok<AGROW>
                    end
                end
            end
            coll = mat2ppt.shared.Collection();
            coll.set_items_(items);
        end

        function cells = iter_cells(obj)
            %ITER_CELLS  Cell array of all cells row-major (1-based order).
            cells = {};
            nr = obj.row_count();
            nc = obj.column_count();
            for r = 1:nr
                for c = 1:nc
                    cells{end+1} = obj.cell(r, c); %#ok<AGROW>
                end
            end
        end

        function tf = first_row(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "firstRow");
        end
        function set_first_row(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "firstRow", value);
        end

        function tf = first_col(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "firstCol");
        end
        function set_first_col(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "firstCol", value);
        end

        function tf = last_row(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "lastRow");
        end
        function set_last_row(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "lastRow", value);
        end

        function tf = last_col(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "lastCol");
        end
        function set_last_col(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "lastCol", value);
        end

        function tf = horz_banding(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "bandRow");
        end
        function set_horz_banding(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "bandRow", value);
        end

        function tf = vert_banding(obj)
            tf = mat2ppt.table.Table.read_tbl_bool(obj.tbl_, "bandCol");
        end
        function set_vert_banding(obj, value)
            mat2ppt.table.Table.write_tbl_bool(obj.tbl_, "bandCol", value);
        end
    end

    methods (Static)
        function tf = read_tbl_bool(tblElm, attr)
            tblPr = mat2ppt.table.Table.find_tblPr(tblElm);
            if isempty(tblPr)
                tf = false;
                return
            end
            raw = tblPr.get(attr);
            if mat2ppt.isAbsent(raw)
                tf = false;
            else
                s = lower(strtrim(char(string(raw))));
                tf = strcmp(s, "1") || strcmp(s, "true");
            end
        end

        function write_tbl_bool(tblElm, attr, value)
            tblPr = mat2ppt.table.Table.ensure_tblPr(tblElm);
            if value
                tblPr.set(attr, "1");
            else
                tblPr.removeAttr(attr);
            end
        end

        function tblPr = find_tblPr(tblElm)
            tblPr = tblElm.find("a:tblPr");
            if ~isempty(tblPr), return; end
            kids = tblElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tblPr")
                    tblPr = kids{i};
                    return
                end
            end
            tblPr = [];
        end

        function tblPr = ensure_tblPr(tblElm)
            tblPr = mat2ppt.table.Table.find_tblPr(tblElm);
            if ~isempty(tblPr), return; end
            tblPr = mat2ppt.oxml.OxmlElement("a:tblPr");
            kids = tblElm.getchildren();
            for i = 1:numel(kids)
                tblElm.remove(kids{i});
            end
            tblElm.append(tblPr);
            for i = 1:numel(kids)
                tblElm.append(kids{i});
            end
        end
    end

    methods (Access = private)
        function grid = tblGrid_(obj)
            grid = obj.tbl_.find("a:tblGrid");
            if ~isempty(grid), return; end
            kids = obj.tbl_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tblGrid")
                    grid = kids{i}; return
                end
            end
            grid = [];
        end

        function tr = tr_at_(obj, rowIdx)
            n = 0;
            kids = obj.tbl_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tr")
                    n = n + 1;
                    if n == rowIdx
                        tr = kids{i};
                        return
                    end
                end
            end
            error("mat2ppt:IndexOutOfRange", "row %d not found", rowIdx);
        end

        function tc = tc_at_(obj, tr, colIdx)
            n = 0;
            kids = tr.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tc")
                    n = n + 1;
                    if n == colIdx
                        tc = kids{i};
                        return
                    end
                end
            end
            error("mat2ppt:IndexOutOfRange", "col %d not found", colIdx);
        end
    end
end
