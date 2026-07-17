classdef ShadowFormat < handle
%SHADOWFORMAT  Shape shadow settings (upstream: inherit only).
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/effect.py::ShadowFormat (R2-W5)

    properties (Access = private)
        spPr_
    end

    properties (Dependent)
        inherit
    end

    methods
        function obj = ShadowFormat(spPr)
            arguments
                spPr (1,1) mat2ppt.oxml.XmlElement
            end
            obj.spPr_ = spPr;
        end

        function tf = get.inherit(obj)
            %INHERIT  True when no a:effectLst (shadow inherits from style).
            el = obj.find_effectLst_();
            tf = isempty(el);
        end

        function set.inherit(obj, value)
            % Assign True removes effectLst; False ensures empty effectLst present.
            if value
                el = obj.find_effectLst_();
                if ~isempty(el)
                    obj.spPr_.remove(el);
                end
            else
                el = obj.find_effectLst_();
                if isempty(el)
                    obj.spPr_.append(mat2ppt.oxml.OxmlElement("a:effectLst"));
                end
            end
        end
    end

    methods (Access = private)
        function el = find_effectLst_(obj)
            el = obj.spPr_.find("a:effectLst");
            if ~isempty(el), return; end
            kids = obj.spPr_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "effectLst")
                    el = kids{i}; return
                end
            end
            el = [];
        end
    end
end
