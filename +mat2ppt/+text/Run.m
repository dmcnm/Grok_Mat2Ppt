classdef Run < mat2ppt.shared.ParentedElementProxy
%RUN  Text run (a:r).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::_Run (P6-W1)

    properties (Access = private)
        r_
    end

    properties (Dependent)
        text
    end

    methods
        function obj = Run(rElm, parent)
            arguments
                rElm (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ParentedElementProxy(rElm, parent);
            obj.r_ = rElm;
        end

        function t = get.text(obj)
            if ismethod(obj.r_, "get_text")
                t = string(obj.r_.get_text());
            else
                tEl = obj.r_.find("a:t");
                if isempty(tEl) || mat2ppt.isAbsent(tEl.text)
                    t = "";
                else
                    t = string(tEl.text);
                end
            end
        end

        function set.text(obj, value)
            if ismethod(obj.r_, "set_text")
                obj.r_.set_text(value);
            else
                tEl = obj.r_.find("a:t");
                if isempty(tEl)
                    tEl = mat2ppt.oxml.OxmlElement("a:t");
                    obj.r_.append(tEl);
                end
                tEl.text = char(string(value));
            end
        end

        function f = font(obj)
            rPr = obj.ensure_rPr_();
            f = mat2ppt.text.Font(rPr);
        end
    end

    methods (Access = private)
        function rPr = ensure_rPr_(obj)
            rPr = obj.r_.find("a:rPr");
            if ~isempty(rPr), return; end
            kids = obj.r_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "rPr")
                    rPr = kids{i}; return
                end
            end
            rPr = mat2ppt.oxml.OxmlElement("a:rPr");
            % insert before a:t if present
            tEl = [];
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "t")
                    tEl = kids{i}; break
                end
            end
            if isempty(tEl)
                obj.r_.append(rPr);
            else
                % append then reorder not available; append rPr then t already there
                % insert at start by rebuild: remove t, append rPr, re-append t
                obj.r_.remove(tEl);
                obj.r_.append(rPr);
                obj.r_.append(tEl);
            end
        end
    end
end
