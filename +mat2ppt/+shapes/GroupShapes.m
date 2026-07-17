classdef GroupShapes < mat2ppt.shared.Collection
%GROUPSHAPES  Shapes inside a group (1-based).
%
%   Ported from python-pptx GroupShapes (R3-W2 subset)

    properties (Access = private)
        grpSp_
        parentGroup_
    end

    methods
        function obj = GroupShapes(grpSp, parentGroup)
            obj.grpSp_ = grpSp;
            obj.parentGroup_ = parentGroup;
            obj.rebuild_();
        end

        function rebuild_(obj)
            kids = obj.grpSp_.getchildren();
            items = {};
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                switch ln
                    case "sp"
                        items{end+1} = mat2ppt.shapes.Shape(kids{i}, obj.parentGroup_); %#ok<AGROW>
                    case "pic"
                        items{end+1} = mat2ppt.shapes.Picture(kids{i}, obj.parentGroup_); %#ok<AGROW>
                    case "cxnSp"
                        items{end+1} = mat2ppt.shapes.Connector(kids{i}, obj.parentGroup_); %#ok<AGROW>
                    case "grpSp"
                        items{end+1} = mat2ppt.shapes.GroupShape(kids{i}, obj.parentGroup_); %#ok<AGROW>
                    case "graphicFrame"
                        items{end+1} = mat2ppt.shapes.GraphicFrame(kids{i}, obj.parentGroup_); %#ok<AGROW>
                end
            end
            obj.items_ = items;
        end
    end
end
