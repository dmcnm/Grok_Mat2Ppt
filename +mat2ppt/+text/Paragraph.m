classdef Paragraph < mat2ppt.shared.ParentedElementProxy
%PARAGRAPH  Text paragraph (a:p).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::_Paragraph (P6-W1)

    properties (Access = private)
        p_
    end

    properties (Dependent)
        text
        level
    end

    methods
        function obj = Paragraph(pElm, parent)
            arguments
                pElm (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ParentedElementProxy(pElm, parent);
            obj.p_ = pElm;
        end

        function r = add_run(obj)
            if ismethod(obj.p_, "add_r")
                rElm = obj.p_.add_r();
            else
                rElm = mat2ppt.oxml.text.CT_RegularTextRun.new("");
                obj.p_.append(rElm);
            end
            r = mat2ppt.text.Run(rElm, obj);
        end

        function clear_content(obj)
            %CLEAR_CONTENT  Remove run/break/field children (python Paragraph.clear).
            % Named clear_content to avoid clashing with MATLAB handle clear.
            % Index-based walk on p_ (same as add_run / runs) so removals stay
            % on the live tree; avoid any(strcmp(..., cell)) edge cases.
            elm = obj.p_;
            i = elm.childCount();
            while i >= 1
                kid = elm.child(i);
                ln = char(kid.localName());
                if strcmp(ln, "r") || strcmp(ln, "br") || strcmp(ln, "fld")
                    elm.remove(kid);
                end
                i = i - 1;
            end
        end

        function t = get.text(obj)
            if ismethod(obj.p_, "get_text")
                t = string(obj.p_.get_text());
            else
                t = "";
            end
        end

        function set.text(obj, value)
            value = string(value);
            obj.clear_content();
            % \v and \n -> treated as same run break for M2 (simple path)
            value = strrep(value, char(11), newline);  % vertical tab
            parts = split(value, newline);
            if isempty(parts)
                parts = "";
            end
            for i = 1:numel(parts)
                if i > 1
                    br = mat2ppt.oxml.OxmlElement("a:br");
                    obj.p_.append(br);
                end
                r = obj.add_run();
                r.text = parts(i);
            end
        end

        function runs = runs(obj)
            runs = {};
            kids = obj.p_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "r")
                    runs{end+1} = mat2ppt.text.Run(kids{i}, obj); %#ok<AGROW>
                end
            end
        end

        function n = get.level(obj)
            pPr = obj.p_.find("a:pPr");
            if isempty(pPr)
                n = 0;
                return
            end
            raw = pPr.get("lvl");
            if mat2ppt.isAbsent(raw)
                n = 0;
            else
                n = str2double(raw);
            end
        end

        function set.level(obj, value)
            value = double(value);
            if value < 0 || value > 8 || value ~= floor(value)
                error("mat2ppt:ValueError", "level must be integer 0..8");
            end
            pPr = obj.p_.find("a:pPr");
            if isempty(pPr)
                pPr = mat2ppt.oxml.OxmlElement("a:pPr");
                % prepend: rebuild
                kids = obj.p_.getchildren();
                for i = 1:numel(kids)
                    obj.p_.remove(kids{i});
                end
                obj.p_.append(pPr);
                for i = 1:numel(kids)
                    obj.p_.append(kids{i});
                end
            end
            pPr.set("lvl", char(string(value)));
        end

        function f = font(obj)
            % Default run props bag (shell if no defRPr)
            f = mat2ppt.text.Font();
        end
    end
end
