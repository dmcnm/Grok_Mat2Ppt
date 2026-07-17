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

        function phs = placeholders(obj)
            %PLACEHOLDERS  Placeholder shapes only (1-based Collection).
            phs = mat2ppt.slide.placeholders_from_shapes_(obj);
        end

        function sh = title(obj)
            %TITLE  Title placeholder (ph idx=0) or [].
            phs = obj.placeholders();
            for i = 1:phs.length
                sh = phs.item(i);
                r = mat2ppt.oxml.evaluate_xpath(sh.shape_element(), ".//p:ph");
                if isempty(r), continue; end
                raw = r{1}.get("idx");
                if mat2ppt.isAbsent(raw) || strcmp(char(string(raw)), "0")
                    return
                end
            end
            % also match type title / ctrTitle
            for i = 1:phs.length
                sh = phs.item(i);
                try
                    t = mat2ppt.shapes.PlaceholderMixin.placeholder_type(sh.shape_element());
                    if any(strcmp(t, {"title", "ctrTitle"}))
                        return
                    end
                catch
                end
            end
            sh = [];
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

        function sh = add_picture(obj, imagePath, left, top, width, height)
            %ADD_PICTURE  Embed image file as p:pic (python SlideShapes.add_picture).
            %   width/height optional (omit or [] for native size / aspect preserve).
            arguments
                obj
                imagePath
                left
                top
                width = []
                height = []
            end
            imagePath = char(string(imagePath));
            [nativeCx, nativeCy, ext, contentType] = mat2ppt.util.image_size_emu(imagePath);
            % scale
            if mat2ppt.isAbsent(width) && mat2ppt.isAbsent(height)
                cx = nativeCx;
                cy = nativeCy;
            elseif ~mat2ppt.isAbsent(width) && mat2ppt.isAbsent(height)
                cx = mat2ppt.util.Length.toEmuInt_(width);
                cy = int64(round(double(nativeCy) * double(cx) / double(nativeCx)));
            elseif mat2ppt.isAbsent(width) && ~mat2ppt.isAbsent(height)
                cy = mat2ppt.util.Length.toEmuInt_(height);
                cx = int64(round(double(nativeCx) * double(cy) / double(nativeCy)));
            else
                cx = mat2ppt.util.Length.toEmuInt_(width);
                cy = mat2ppt.util.Length.toEmuInt_(height);
            end

            % package: next media part + slide relationship
            [pkg, slidePn] = mat2ppt.shapes.SlideShapes.pkg_slide_(obj.parent_);
            mediaPn = mat2ppt.shapes.SlideShapes.next_media_partname_(pkg, ext);
            fid = fopen(imagePath, "rb");
            if fid < 0
                error("mat2ppt:IOError", "Cannot open image %s", imagePath);
            end
            cleaner = onCleanup(@() fclose(fid));
            blob = fread(fid, inf, "*uint8");
            pkg.add_blob_part(mediaPn, blob, contentType);
            rId = pkg.add_relationship(slidePn, mat2ppt.opc.RELATIONSHIP_TYPE.IMAGE, mediaPn);

            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("Picture %d", sid - 1);
            [~, fname, fext] = fileparts(imagePath);
            desc = [fname, fext];
            pic = mat2ppt.shapes.Picture.new_pic_elm(sid, name, left, top, ...
                mat2ppt.util.Emu(cx), mat2ppt.util.Emu(cy), rId, desc);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, pic);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function sh = add_table(obj, rows, cols, left, top, width, height)
            %ADD_TABLE  Graphic frame with rows x cols table (1-based cell API).
            %   Returns |GraphicFrame|; use .table() for |Table|.
            arguments
                obj
                rows (1,1) double
                cols (1,1) double
                left
                top
                width
                height
            end
            if rows < 1 || cols < 1 || rows ~= floor(rows) || cols ~= floor(cols)
                error("mat2ppt:ValueError", "rows and cols must be positive integers");
            end
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("Table %d", sid - 1);
            gf = mat2ppt.oxml.shapes.new_table_graphicFrame( ...
                sid, name, rows, cols, left, top, width, height);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, gf);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function b = build_freeform(obj, startX, startY, scale)
            %BUILD_FREEFORM  |FreeformBuilder| (python SlideShapes.build_freeform).
            arguments
                obj
                startX = 0
                startY = 0
                scale = 1.0
            end
            if isnumeric(scale) && numel(scale) == 2
                xScale = double(scale(1));
                yScale = double(scale(2));
            else
                xScale = double(scale);
                yScale = xScale;
            end
            b = mat2ppt.shapes.FreeformBuilder(obj, startX, startY, xScale, yScale);
        end

        function id = next_shape_id_public_(obj)
            %NEXT_SHAPE_ID_PUBLIC_  Allocate next shape id (for FreeformBuilder).
            id = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
        end

        function rebuild_items_public_(obj)
            obj.rebuild_items_();
        end

        function sh = add_group_shape(obj, shapes)
            %ADD_GROUP_SHAPE  Empty group or reparent given shapes (R3-W2).
            arguments
                obj
                shapes = {}
            end
            if ~iscell(shapes)
                if isempty(shapes)
                    shapes = {};
                else
                    shapes = {shapes};
                end
            end
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("Group %d", sid - 1);
            grpSp = mat2ppt.oxml.shapes.new_grpSp(sid, name);
            for i = 1:numel(shapes)
                el = shapes{i}.shape_element();
                % detach from current parent if any
                try
                    par = el.getparent();
                    if ~isempty(par)
                        par.remove(el);
                    end
                catch
                end
                grpSp.append(el);
            end
            if ~isempty(shapes)
                mat2ppt.shapes.SlideShapes.recalc_group_extents_(grpSp);
            end
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, grpSp);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function sh = add_connector(obj, connectorType, beginX, beginY, endX, endY)
            %ADD_CONNECTOR  Append connector shape (python SlideShapes.add_connector).
            arguments
                obj
                connectorType
                beginX
                beginY
                endX
                endY
            end
            bx = double(mat2ppt.util.Length.toEmuInt_(beginX));
            by = double(mat2ppt.util.Length.toEmuInt_(beginY));
            ex = double(mat2ppt.util.Length.toEmuInt_(endX));
            ey = double(mat2ppt.util.Length.toEmuInt_(endY));
            flipH = bx > ex;
            flipV = by > ey;
            x = min(bx, ex);
            y = min(by, ey);
            cx = abs(ex - bx);
            cy = abs(ey - by);
            prst = mat2ppt.enum.MSO_CONNECTOR.to_xml(connectorType);
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("Connector %d", sid - 1);
            cxnSp = mat2ppt.oxml.shapes.new_cxnSp(sid, name, prst, x, y, cx, cy, flipH, flipV);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, cxnSp);
            obj.rebuild_items_();
            sh = obj.item(obj.length);
        end

        function sh = add_chart(obj, chartType, left, top, width, height, chartData)
            %ADD_CHART  Embed category chart graphicFrame + ChartPart (P8-W6).
            %   chartData is CategoryChartData/ChartData. Returns GraphicFrame.
            arguments
                obj
                chartType
                left
                top
                width
                height
                chartData mat2ppt.chart.CategoryChartData
            end
            [pkg, slidePn] = mat2ppt.shapes.SlideShapes.pkg_slide_(obj.parent_);
            [~, rId] = mat2ppt.parts.ChartPart.new_in_package(pkg, slidePn, chartType, chartData);
            sid = obj.nextId_;
            obj.nextId_ = obj.nextId_ + 1;
            name = sprintf("Chart %d", sid - 1);
            gf = mat2ppt.oxml.shapes.new_chart_graphicFrame( ...
                sid, name, rId, left, top, width, height);
            mat2ppt.oxml.shapes.spTree_add_sp(obj.spTree_, gf);
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
                added = false;
                switch ln
                    case "sp"
                        items{end+1} = mat2ppt.shapes.Shape(kids{i}, obj.parent_); %#ok<AGROW>
                        added = true;
                    case "pic"
                        items{end+1} = mat2ppt.shapes.Picture(kids{i}, obj.parent_); %#ok<AGROW>
                        added = true;
                    case "cxnSp"
                        items{end+1} = mat2ppt.shapes.Connector(kids{i}, obj.parent_); %#ok<AGROW>
                        added = true;
                    case "grpSp"
                        items{end+1} = mat2ppt.shapes.GroupShape(kids{i}, obj.parent_); %#ok<AGROW>
                        added = true;
                    case "graphicFrame"
                        items{end+1} = mat2ppt.shapes.GraphicFrame(kids{i}, obj.parent_); %#ok<AGROW>
                        added = true;
                    otherwise
                        % nvGrpSpPr etc. skip
                end
                if added
                    idv = items{end}.shape_id();
                    if ~isempty(idv) && idv > maxId
                        maxId = idv;
                    end
                end
            end
            obj.items_ = items;
            obj.nextId_ = maxId + 1;
        end
    end

    methods (Static)
        function [pkg, slidePn] = pkg_slide_(parent)
            %PKG_SLIDE_  Resolve package + slide partname from shape parent chain.
            %   Public for GraphicFrame.chart (P9-W1) and media adders.
            p = parent;
            for k = 1:12
                if ismethod(p, "part")
                    pr = p.part();
                    if isstruct(pr) && isfield(pr, "package") && isfield(pr, "partname")
                        pkg = pr.package;
                        slidePn = pr.partname;
                        return
                    end
                end
                if ismethod(p, "parent")
                    p = p.parent();
                elseif ismethod(p, "presentation")
                    % Slide
                    prs = p.presentation();
                    pkg = prs.package();
                    if ismethod(p, "partname")
                        slidePn = p.partname();
                        return
                    end
                else
                    break
                end
            end
            error("mat2ppt:AttributeError", "Cannot resolve package/slide for picture");
        end

        function pn = next_media_partname_(pkg, ext)
            names = pkg.list_partnames();
            maxN = 0;
            for i = 1:numel(names)
                tok = regexp(char(names(i)), "^/ppt/media/image(\d+)\.", "tokens", "once");
                if ~isempty(tok)
                    maxN = max(maxN, str2double(tok{1}));
                end
            end
            pn = sprintf("/ppt/media/image%d.%s", maxN + 1, char(string(ext)));
        end

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

        function recalc_group_extents_(grpSp)
            %RECALC_GROUP_EXTENTS_  Set grp xfrm from member bounding box.
            kids = grpSp.getchildren();
            minX = inf; minY = inf; maxX = -inf; maxY = -inf;
            anyShape = false;
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                if ~any(strcmp(ln, {"sp","pic","cxnSp","grpSp","graphicFrame"}))
                    continue
                end
                r = mat2ppt.oxml.evaluate_xpath(kids{i}, ".//a:off");
                e = mat2ppt.oxml.evaluate_xpath(kids{i}, ".//a:ext");
                if isempty(r) || isempty(e), continue; end
                off = r{1}; ext = e{1};
                x = str2double(string(off.get("x")));
                y = str2double(string(off.get("y")));
                cx = str2double(string(ext.get("cx")));
                cy = str2double(string(ext.get("cy")));
                if any(isnan([x y cx cy])), continue; end
                anyShape = true;
                minX = min(minX, x); minY = min(minY, y);
                maxX = max(maxX, x + cx); maxY = max(maxY, y + cy);
            end
            if ~anyShape, return; end
            w = max(0, maxX - minX);
            h = max(0, maxY - minY);
            % find a:xfrm under grpSpPr
            gpr = grpSp.find("p:grpSpPr");
            if isempty(gpr)
                kids2 = grpSp.getchildren();
                for i = 1:numel(kids2)
                    if strcmp(char(kids2{i}.localName()), "grpSpPr")
                        gpr = kids2{i}; break
                    end
                end
            end
            if isempty(gpr), return; end
            xfrm = gpr.find("a:xfrm");
            if isempty(xfrm)
                kids2 = gpr.getchildren();
                for i = 1:numel(kids2)
                    if strcmp(char(kids2{i}.localName()), "xfrm")
                        xfrm = kids2{i}; break
                    end
                end
            end
            if isempty(xfrm), return; end
            function set_child(parent, tagLocal, attrs)
                el = [];
                ck = parent.getchildren();
                for ii = 1:numel(ck)
                    if strcmp(char(ck{ii}.localName()), tagLocal)
                        el = ck{ii}; break
                    end
                end
                if isempty(el)
                    el = mat2ppt.oxml.OxmlElement("a:" + string(tagLocal));
                    parent.append(el);
                end
                keys = fieldnames(attrs);
                for ii = 1:numel(keys)
                    el.set(keys{ii}, char(string(attrs.(keys{ii}))));
                end
            end
            set_child(xfrm, "off", struct("x", round(minX), "y", round(minY)));
            set_child(xfrm, "ext", struct("cx", round(w), "cy", round(h)));
            set_child(xfrm, "chOff", struct("x", round(minX), "y", round(minY)));
            set_child(xfrm, "chExt", struct("cx", round(w), "cy", round(h)));
        end
    end
end
