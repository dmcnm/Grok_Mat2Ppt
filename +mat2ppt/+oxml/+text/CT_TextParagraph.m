classdef CT_TextParagraph < mat2ppt.oxml.BaseOxmlElement
%CT_TEXTPARAGRAPH  a:p element (P5-W12).
%
%   Ported from python-pptx oxml/text.py::CT_TextParagraph

    methods
        function obj = CT_TextParagraph(tag)
            if nargin < 1, tag = "a:p"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function r = add_r(obj)
            r = mat2ppt.oxml.text.CT_RegularTextRun.new("");
            obj.append(r);
        end

        function t = get_text(obj)
            parts = strings(0);
            kids = obj.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "r")
                    run = kids{i};
                    if ismethod(run, "get_text")
                        parts(end+1) = string(run.get_text()); %#ok<AGROW>
                    else
                        tEl = run.find("a:t");
                        if ~isempty(tEl) && ~mat2ppt.isAbsent(tEl.text)
                            parts(end+1) = string(tEl.text); %#ok<AGROW>
                        end
                    end
                end

            end
            t = join(parts, "");
        end
    end

    methods (Static)
        function obj = new()
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            obj = mat2ppt.oxml.text.CT_TextParagraph(sprintf("{%s}p", A));
        end
    end
end
