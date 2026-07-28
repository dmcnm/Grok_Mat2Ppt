classdef Font < handle
%FONT  Character formatting on a:rPr (python-pptx text.Font).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::Font (P6-W5 live)

    properties (Access = private)
        rPr_ = []  % optional XmlElement a:rPr
        % bag mode when no rPr (unit tests)
        bagBold_ = []
        bagItalic_ = []
        bagName_ = []
        bagSize_ = []
        bagUnderline_ = []
        bagLang_ = []
    end

    properties (Dependent)
        bold
        italic
        name
        size
        underline
        language_id
    end

    methods
        function obj = Font(rPr)
            if nargin >= 1 && ~mat2ppt.isAbsent(rPr)
                obj.rPr_ = rPr;
            end
        end

        function e = element(obj)
            e = obj.rPr_;
        end

        function v = get.bold(obj)
            if isempty(obj.rPr_)
                v = obj.bagBold_;
                return
            end
            v = mat2ppt.text.Font.read_onoff_(obj.rPr_, "b");
        end
        function set.bold(obj, value)
            if isempty(obj.rPr_)
                obj.bagBold_ = value;
                return
            end
            mat2ppt.text.Font.write_onoff_(obj.rPr_, "b", value);
        end

        function v = get.italic(obj)
            if isempty(obj.rPr_)
                v = obj.bagItalic_;
                return
            end
            v = mat2ppt.text.Font.read_onoff_(obj.rPr_, "i");
        end
        function set.italic(obj, value)
            if isempty(obj.rPr_)
                obj.bagItalic_ = value;
                return
            end
            mat2ppt.text.Font.write_onoff_(obj.rPr_, "i", value);
        end

        function v = get.name(obj)
            if isempty(obj.rPr_)
                v = obj.bagName_;
                return
            end
            latin = obj.rPr_.find("a:latin");
            if isempty(latin)
                kids = obj.rPr_.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "latin")
                        latin = kids{i}; break
                    end
                end
            end
            if isempty(latin)
                v = [];
                return
            end
            raw = latin.get("typeface");
            if mat2ppt.isAbsent(raw)
                v = [];
            else
                v = string(raw);
            end
        end
        function set.name(obj, value)
            if isempty(obj.rPr_)
                obj.bagName_ = value;
                return
            end
            if mat2ppt.isAbsent(value) || strlength(string(value)) == 0
                kids = obj.rPr_.getchildren();
                for i = numel(kids):-1:1
                    if strcmp(char(kids{i}.localName()), "latin")
                        obj.rPr_.remove(kids{i});
                    end
                end
                return
            end
            latin = obj.rPr_.find("a:latin");
            if isempty(latin)
                kids = obj.rPr_.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "latin")
                        latin = kids{i}; break
                    end
                end
            end
            if isempty(latin)
                latin = mat2ppt.oxml.OxmlElement("a:latin");
                % OOXML: latin follows fill/effect elements on rPr
                idx = mat2ppt.text.Font.latin_insert_index_(obj.rPr_);
                obj.rPr_.insert(idx, latin);
            end
            latin.set("typeface", char(string(value)));
        end

        function v = get.size(obj)
            if isempty(obj.rPr_)
                v = obj.bagSize_;
                return
            end
            raw = obj.rPr_.get("sz");
            if mat2ppt.isAbsent(raw)
                v = [];
                return
            end
            % sz is hundredths of a point
            cp = str2double(raw);
            v = mat2ppt.util.Centipoints(cp);
        end
        function set.size(obj, value)
            if isempty(obj.rPr_)
                obj.bagSize_ = value;
                return
            end
            if mat2ppt.isAbsent(value)
                obj.rPr_.removeAttr("sz");
                return
            end
            if isa(value, "mat2ppt.util.Length")
                cp = round(value.centipoints);
            else
                cp = round(double(value));
            end
            obj.rPr_.set("sz", char(string(cp)));
        end

        function v = get.underline(obj)
            if isempty(obj.rPr_)
                v = obj.bagUnderline_;
            else
                v = [];  % shell
            end
        end
        function set.underline(obj, value)
            if isempty(obj.rPr_)
                obj.bagUnderline_ = value;
            end
        end

        function v = get.language_id(obj)
            if isempty(obj.rPr_)
                v = obj.bagLang_;
            else
                v = [];
            end
        end
        function set.language_id(obj, value)
            if isempty(obj.rPr_)
                obj.bagLang_ = value;
            end
        end

        function f = fill(obj)
            %FILL  FillFormat on rPr (font color path).
            if isempty(obj.rPr_)
                f = mat2ppt.dml.FillFormat();
            else
                f = mat2ppt.dml.FillFormat.from_fill_parent(obj.rPr_);
            end
        end

        function c = color(obj)
            %COLOR  ColorFormat via solid font fill (python Font.color).
            f = obj.fill();
            t = f.type();
            needSolid = true;
            if ~isempty(t)
                try
                    needSolid = t.value ~= mat2ppt.enum.MSO_FILL.SOLID.value;
                catch
                    needSolid = true;
                end
            end
            if needSolid
                f.solid();
            end
            c = f.fore_color();
        end
    end

    methods (Static, Access = private)
        function v = read_onoff_(rPr, attr)
            raw = rPr.get(attr);
            if mat2ppt.isAbsent(raw)
                v = [];
                return
            end
            s = lower(char(string(raw)));
            if any(strcmp(s, {'1', 'true', 'on'}))
                v = true;
            elseif any(strcmp(s, {'0', 'false', 'off'}))
                v = false;
            else
                v = [];
            end
        end

        function write_onoff_(rPr, attr, value)
            if mat2ppt.isAbsent(value)
                rPr.removeAttr(attr);
            elseif value
                rPr.set(attr, "1");
            else
                rPr.set(attr, "0");
            end
        end

        function idx = latin_insert_index_(rPr)
            %LATIN_INSERT_INDEX_  Place latin after fills/effects, before ea/cs.
            afterLatin = ["ea", "cs", "sym", "hlinkClick", "hlinkMouseOver", "rtl", "extLst"];
            kids = rPr.getchildren();
            for i = 1:numel(kids)
                ln = string(kids{i}.localName());
                if any(ln == afterLatin)
                    idx = i;
                    return
                end
            end
            idx = numel(kids) + 1;
        end
    end
end
