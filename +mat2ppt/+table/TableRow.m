classdef TableRow < handle
%TABLEROW  One table row (a:tr).
%
%   Ported from python-pptx table._Row (R2-W3)

    properties (Access = private)
        tr_
        parent_  % Table
    end

    methods
        function obj = TableRow(trElm, parent)
            obj.tr_ = trElm;
            obj.parent_ = parent;
        end

        function e = element(obj)
            e = obj.tr_;
        end

        function h = height(obj)
            raw = obj.tr_.get("h");
            if mat2ppt.isAbsent(raw)
                h = mat2ppt.util.Emu(0);
            else
                h = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function set_height(obj, value)
            e = mat2ppt.util.Length.toEmuInt_(value);
            obj.tr_.set("h", char(string(e)));
        end

        function cells = cells(obj)
            %CELLS  1-based collection of TableCell in this row.
            items = {};
            kids = obj.tr_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tc")
                    items{end+1} = mat2ppt.table.TableCell(kids{i}, obj.parent_); %#ok<AGROW>
                end
            end
            cells = mat2ppt.shared.Collection();
            cells.set_items_(items);
        end
    end
end
