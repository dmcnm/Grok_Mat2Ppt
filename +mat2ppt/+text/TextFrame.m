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
