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

    methods (Static, Access = private)
        function [pkg, slidePn] = pkg_slide_(parent)
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
    end
end
