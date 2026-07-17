classdef TableColumn < handle
%TABLECOLUMN  One table column (a:gridCol).
%
%   Ported from python-pptx table._Column (R2-W3)

    properties (Access = private)
        gridCol_
        parent_
    end

    methods
        function obj = TableColumn(gridColElm, parent)
            obj.gridCol_ = gridColElm;
            obj.parent_ = parent;
        end

        function e = element(obj)
            e = obj.gridCol_;
        end

        function w = width(obj)
            raw = obj.gridCol_.get("w");
            if mat2ppt.isAbsent(raw)
                w = mat2ppt.util.Emu(0);
            else
                w = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function set_width(obj, value)
            e = mat2ppt.util.Length.toEmuInt_(value);
            obj.gridCol_.set("w", char(string(e)));
        end
    end
end
