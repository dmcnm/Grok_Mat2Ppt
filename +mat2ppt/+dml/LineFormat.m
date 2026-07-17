classdef LineFormat < handle
%LINEFORMAT  Line properties (color, fill, width, dash).
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/line.py::LineFormat (R2-W4 live)

    properties (Access = private)
        parent_   % shape providing get_or_add_ln / ln, or []
        fill_     % cached FillFormat when parent-less shell
        width_ = []
        dashStyle_ = []
    end

    properties (Dependent)
        width
        dash_style
    end

    methods
        function obj = LineFormat(parent)
            if nargin >= 1
                obj.parent_ = parent;
            end
            if isempty(obj.parent_)
                obj.fill_ = mat2ppt.dml.FillFormat();
            end
        end

        function f = fill(obj)
            %FILL  |FillFormat| on a:ln (creates ln when needed).
            if ~isempty(obj.parent_)
                ln = obj.get_or_add_ln_();
                f = mat2ppt.dml.FillFormat.from_fill_parent(ln);
            else
                if isempty(obj.fill_)
                    obj.fill_ = mat2ppt.dml.FillFormat();
                end
                f = obj.fill_;
            end
        end

        function c = color(obj)
            %COLOR  ColorFormat shortcut; forces solid fill (python LineFormat.color).
            f = obj.fill();
            t = f.type();
            if isempty(t) || t.value ~= mat2ppt.enum.MSO_FILL.SOLID.value
                f.solid();
            end
            c = f.fore_color();
        end

        function w = get.width(obj)
            if ~isempty(obj.parent_)
                ln = obj.ln_();
                if isempty(ln)
                    w = mat2ppt.util.Emu(0);
                    return
                end
                raw = ln.get("w");
                if mat2ppt.isAbsent(raw)
                    w = mat2ppt.util.Emu(0);
                else
                    w = mat2ppt.util.Emu(str2double(string(raw)));
                end
            else
                w = obj.width_;
                if isempty(w), w = mat2ppt.util.Emu(0); end
            end
        end

        function set.width(obj, w)
            if mat2ppt.isAbsent(w)
                w = 0;
            end
            e = mat2ppt.util.Length.toEmuInt_(w);
            if ~isempty(obj.parent_)
                ln = obj.get_or_add_ln_();
                ln.set("w", char(string(e)));
            else
                obj.width_ = mat2ppt.util.Emu(e);
            end
        end

        function d = get.dash_style(obj)
            d = obj.dashStyle_;
            if ~isempty(obj.parent_)
                ln = obj.ln_();
                if isempty(ln), return; end
                prst = ln.find("a:prstDash");
                if isempty(prst)
                    kids = ln.getchildren();
                    for i = 1:numel(kids)
                        if strcmp(char(kids{i}.localName()), "prstDash")
                            prst = kids{i}; break
                        end
                    end
                end
                if ~isempty(prst)
                    raw = prst.get("val");
                    if ~mat2ppt.isAbsent(raw)
                        d = string(raw);
                    end
                end
            end
        end

        function set.dash_style(obj, d)
            obj.dashStyle_ = d;
            if isempty(obj.parent_), return; end
            ln = obj.get_or_add_ln_();
            % remove existing prstDash / custDash
            kids = ln.getchildren();
            for i = numel(kids):-1:1
                lnName = char(kids{i}.localName());
                if any(strcmp(lnName, {"prstDash", "custDash"}))
                    ln.remove(kids{i});
                end
            end
            if mat2ppt.isAbsent(d), return; end
            prst = mat2ppt.oxml.OxmlElement("a:prstDash");
            if isa(d, "mat2ppt.enum.BaseXmlEnum")
                prst.set("val", char(d.xml_value));
            else
                prst.set("val", char(string(d)));
            end
            ln.append(prst);
        end
    end

    methods (Access = private)
        function ln = ln_(obj)
            ln = [];
            if isempty(obj.parent_), return; end
            if ismethod(obj.parent_, "ln")
                ln = obj.parent_.ln();
                return
            end
            % Shape: spPr/a:ln
            if isprop(obj.parent_, "sp_") || ismethod(obj.parent_, "element")
                try
                    sp = obj.parent_.element();
                catch
                    return
                end
                spPr = mat2ppt.oxml.shapes.ensure_spPr(sp);
                ln = spPr.find("a:ln");
                if isempty(ln)
                    kids = spPr.getchildren();
                    for i = 1:numel(kids)
                        if strcmp(char(kids{i}.localName()), "ln")
                            ln = kids{i}; return
                        end
                    end
                end
            end
        end

        function ln = get_or_add_ln_(obj)
            if ismethod(obj.parent_, "get_or_add_ln")
                ln = obj.parent_.get_or_add_ln();
                return
            end
            sp = obj.parent_.element();
            spPr = mat2ppt.oxml.shapes.ensure_spPr(sp);
            ln = spPr.find("a:ln");
            if isempty(ln)
                kids = spPr.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "ln")
                        ln = kids{i}; return
                    end
                end
            end
            if isempty(ln)
                ln = mat2ppt.oxml.OxmlElement("a:ln");
                spPr.append(ln);
            end
        end
    end
end
