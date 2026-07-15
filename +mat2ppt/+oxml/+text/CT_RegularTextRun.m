classdef CT_RegularTextRun < mat2ppt.oxml.BaseOxmlElement
%CT_REGULARTEXTRUN  a:r element (P5-W12).
%
%   Ported from python-pptx oxml/text.py::CT_RegularTextRun

    methods
        function obj = CT_RegularTextRun(tag)
            if nargin < 1, tag = "a:r"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function t = get_text(obj)
            tEl = obj.find_t_();
            if isempty(tEl) || mat2ppt.isAbsent(tEl.text)
                t = "";
            else
                t = string(tEl.text);
            end
        end
        function set_text(obj, value)
            tEl = obj.find_t_();
            if isempty(tEl)
                tEl = mat2ppt.oxml.OxmlElement("a:t");
                obj.append(tEl);
            end
            tEl.text = char(string(value));
        end
    end

    methods (Access = private)
        function tEl = find_t_(obj)
            tEl = obj.find("a:t");
            if isempty(tEl)
                kids = obj.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "t")
                        tEl = kids{i}; return
                    end
                end
            end
        end
    end

    methods (Static)
        function obj = new(textStr)
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            obj = mat2ppt.oxml.text.CT_RegularTextRun(sprintf("{%s}r", A));
            t = mat2ppt.oxml.XmlElement(sprintf("{%s}t", A));
            obj.append(t);
            if nargin >= 1
                obj.set_text(textStr);
            end
        end
    end
end

