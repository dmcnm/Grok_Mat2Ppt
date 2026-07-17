classdef ShapeHyperlink < handle
%SHAPEHYPERLINK  Hyperlink address on shape cNvPr (R4).
%
%   Ported from python-pptx action.Hyperlink (shape path).

    properties (Access = private)
        cNvPr_
        shape_
        hover_ (1,1) logical = false
    end

    properties (Dependent)
        address
    end

    methods
        function obj = ShapeHyperlink(cNvPr, shape, hover)
            arguments
                cNvPr (1,1) mat2ppt.oxml.XmlElement
                shape
                hover (1,1) logical = false
            end
            obj.cNvPr_ = cNvPr;
            obj.shape_ = shape;
            obj.hover_ = hover;
        end

        function v = get.address(obj)
            h = obj.find_hlink_();
            if isempty(h)
                v = [];
                return
            end
            rid = mat2ppt.opc.rId_attr(h);
            if isempty(rid)
                v = [];
                return
            end
            [pkg, pn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
            v = string(pkg.external_target(pn, rid));
        end

        function set.address(obj, url)
            obj.remove_hlink_();
            if mat2ppt.isAbsent(url) || strlength(string(url)) == 0
                return
            end
            [pkg, pn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
            rId = pkg.add_external_relationship(pn, ...
                mat2ppt.opc.RELATIONSHIP_TYPE.HYPERLINK, char(string(url)));
            h = mat2ppt.oxml.OxmlElement("a:hlinkClick");
            h.set(mat2ppt.oxml.qn("r:id"), rId);
            obj.cNvPr_.append(h);
        end
    end

    methods (Access = private)
        function h = find_hlink_(obj)
            tag = "hlinkClick";
            if obj.hover_, tag = "hlinkHover"; end
            h = obj.cNvPr_.find("a:" + string(tag));
            if ~isempty(h), return; end
            kids = obj.cNvPr_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), tag)
                    h = kids{i}; return
                end
            end
            h = [];
        end

        function remove_hlink_(obj)
            h = obj.find_hlink_();
            if isempty(h), return; end
            rid = mat2ppt.opc.rId_attr(h);
            if ~isempty(rid)
                [pkg, pn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
                pkg.drop_relationship(pn, rid);
            end
            obj.cNvPr_.remove(h);
        end
    end
end
