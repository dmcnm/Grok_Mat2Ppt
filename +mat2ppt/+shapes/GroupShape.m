classdef GroupShape < mat2ppt.shapes.BaseShape
%GROUPSHAPE  Group shape (p:grpSp).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/group.py (R3-W2)

    properties (Access = private)
        shapes_ = []
    end

    methods
        function obj = GroupShape(grpSp, parent)
            obj@mat2ppt.shapes.BaseShape(grpSp, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.GROUP;
        end

        function tf = has_text_frame(obj)
            tf = false;
        end

        function sh = shapes(obj)
            if isempty(obj.shapes_)
                obj.shapes_ = mat2ppt.shapes.GroupShapes(obj.sp_, obj);
            else
                obj.shapes_.rebuild_();
            end
            sh = obj.shapes_;
        end

        function shd = shadow(obj)
            grpSpPr = obj.find_grpSpPr_();
            if isempty(grpSpPr)
                error("mat2ppt:InvalidXmlError", "grpSp missing grpSpPr");
            end
            shd = mat2ppt.dml.ShadowFormat(grpSpPr);
        end

        function act = click_action(obj) %#ok<MANU>
            %CLICK_ACTION  Groups cannot have click actions (python TypeError).
            error("mat2ppt:TypeError", "a group shape cannot have a click action");
        end
    end

    methods (Access = private)
        function g = find_grpSpPr_(obj)
            g = obj.sp_.find("p:grpSpPr");
            if ~isempty(g), return; end
            kids = obj.sp_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "grpSpPr")
                    g = kids{i}; return
                end
            end
            g = [];
        end
    end
end
