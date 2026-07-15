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
