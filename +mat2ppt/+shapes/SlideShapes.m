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
            baseName = mat2ppt.shapes.SlideShapes.basename_for_prst_(prst);
            name = sprintf("%s %d", baseName, sid - 1);
            sp = mat2ppt.oxml.shapes.new_sp(sid, name, left, top, width, height, prst);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, sp);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function sh = add_textbox(obj, left, top, width, height)
            %ADD_TEXTBOX  Free-floating text box (python SlideShapes.add_textbox).
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("TextBox %d", sid - 1);
            sp = mat2ppt.oxml.shapes.new_textbox_sp(sid, name, left, top, width, height);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, sp);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end
    end

    methods (Access = private)
        function rebuild_items_(obj)
            kids = obj.spTree_.getchildren();
            items = {};
            maxId = 1;
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
                if any(strcmp(ln, {'sp', 'pic', 'cxnSp', 'grpSp', 'graphicFrame'}))
                    idv = items{end}.shape_id();  % reliable; shape_id_ uses char cells
                    if ~isempty(idv) && idv > maxId
                        maxId = idv;
                    end
                end
            end
            obj.items_ = items;
            obj.nextId_ = maxId + 1;
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

        function name = basename_for_prst_(prst)
            prst = char(string(prst));
            switch prst
                case "rect", name = "Rectangle";
                case "ellipse", name = "Oval";
                case "roundRect", name = "Rounded Rectangle";
                case "rightArrow", name = "Right Arrow";
                otherwise
                    name = prst;
            end
        end
    end
end
