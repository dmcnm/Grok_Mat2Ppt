classdef GraphicFrame < mat2ppt.shapes.BaseShape
%GRAPHICFRAME  Graphic container (table/chart) p:graphicFrame.
%
%   Ported from python-pptx shapes.graphfrm.GraphicFrame (P7-W1 table path)

    methods
        function obj = GraphicFrame(sp, parent)
            obj@mat2ppt.shapes.BaseShape(sp, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.TABLE;  % default for table frames
            if obj.has_table()
                t = mat2ppt.enum.MSO_SHAPE_TYPE.TABLE;
            end
        end

        function tf = has_table(obj)
            tf = ~isempty(obj.find_tbl_());
        end

        function tbl = table(obj)
            %TABLE  |Table| enclosed in this graphic frame.
            tElm = obj.find_tbl_();
            if isempty(tElm)
                error("mat2ppt:ValueError", "GraphicFrame does not contain a table");
            end
            tbl = mat2ppt.table.Table(tElm, obj);
        end
    end

    methods (Access = private)
        function t = find_tbl_(obj)
            t = [];
            r = mat2ppt.oxml.evaluate_xpath(obj.sp_, ".//a:tbl");
            if ~isempty(r)
                t = r{1};
            end
        end
    end
end
