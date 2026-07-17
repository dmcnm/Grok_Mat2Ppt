classdef GraphicFrame < mat2ppt.shapes.BaseShape
%GRAPHICFRAME  Graphic container (table/chart) p:graphicFrame.
%
%   Ported from python-pptx shapes.graphfrm.GraphicFrame (P7-W1 table path)

    methods
        function obj = GraphicFrame(sp, parent)
            obj@mat2ppt.shapes.BaseShape(sp, parent);
        end

        function t = shape_type(obj)
            if obj.has_chart()
                t = mat2ppt.enum.MSO_SHAPE_TYPE.CHART;
            elseif obj.has_table()
                t = mat2ppt.enum.MSO_SHAPE_TYPE.TABLE;
            elseif obj.has_ole_object()
                t = mat2ppt.enum.MSO_SHAPE_TYPE.EMBEDDED_OLE_OBJECT;
            else
                t = mat2ppt.enum.MSO_SHAPE_TYPE.TABLE;
            end
        end

        function tf = has_table(obj)
            tf = ~isempty(obj.find_tbl_());
        end

        function tf = has_chart(obj)
            tf = ~isempty(obj.find_chart_rId_());
        end

        function tf = has_ole_object(obj)
            r = mat2ppt.oxml.evaluate_xpath(obj.sp_, ".//p:oleObj");
            tf = ~isempty(r);
        end

        function of = ole_format(obj)
            %OLE_FORMAT  |OleFormat| for embedded OLE frames (R7-W4).
            if ~obj.has_ole_object()
                error("mat2ppt:ValueError", "not an OLE-object shape");
            end
            of = mat2ppt.shapes.OleFormat(obj.sp_, obj.parent_);
        end

        function tbl = table(obj)
            %TABLE  |Table| enclosed in this graphic frame.
            tElm = obj.find_tbl_();
            if isempty(tElm)
                error("mat2ppt:ValueError", "GraphicFrame does not contain a table");
            end
            tbl = mat2ppt.table.Table(tElm, obj);
        end

        function ch = chart(obj)
            %CHART  |Chart| for chart graphic frames (P9-W1).
            if ~obj.has_chart()
                error("mat2ppt:ValueError", "GraphicFrame does not contain a chart");
            end
            rId = obj.find_chart_rId_();
            [pkg, slidePn] = mat2ppt.shapes.SlideShapes.pkg_slide_(obj.parent_);
            chartPn = mat2ppt.opc.related_partname(pkg, slidePn, rId);
            if isempty(chartPn)
                error("mat2ppt:ValueError", "chart relationship %s not found", rId);
            end
            elm = pkg.xml_part_element(chartPn);
            if isempty(elm)
                error("mat2ppt:ValueError", "chart part %s missing", chartPn);
            end
            partInfo = struct("package", pkg, "partname", chartPn);
            ch = mat2ppt.chart.Chart(elm, partInfo);
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

        function rId = find_chart_rId_(obj)
            rId = [];
            r = mat2ppt.oxml.evaluate_xpath(obj.sp_, ".//c:chart");
            if isempty(r)
                return
            end
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            got = r{1}.get(sprintf("{%s}id", R));
            if mat2ppt.isAbsent(got)
                got = r{1}.get("r:id");
            end
            if mat2ppt.isAbsent(got)
                got = r{1}.get("id");
            end
            if ~mat2ppt.isAbsent(got)
                rId = char(string(got));
            end
        end
    end
end
