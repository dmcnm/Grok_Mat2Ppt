classdef FreeformBuilder < handle
%FREEFORMBUILDER  Build freeform path then convert_to_shape (R3-W3).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/freeform.py

    properties (Access = private)
        shapes_   % SlideShapes
        startX_   % local coords (int)
        startY_
        xScale_
        yScale_
        ops_ = {}  % cell of structs: op move|line|close, x, y
    end

    methods
        function obj = FreeformBuilder(shapes, startX, startY, xScale, yScale)
            obj.shapes_ = shapes;
            obj.startX_ = round(double(startX));
            obj.startY_ = round(double(startY));
            if nargin < 4 || mat2ppt.isAbsent(xScale), xScale = 1.0; end
            if nargin < 5 || mat2ppt.isAbsent(yScale), yScale = xScale; end
            obj.xScale_ = double(xScale);
            obj.yScale_ = double(yScale);
        end

        function obj = move_to(obj, x, y)
            obj.ops_{end+1} = struct("op", "move", "x", round(double(x)), "y", round(double(y))); %#ok<AGROW>
        end

        function obj = line_to(obj, x, y)
            %LINE_TO  Alias for single-point add_line_segments without close.
            obj.ops_{end+1} = struct("op", "line", "x", round(double(x)), "y", round(double(y))); %#ok<AGROW>
        end

        function obj = add_line_segments(obj, vertices, doClose)
            %ADD_LINE_SEGMENTS  vertices as Nx2 matrix or cell of [x y].
            arguments
                obj
                vertices
                doClose (1,1) logical = true
            end
            if iscell(vertices)
                for i = 1:numel(vertices)
                    v = vertices{i};
                    obj.ops_{end+1} = struct("op", "line", "x", round(double(v(1))), "y", round(double(v(2)))); %#ok<AGROW>
                end
            else
                for i = 1:size(vertices, 1)
                    obj.ops_{end+1} = struct("op", "line", ...
                        "x", round(double(vertices(i, 1))), ...
                        "y", round(double(vertices(i, 2)))); %#ok<AGROW>
                end
            end
            if doClose
                obj.close();
            end
        end

        function obj = close(obj)
            obj.ops_{end+1} = struct("op", "close", "x", 0, "y", 0); %#ok<AGROW>
        end

        function n = operation_count(obj)
            n = numel(obj.ops_);
        end

        function sh = convert_to_shape(obj, originX, originY)
            %CONVERT_TO_SHAPE  Append freeform shape to slide shapes.
            arguments
                obj
                originX = 0
                originY = 0
            end
            ox = double(mat2ppt.util.Length.toEmuInt_(originX));
            oy = double(mat2ppt.util.Length.toEmuInt_(originY));
            left = ox + obj.left_emu_();
            top = oy + obj.top_emu_();
            width = obj.width_emu_();
            height = obj.height_emu_();
            sid = obj.shapes_.next_shape_id_public_();
            name = sprintf("Freeform %d", sid - 1);
            sp = mat2ppt.oxml.shapes.new_freeform_sp(sid, name, left, top, width, height);
            path = obj.start_path_(sp);
            % start move already on path; apply ops
            for i = 1:numel(obj.ops_)
                op = obj.ops_{i};
                switch op.op
                    case "move"
                        [sx, sy] = obj.local_to_shape_(op.x, op.y);
                        mat2ppt.shapes.FreeformBuilder.path_moveTo_(path, sx, sy);
                    case "line"
                        [sx, sy] = obj.local_to_shape_(op.x, op.y);
                        mat2ppt.shapes.FreeformBuilder.path_lnTo_(path, sx, sy);
                    case "close"
                        path.append(mat2ppt.oxml.OxmlElement("a:close"));
                end
            end
            mat2ppt.oxml.shapes.spTree_add_sp(obj.shapes_.spTree(), sp);
            obj.shapes_.rebuild_items_public_();
            sh = obj.shapes_.item(obj.shapes_.length);
        end
    end

    methods (Access = private)
        function [minX, maxX, minY, maxY] = bounds_(obj)
            minX = obj.startX_; maxX = obj.startX_;
            minY = obj.startY_; maxY = obj.startY_;
            for i = 1:numel(obj.ops_)
                op = obj.ops_{i};
                if strcmp(op.op, "close"), continue; end
                minX = min(minX, op.x); maxX = max(maxX, op.x);
                minY = min(minY, op.y); maxY = max(maxY, op.y);
            end
        end

        function v = left_emu_(obj)
            [minX, ~, ~, ~] = obj.bounds_();
            v = int64(round(minX * obj.xScale_));
        end
        function v = top_emu_(obj)
            [~, ~, minY, ~] = obj.bounds_();
            v = int64(round(minY * obj.yScale_));
        end
        function v = width_emu_(obj)
            [minX, maxX, ~, ~] = obj.bounds_();
            v = int64(round((maxX - minX) * obj.xScale_));
        end
        function v = height_emu_(obj)
            [~, ~, minY, maxY] = obj.bounds_();
            v = int64(round((maxY - minY) * obj.yScale_));
        end

        function [sx, sy] = local_to_shape_(obj, lx, ly)
            [minX, ~, minY, ~] = obj.bounds_();
            sx = int64(round(lx - minX));
            sy = int64(round(ly - minY));
        end

        function path = start_path_(obj, sp)
            [minX, maxX, minY, maxY] = obj.bounds_();
            dx = max(0, maxX - minX);
            dy = max(0, maxY - minY);
            pathLst = mat2ppt.shapes.FreeformBuilder.find_pathLst_(sp);
            path = mat2ppt.oxml.OxmlElement("a:path");
            path.set("w", char(string(dx)));
            path.set("h", char(string(dy)));
            pathLst.append(path);
            [sx, sy] = obj.local_to_shape_(obj.startX_, obj.startY_);
            mat2ppt.shapes.FreeformBuilder.path_moveTo_(path, sx, sy);
        end
    end

    methods (Static)
        function pathLst = find_pathLst_(sp)
            r = mat2ppt.oxml.evaluate_xpath(sp, ".//a:pathLst");
            if isempty(r)
                error("mat2ppt:InvalidXmlError", "freeform missing pathLst");
            end
            pathLst = r{1};
        end

        function path_moveTo_(path, x, y)
            moveTo = mat2ppt.oxml.OxmlElement("a:moveTo");
            pt = mat2ppt.oxml.OxmlElement("a:pt");
            pt.set("x", char(string(x)));
            pt.set("y", char(string(y)));
            moveTo.append(pt);
            path.append(moveTo);
        end

        function path_lnTo_(path, x, y)
            lnTo = mat2ppt.oxml.OxmlElement("a:lnTo");
            pt = mat2ppt.oxml.OxmlElement("a:pt");
            pt.set("x", char(string(x)));
            pt.set("y", char(string(y)));
            lnTo.append(pt);
            path.append(lnTo);
        end
    end
end
