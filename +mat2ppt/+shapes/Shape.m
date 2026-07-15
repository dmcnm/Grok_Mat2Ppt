classdef Shape < mat2ppt.shapes.BaseShape
%SHAPE  Auto shape (p:sp).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/autoshape.py::Shape

    methods
        function obj = Shape(sp, parent)
            obj@mat2ppt.shapes.BaseShape(sp, parent);
        end

        function tf = has_text_frame(obj)
            tf = true;
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.AUTO_SHAPE;
        end

        function fill = fill(obj)
            %FILL  FillFormat shell on spPr (P5-W11 will deepen ColorFormat).
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            fill = mat2ppt.dml.FillFormat.from_fill_parent(spPr);
        end

        function ln = line(obj)
            ln = mat2ppt.dml.LineFormat(obj);
        end

        function tf = text_frame(obj)
            %TEXT_FRAME  |TextFrame| for this shape (p:txBody).
            tf = mat2ppt.text.TextFrame.from_shape_element(obj.sp_, obj);
        end
    end
end

