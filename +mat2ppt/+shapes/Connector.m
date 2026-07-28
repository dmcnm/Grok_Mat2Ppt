classdef Connector < mat2ppt.shapes.BaseShape
%CONNECTOR  Connector shape (p:cxnSp).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/connector.py (R3-W1)

    properties (Dependent)
        begin_x
        begin_y
        end_x
        end_y
    end

    methods
        function obj = Connector(cxnSp, parent)
            obj@mat2ppt.shapes.BaseShape(cxnSp, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.LINE;
        end

        function ln = line(obj)
            ln = mat2ppt.dml.LineFormat(obj);
        end

        function el = ln(obj)
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
            el = obj.ln();
            if ~isempty(el), return; end
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            el = mat2ppt.oxml.OxmlElement("a:ln");
            spPr.append(el);
        end

        function begin_connect(obj, shape, cxnPtIdx)
            %BEGIN_CONNECT  Wire begin to shape connection site (python Connector.begin_connect).
            %   cxnPtIdx is 0-based on the connected shape (python convention):
            %   0=top, 1=left, 2=bottom, 3=right for rectangular boxes.
            arguments
                obj
                shape
                cxnPtIdx (1,1) double
            end
            obj.connect_end_("stCxn", shape, cxnPtIdx);
            obj.move_end_to_cxn_("begin", shape, cxnPtIdx);
        end

        function end_connect(obj, shape, cxnPtIdx)
            %END_CONNECT  Wire end to shape connection site (python Connector.end_connect).
            arguments
                obj
                shape
                cxnPtIdx (1,1) double
            end
            obj.connect_end_("endCxn", shape, cxnPtIdx);
            obj.move_end_to_cxn_("end", shape, cxnPtIdx);
        end

        function set_tail_end(obj, typeName)
            %SET_TAIL_END  a:tailEnd type on a:ln ("triangle","none",... or [] to clear).
            obj.set_line_end_("tailEnd", typeName);
        end

        function set_head_end(obj, typeName)
            %SET_HEAD_END  a:headEnd type on a:ln ("triangle","none",... or [] to clear).
            obj.set_line_end_("headEnd", typeName);
        end

        function v = get.begin_x(obj)
            [x, cx, flipH] = obj.xfrm_xy_();
            if flipH
                v = mat2ppt.util.Emu(x + cx);
            else
                v = mat2ppt.util.Emu(x);
            end
        end

        function v = get.begin_y(obj)
            [y, cy, flipV] = obj.xfrm_xy_vert_();
            if flipV
                v = mat2ppt.util.Emu(y + cy);
            else
                v = mat2ppt.util.Emu(y);
            end
        end

        function v = get.end_x(obj)
            [x, cx, flipH] = obj.xfrm_xy_();
            if flipH
                v = mat2ppt.util.Emu(x);
            else
                v = mat2ppt.util.Emu(x + cx);
            end
        end

        function v = get.end_y(obj)
            [y, cy, flipV] = obj.xfrm_xy_vert_();
            if flipV
                v = mat2ppt.util.Emu(y);
            else
                v = mat2ppt.util.Emu(y + cy);
            end
        end
    end

    methods (Access = private)
        function connect_end_(obj, tag, shape, cxnPtIdx)
            % Write a:stCxn or a:endCxn under p:cNvCxnSpPr.
            cNv = obj.find_cNvCxnSpPr_();
            if isempty(cNv)
                error("mat2ppt:InvalidXmlError", "Connector missing cNvCxnSpPr");
            end
            kids = cNv.getchildren();
            for i = numel(kids):-1:1
                if strcmp(char(kids{i}.localName()), tag)
                    cNv.remove(kids{i});
                end
            end
            el = mat2ppt.oxml.OxmlElement("a:" + string(tag));
            sid = shape.shape_id();
            if mat2ppt.isAbsent(sid)
                error("mat2ppt:ValueError", "Connected shape has no shape_id");
            end
            el.set("id", char(string(round(double(sid)))));
            el.set("idx", char(string(round(double(cxnPtIdx)))));
            cNv.append(el);
        end

        function cNv = find_cNvCxnSpPr_(obj)
            cNv = [];
            kids = obj.sp_.getchildren();
            for i = 1:numel(kids)
                if ~strcmp(char(kids{i}.localName()), "nvCxnSpPr")
                    continue
                end
                nv = kids{i};
                for j = 1:nv.childCount()
                    ch = nv.child(j);
                    if strcmp(char(ch.localName()), "cNvCxnSpPr")
                        cNv = ch;
                        return
                    end
                end
            end
        end

        function move_end_to_cxn_(obj, which, shape, cxnPtIdx)
            % Move begin or end endpoint to rectangular connection site.
            x = double(mat2ppt.util.Length.toEmuInt_(shape.left));
            y = double(mat2ppt.util.Length.toEmuInt_(shape.top));
            cx = double(mat2ppt.util.Length.toEmuInt_(shape.width));
            cy = double(mat2ppt.util.Length.toEmuInt_(shape.height));
            pts = {
                [x + cx/2, y]           % 0 top
                [x, y + cy/2]           % 1 left
                [x + cx/2, y + cy]      % 2 bottom
                [x + cx, y + cy/2]      % 3 right
                };
            idx = round(double(cxnPtIdx)) + 1;  % 0-based → 1-based
            if idx < 1 || idx > numel(pts)
                error("mat2ppt:ValueError", "cxnPtIdx must be 0..3 for rect connect");
            end
            pt = pts{idx};
            bx = double(mat2ppt.util.Length.toEmuInt_(obj.begin_x));
            by = double(mat2ppt.util.Length.toEmuInt_(obj.begin_y));
            ex = double(mat2ppt.util.Length.toEmuInt_(obj.end_x));
            ey = double(mat2ppt.util.Length.toEmuInt_(obj.end_y));
            if strcmp(which, "begin")
                bx = pt(1); by = pt(2);
            else
                ex = pt(1); ey = pt(2);
            end
            obj.rewrite_xfrm_from_ends_(bx, by, ex, ey);
        end

        function rewrite_xfrm_from_ends_(obj, bx, by, ex, ey)
            flipH = bx > ex;
            flipV = by > ey;
            x = min(bx, ex);
            y = min(by, ey);
            cx = abs(ex - bx);
            cy = abs(ey - by);
            xfrm = obj.find_xfrm_();
            if isempty(xfrm)
                return
            end
            if flipH, xfrm.set("flipH", "1"); else, try xfrm.removeAttr("flipH"); catch, end; end
            if flipV, xfrm.set("flipV", "1"); else, try xfrm.removeAttr("flipV"); catch, end; end
            off = xfrm.find("a:off");
            if isempty(off)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "off"), off = kids{i}; break; end
                end
            end
            ext = xfrm.find("a:ext");
            if isempty(ext)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "ext"), ext = kids{i}; break; end
                end
            end
            if ~isempty(off)
                off.set("x", char(string(round(x))));
                off.set("y", char(string(round(y))));
            end
            if ~isempty(ext)
                ext.set("cx", char(string(round(cx))));
                ext.set("cy", char(string(round(cy))));
            end
        end

        function set_line_end_(obj, tag, typeName)
            ln = obj.get_or_add_ln();
            kids = ln.getchildren();
            for i = numel(kids):-1:1
                if strcmp(char(kids{i}.localName()), tag)
                    ln.remove(kids{i});
                end
            end
            if mat2ppt.isAbsent(typeName)
                return
            end
            t = char(string(typeName));
            if strcmpi(t, "none") || strlength(string(t)) == 0
                return
            end
            el = mat2ppt.oxml.OxmlElement("a:" + string(tag));
            el.set("type", t);
            ln.append(el);
        end

        function [x, cx, flipH] = xfrm_xy_(obj)
            xfrm = obj.find_xfrm_();
            x = 0; cx = 0; flipH = false;
            if isempty(xfrm), return; end
            flipH = strcmp(char(string(xfrm.get("flipH"))), "1");
            off = xfrm.find("a:off");
            if isempty(off)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "off"), off = kids{i}; break; end
                end
            end
            ext = xfrm.find("a:ext");
            if isempty(ext)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "ext"), ext = kids{i}; break; end
                end
            end
            if ~isempty(off)
                raw = off.get("x");
                if ~mat2ppt.isAbsent(raw), x = str2double(string(raw)); end
            end
            if ~isempty(ext)
                raw = ext.get("cx");
                if ~mat2ppt.isAbsent(raw), cx = str2double(string(raw)); end
            end
        end

        function [y, cy, flipV] = xfrm_xy_vert_(obj)
            xfrm = obj.find_xfrm_();
            y = 0; cy = 0; flipV = false;
            if isempty(xfrm), return; end
            flipV = strcmp(char(string(xfrm.get("flipV"))), "1");
            off = xfrm.find("a:off");
            if isempty(off)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "off"), off = kids{i}; break; end
                end
            end
            ext = xfrm.find("a:ext");
            if isempty(ext)
                kids = xfrm.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "ext"), ext = kids{i}; break; end
                end
            end
            if ~isempty(off)
                raw = off.get("y");
                if ~mat2ppt.isAbsent(raw), y = str2double(string(raw)); end
            end
            if ~isempty(ext)
                raw = ext.get("cy");
                if ~mat2ppt.isAbsent(raw), cy = str2double(string(raw)); end
            end
        end
    end
end
