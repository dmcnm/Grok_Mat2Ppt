classdef CT_TextBody < mat2ppt.oxml.BaseOxmlElement
%CT_TEXTBODY  p:txBody / a:txBody (P5-W12).
%
%   Ported from python-pptx oxml/text.py::CT_TextBody

    methods
        function obj = CT_TextBody(tag)
            if nargin < 1, tag = "p:txBody"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function p = add_p(obj)
            p = mat2ppt.oxml.text.CT_TextParagraph.new();
            obj.append(p);
        end

        function clear_content(obj)
            kids = obj.getchildren();
            for i = numel(kids):-1:1
                if strcmp(char(kids{i}.localName()), "p")
                    obj.remove(kids{i});
                end
            end
        end

        function lst = p_lst(obj)
            lst = {};
            kids = obj.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "p")
                    lst{end+1} = kids{i}; %#ok<AGROW>
                end
            end
        end
    end

    methods (Static)
        function obj = new()
            P = "http://schemas.openxmlformats.org/presentationml/2006/main";
            obj = mat2ppt.oxml.text.CT_TextBody(sprintf("{%s}txBody", P));
            obj.append(mat2ppt.oxml.OxmlElement("a:bodyPr"));
            obj.append(mat2ppt.oxml.OxmlElement("a:lstStyle"));
            obj.add_p();
        end
    end
end
