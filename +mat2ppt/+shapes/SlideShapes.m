classdef SlideShapes < mat2ppt.shared.Collection
%SLIDESHAPES  Shape collection on a slide spTree (1-based).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/shapetree.py::SlideShapes (P5-W8)

    properties (Access = private)
        spTree_
        parent_
        nextId_ = 2
    end

    methods
        function obj = SlideShapes(spTree, parent)
            arguments
                spTree (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj.spTree_ = spTree;
            obj.parent_ = parent;
            obj.rebuild_items_();
        end

        function spTree = spTree(obj)
            spTree = obj.spTree_;
        end

        function sh = add_shape(obj, autoshapeType, left, top, width, height)
            %ADD_SHAPE  Append a rectangle or named prst autoshape.
            if isa(autoshapeType, "mat2ppt.enum.BaseXmlEnum") || isa(autoshapeType, "mat2ppt.enum.BaseEnum")
                % map common members to prst
                prst = mat2ppt.shapes.SlideShapes.prst_for_enum_(autoshapeType);
            else
                prst = char(string(autoshapeType));
            end
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("%s %d", prst, sid);
            sp = mat2ppt.oxml.shapes.new_sp(sid, name, left, top, width, height, prst);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, sp);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function sh = add_textbox(obj, left, top, width, height)
            sh = obj.add_shape("rect", left, top, width, height);
        end
    end

    methods (Access = private)
        function rebuild_items_(obj)
            kids = obj.spTree_.getchildren();
            items = {};
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                switch ln
                    case "sp"
                        items{end+1} = mat2ppt.shapes.Shape(kids{i}, obj.parent_); %#ok<AGROW>
                    case "pic"
                        items{end+1} = mat2ppt.shapes.Picture(kids{i}, obj.parent_); %#ok<AGROW>
                    case "cxnSp"
                        items{end+1} = mat2ppt.shapes.Connector(kids{i}, obj.parent_); %#ok<AGROW>
                    case "grpSp"
                        items{end+1} = mat2ppt.shapes.GroupShape(kids{i}, obj.parent_); %#ok<AGROW>
                    otherwise
                        % nvGrpSpPr etc. skip
                end
            end
            obj.items_ = items;
        end
    end

    methods (Static, Access = private)
        function prst = prst_for_enum_(e)
            n = char(string(e.name));
            switch upper(n)
                case "RECTANGLE", prst = "rect";
                case "OVAL", prst = "ellipse";
                case "ROUNDED_RECTANGLE", prst = "roundRect";
                case "RIGHT_ARROW", prst = "rightArrow";
                otherwise
                    prst = "rect";
            end
        end
    end
end
