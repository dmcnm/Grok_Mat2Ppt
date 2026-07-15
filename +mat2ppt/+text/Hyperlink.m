classdef Hyperlink < handle
%HYPERLINK  Run hyperlink (a:hlinkClick on a:rPr).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/text.py::_Hyperlink (P6-W7)

    properties (Access = private)
        rPr_
        run_  % owning Run (for package + partname)
    end

    properties (Dependent)
        address
    end

    methods
        function obj = Hyperlink(rPr, run)
            arguments
                rPr (1,1) mat2ppt.oxml.XmlElement
                run
            end
            obj.rPr_ = rPr;
            obj.run_ = run;
        end

        function v = get.address(obj)
            h = obj.find_hlinkClick_();
            if isempty(h)
                v = [];
                return
            end
            rid = mat2ppt.opc.rId_attr(h);
            if isempty(rid)
                v = [];
                return
            end
            [pkg, pn] = mat2ppt.text.Hyperlink.pkg_part_(obj.run_);
            v = string(pkg.external_target(pn, rid));
        end

        function set.address(obj, url)
            obj.remove_hlinkClick_();
            if mat2ppt.isAbsent(url) || strlength(string(url)) == 0
                return
            end
            [pkg, pn] = mat2ppt.text.Hyperlink.pkg_part_(obj.run_);
            rId = pkg.add_external_relationship(pn, ...
                mat2ppt.opc.RELATIONSHIP_TYPE.HYPERLINK, char(string(url)));
            h = mat2ppt.oxml.OxmlElement("a:hlinkClick");
            h.set(mat2ppt.oxml.qn("r:id"), rId);
            obj.rPr_.append(h);
        end
    end

    methods (Access = private)
        function h = find_hlinkClick_(obj)
            h = obj.rPr_.find("a:hlinkClick");
            if ~isempty(h), return; end
            kids = obj.rPr_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "hlinkClick")
                    h = kids{i};
                    return
                end
            end
            h = [];
        end

        function remove_hlinkClick_(obj)
            kids = obj.rPr_.getchildren();
            for i = numel(kids):-1:1
                if strcmp(char(kids{i}.localName()), "hlinkClick")
                    obj.rPr_.remove(kids{i});
                end
            end
        end
    end

    methods (Static, Access = private)
        function [pkg, pn] = pkg_part_(run)
            p = run;
            for k = 1:12
                if ismethod(p, "part")
                    pr = p.part();
                    if isstruct(pr) && isfield(pr, "package") && isfield(pr, "partname")
                        pkg = pr.package;
                        pn = pr.partname;
                        return
                    end
                end
                if ismethod(p, "parent")
                    p = p.parent();
                else
                    break
                end
            end
            error("mat2ppt:AttributeError", "Cannot resolve package part for hyperlink");
        end
    end
end
