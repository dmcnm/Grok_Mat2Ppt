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
            %FILL  FillFormat on spPr.
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            fill = mat2ppt.dml.FillFormat.from_fill_parent(spPr);
        end

        function ln = line(obj)
            ln = mat2ppt.dml.LineFormat(obj);
        end

        function sh = shadow(obj)
            %SHADOW  |ShadowFormat| on spPr (inherit only; upstream thin API).
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            sh = mat2ppt.dml.ShadowFormat(spPr);
        end

        function el = ln(obj)
            %LN  Existing a:ln under spPr, or [].
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            el = spPr.find("a:ln");
            if ~isempty(el), return; end
            kids = spPr.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "ln")
                    el = kids{i}; return
                end
            end
            el = [];
        end

        function el = get_or_add_ln(obj)
            %GET_OR_ADD_LN  a:ln under spPr (python shape get_or_add_ln).
            el = obj.ln();
            if ~isempty(el), return; end
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            el = mat2ppt.oxml.OxmlElement("a:ln");
            spPr.append(el);
        end

        function tf = text_frame(obj)
            %TEXT_FRAME  |TextFrame| for this shape (p:txBody).
            tf = mat2ppt.text.TextFrame.from_shape_element(obj.sp_, obj);
        end
    end
end

