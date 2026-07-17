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
