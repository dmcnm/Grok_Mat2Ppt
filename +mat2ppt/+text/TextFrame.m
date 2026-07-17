classdef TextFrame < mat2ppt.shared.ParentedElementProxy
%TEXTFRAME  Shape text body (p:txBody).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::TextFrame (P6-W1 / DEF-006)

    properties (Access = private)
        txBody_
    end

    properties (Dependent)
        text
        word_wrap
        margin_left
        margin_right
        margin_top
        margin_bottom
        vertical_anchor
        auto_size
    end

    methods
        function obj = TextFrame(txBody, parent)
            arguments
                txBody (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ParentedElementProxy(txBody, parent);
            obj.txBody_ = txBody;
            obj.ensure_one_paragraph_();
        end

        function p = add_paragraph(obj)
            if ismethod(obj.txBody_, "add_p")
                pElm = obj.txBody_.add_p();
            else
                pElm = mat2ppt.oxml.text.CT_TextParagraph.new();
                obj.txBody_.append(pElm);
            end
            p = mat2ppt.text.Paragraph(pElm, obj);
        end

        function clear(obj)
            if ismethod(obj.txBody_, "clear_content")
                obj.txBody_.clear_content();
            else
                kids = obj.txBody_.getchildren();
                for i = numel(kids):-1:1
                    if strcmp(char(kids{i}.localName()), "p")
                        obj.txBody_.remove(kids{i});
                    end
                end
            end
            p = obj.add_paragraph();
            p.clear_content();
        end

        function ps = paragraphs(obj)
            if ismethod(obj.txBody_, "p_lst")
                lst = obj.txBody_.p_lst();
            else
                lst = {};
                kids = obj.txBody_.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "p")
                        lst{end+1} = kids{i}; %#ok<AGROW>
                    end
                end
            end
            if isempty(lst)
                obj.ensure_one_paragraph_();
                lst = obj.txBody_.p_lst();
            end
            ps = cell(1, numel(lst));
            for i = 1:numel(lst)
                ps{i} = mat2ppt.text.Paragraph(lst{i}, obj);
            end
        end

        function t = get.text(obj)
            ps = obj.paragraphs();
            parts = cell(1, 0);
            for i = 1:numel(ps)
                parts{end+1} = char(string(ps{i}.text)); %#ok<AGROW>
            end
            % Drop a single trailing empty paragraph (common after clear/set)
            while numel(parts) > 1 && strlength(string(parts{end})) == 0
                parts(end) = [];
            end
            if isempty(parts)
                t = "";
            else
                t = string(strjoin(parts, newline));
            end
        end

        function set.text(obj, value)
            value = string(value);
            % split on \n into paragraphs
            lines = split(value, newline);
            if ismethod(obj.txBody_, "clear_content")
                obj.txBody_.clear_content();
            else
                kids = obj.txBody_.getchildren();
                for i = numel(kids):-1:1
                    if strcmp(char(kids{i}.localName()), "p")
                        obj.txBody_.remove(kids{i});
                    end
                end
            end
            if isempty(lines)
                lines = "";
            end
            for i = 1:numel(lines)
                p = obj.add_paragraph();
                p.text = lines(i);
            end
        end

        function v = get.word_wrap(obj)
            bodyPr = obj.bodyPr_();
            if isempty(bodyPr)
                v = [];
                return
            end
            raw = bodyPr.get("wrap");
            if mat2ppt.isAbsent(raw)
                v = [];
            elseif strcmp(char(string(raw)), "none")
                v = false;
            else
                v = true;
            end
        end

        function set.word_wrap(obj, value)
            bodyPr = obj.ensure_bodyPr_();
            if mat2ppt.isAbsent(value)
                bodyPr.removeAttr("wrap");
            elseif value
                bodyPr.set("wrap", "square");
            else
                bodyPr.set("wrap", "none");
            end
        end

        function v = get.margin_left(obj)
            %MARGIN_LEFT  Inset from left (EMU); default 91440 when attr absent.
            v = obj.margin_get_("lIns", 91440);
        end
        function set.margin_left(obj, emu)
            obj.margin_set_("lIns", emu);
        end

        function v = get.margin_right(obj)
            v = obj.margin_get_("rIns", 91440);
        end
        function set.margin_right(obj, emu)
            obj.margin_set_("rIns", emu);
        end

        function v = get.margin_top(obj)
            v = obj.margin_get_("tIns", 45720);
        end
        function set.margin_top(obj, emu)
            obj.margin_set_("tIns", emu);
        end

        function v = get.margin_bottom(obj)
            v = obj.margin_get_("bIns", 45720);
        end
        function set.margin_bottom(obj, emu)
            obj.margin_set_("bIns", emu);
        end

        function v = get.vertical_anchor(obj)
            %VERTICAL_ANCHOR  MSO_VERTICAL_ANCHOR or [] if inherited (absent).
            bodyPr = obj.bodyPr_();
            if isempty(bodyPr)
                v = [];
                return
            end
            raw = bodyPr.get("anchor");
            if mat2ppt.isAbsent(raw)
                v = [];
            else
                v = mat2ppt.enum.MSO_VERTICAL_ANCHOR.from_xml(char(string(raw)));
            end
        end

        function set.vertical_anchor(obj, value)
            bodyPr = obj.ensure_bodyPr_();
            if mat2ppt.isAbsent(value)
                bodyPr.removeAttr("anchor");
            else
                bodyPr.set("anchor", mat2ppt.enum.MSO_VERTICAL_ANCHOR.to_xml(value));
            end
        end

        function v = get.auto_size(obj)
            %AUTO_SIZE  MSO_AUTO_SIZE member or [] if no autofit child.
            bodyPr = obj.bodyPr_();
            if isempty(bodyPr)
                v = [];
                return
            end
            if ~isempty(obj.find_body_child_(bodyPr, "noAutofit"))
                v = mat2ppt.enum.MSO_AUTO_SIZE.NONE;
            elseif ~isempty(obj.find_body_child_(bodyPr, "normAutofit"))
                v = mat2ppt.enum.MSO_AUTO_SIZE.TEXT_TO_FIT_SHAPE;
            elseif ~isempty(obj.find_body_child_(bodyPr, "spAutoFit"))
                v = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
            else
                v = [];
            end
        end

        function set.auto_size(obj, value)
            bodyPr = obj.ensure_bodyPr_();
            obj.remove_autofit_children_(bodyPr);
            if mat2ppt.isAbsent(value)
                return
            end
            if isa(value, "mat2ppt.enum.BaseEnum")
                val = value.value;
            else
                val = double(value);
            end
            AS = mat2ppt.enum.MSO_AUTO_SIZE;
            if val == AS.NONE.value
                bodyPr.append(mat2ppt.oxml.OxmlElement("a:noAutofit"));
            elseif val == AS.TEXT_TO_FIT_SHAPE.value
                bodyPr.append(mat2ppt.oxml.OxmlElement("a:normAutofit"));
            elseif val == AS.SHAPE_TO_FIT_TEXT.value
                bodyPr.append(mat2ppt.oxml.OxmlElement("a:spAutoFit"));
            else
                error("mat2ppt:ValueError", ...
                    "auto_size must be None or a member of MSO_AUTO_SIZE");
            end
        end

        function fit_text(obj, fontFamily, maxSize, bold, italic, fontFile)
            %FIT_TEXT  Best-fit font size into shape extents (python TextFrame.fit_text).
            arguments
                obj
                fontFamily = "Calibri"
                maxSize (1,1) double = 18
                bold (1,1) logical = false
                italic (1,1) logical = false
                fontFile = []
            end
            if strlength(string(obj.text)) == 0
                return
            end
            if mat2ppt.isAbsent(fontFile) || strlength(string(fontFile)) == 0
                fontFile = mat2ppt.text.FontFiles.find(char(string(fontFamily)), bold, italic);
            else
                fontFile = char(string(fontFile));
            end
            extents = obj.extents_emu_();
            pt = mat2ppt.text.TextFitter.best_fit_font_size( ...
                obj.text, extents, maxSize, fontFile);
            obj.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.NONE;
            obj.word_wrap = true;
            obj.set_font_all_(char(string(fontFamily)), pt, bold, italic);
        end
    end

    methods (Access = private)
        function v = margin_get_(obj, attr, defaultEmu)
            bodyPr = obj.bodyPr_();
            if isempty(bodyPr)
                v = mat2ppt.util.Emu(defaultEmu);
                return
            end
            raw = bodyPr.get(attr);
            if mat2ppt.isAbsent(raw)
                v = mat2ppt.util.Emu(defaultEmu);
            else
                v = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function margin_set_(obj, attr, emu)
            bodyPr = obj.ensure_bodyPr_();
            e = mat2ppt.util.Length.toEmuInt_(emu);
            bodyPr.set(attr, char(string(e)));
        end

        function ensure_one_paragraph_(obj)
            if ismethod(obj.txBody_, "p_lst")
                lst = obj.txBody_.p_lst();
            else
                lst = {};
                kids = obj.txBody_.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "p")
                        lst{end+1} = kids{i}; %#ok<AGROW>
                    end
                end
            end
            if isempty(lst)
                obj.add_paragraph();
            end
        end

        function bodyPr = bodyPr_(obj)
            bodyPr = obj.txBody_.find("a:bodyPr");
            if ~isempty(bodyPr), return; end
            kids = obj.txBody_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "bodyPr")
                    bodyPr = kids{i}; return
                end
            end
            bodyPr = [];
        end

        function bodyPr = ensure_bodyPr_(obj)
            bodyPr = obj.bodyPr_();
            if ~isempty(bodyPr), return; end
            bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
            kids = obj.txBody_.getchildren();
            for i = 1:numel(kids)
                obj.txBody_.remove(kids{i});
            end
            obj.txBody_.append(bodyPr);
            for i = 1:numel(kids)
                obj.txBody_.append(kids{i});
            end
        end

        function c = find_body_child_(~, bodyPr, localName)
            c = bodyPr.find("a:" + string(localName));
            if ~isempty(c), return; end
            kids = bodyPr.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    c = kids{i};
                    return
                end
            end
            c = [];
        end

        function remove_autofit_children_(obj, bodyPr)
            names = {"noAutofit", "normAutofit", "spAutoFit"};
            for n = 1:numel(names)
                while true
                    ch = obj.find_body_child_(bodyPr, names{n});
                    if isempty(ch), break; end
                    bodyPr.remove(ch);
                end
            end
        end

        function extents = extents_emu_(obj)
            % Effective rendering area (parent size minus margins).
            parent = obj.parent_;
            if ismethod(parent, "width_emu")
                w = double(parent.width_emu().emu);
                h = double(parent.height_emu().emu);
            else
                w = double(parent.width.emu);
                h = double(parent.height.emu);
            end
            ml = double(obj.margin_left.emu);
            mr = double(obj.margin_right.emu);
            mt = double(obj.margin_top.emu);
            mb = double(obj.margin_bottom.emu);
            extents = [max(0, w - ml - mr), max(0, h - mt - mb)];
        end

        function set_font_all_(obj, family, pointSize, bold, italic)
            % Set font on all runs + endParaRPr (python TextFrame._set_font).
            ps = obj.paragraphs();
            for i = 1:numel(ps)
                p = ps{i};
                rs = p.runs();
                for j = 1:numel(rs)
                    f = rs{j}.font();
                    f.name = family;
                    f.size = mat2ppt.util.Pt(pointSize);
                    f.bold = bold;
                    f.italic = italic;
                end
                % endParaRPr
                endRPr = p.element().find("a:endParaRPr");
                if isempty(endRPr)
                    kids = p.element().getchildren();
                    for k = 1:numel(kids)
                        if strcmp(char(kids{k}.localName()), "endParaRPr")
                            endRPr = kids{k};
                            break
                        end
                    end
                end
                if isempty(endRPr)
                    endRPr = mat2ppt.oxml.OxmlElement("a:endParaRPr");
                    p.element().append(endRPr);
                end
                fEnd = mat2ppt.text.Font(endRPr);
                fEnd.name = family;
                fEnd.size = mat2ppt.util.Pt(pointSize);
                fEnd.bold = bold;
                fEnd.italic = italic;
            end
        end
    end

    methods (Static)
        function tf = from_shape_element(sp, parent)
            %FROM_SHAPE_ELEMENT  Locate or create p:txBody under p:sp.
            tx = sp.find("p:txBody");
            if isempty(tx)
                kids = sp.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "txBody")
                        tx = kids{i}; break
                    end
                end
            end
            if isempty(tx)
                tx = mat2ppt.oxml.text.CT_TextBody.new();
                sp.append(tx);
            end
            tf = mat2ppt.text.TextFrame(tx, parent);
        end
    end
end
