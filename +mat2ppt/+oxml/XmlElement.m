classdef XmlElement < handle
%XMLELEMENT  Mutable XML element tree node (lxml-like surface for Mat2Ppt).
%
%   e = mat2ppt.oxml.XmlElement(clarkOrPrefixedTag)
%   e.append(child), e.text, e.get(attr), e.set(attr, val)
%
%   Design-realization of the lxml _Element surface used by python-pptx
%   (see design.md). text/tail use [] for None and "" for empty string.
%
%   Ported from python-pptx 1.0.2: lxml element surface used via oxml

    properties (SetAccess = private)
        tag (1,1) string  % Clark name {uri}local
    end

    properties
        % [] = None, string may be ""
        text = []
        tail = []
    end

    properties (Access = private)
        attribNames_ cell = {}   % ordered attribute names (Clark or plain)
        attribValues_ cell = {}
        children_ cell = {}      % XmlElement handles
        parent_ = []             % XmlElement or []
        % Ordered xmlns decls on this element: {prefix, uri}; prefix '' = default
        % Mirrors lxml element.nsmap order for re-serialize identity.
        nsDecls_ cell = {}
    end

    methods
        function obj = XmlElement(tag)
            arguments
                tag
            end
            tag = string(tag);
            if contains(tag, ":") && ~startsWith(tag, "{")
                tag = string(mat2ppt.oxml.qn(tag));
            end
            obj.tag = tag;
        end

        function v = get(obj, name, default)
            %GET  Attribute value or default ([] if omitted and missing).
            if nargin < 3
                default = [];
            end
            name = char(string(name));
            idx = obj.findAttrIndex_(name);
            if idx == 0
                v = default;
            else
                v = obj.attribValues_{idx};
            end
        end

        function set(obj, name, value)
            %SET  Set attribute (string value).
            name = char(string(name));
            value = char(string(value));
            idx = obj.findAttrIndex_(name);
            if idx == 0
                obj.attribNames_{end+1} = name; %#ok<AGROW>
                obj.attribValues_{end+1} = value; %#ok<AGROW>
            else
                obj.attribValues_{idx} = value;
            end
        end

        function removeAttr(obj, name)
            name = char(string(name));
            idx = obj.findAttrIndex_(name);
            if idx > 0
                obj.attribNames_(idx) = [];
                obj.attribValues_(idx) = [];
            end
        end

        function n = attribCount(obj)
            n = numel(obj.attribNames_);
        end

        function [names, values] = attribItems(obj)
            names = obj.attribNames_;
            values = obj.attribValues_;
        end

        function append(obj, child)
            arguments
                obj
                child (1,1) mat2ppt.oxml.XmlElement
            end
            child.detach_();
            child.parent_ = obj;
            obj.children_{end+1} = child; %#ok<AGROW>
        end

        function insert(obj, index, child)
            %INSERT  1-based index among children (MATLAB).
            arguments
                obj
                index (1,1) double
                child (1,1) mat2ppt.oxml.XmlElement
            end
            n = numel(obj.children_);
            if index < 1 || index > n + 1
                error("mat2ppt:IndexOutOfRange", ...
                    "Child insert index %d out of range. Valid is 1 through %d.", ...
                    index, n + 1);
            end
            child.detach_();
            child.parent_ = obj;
            obj.children_ = [obj.children_(1:index-1), {child}, obj.children_(index:end)];
        end

        function remove(obj, child)
            arguments
                obj
                child (1,1) mat2ppt.oxml.XmlElement
            end
            for i = 1:numel(obj.children_)
                if obj.children_{i} == child
                    obj.children_(i) = [];
                    child.parent_ = [];
                    return
                end
            end
            error("mat2ppt:ValueError", "Element is not a child of this node.");
        end

        function c = getchildren(obj)
            c = obj.children_;
        end

        function n = childCount(obj)
            n = numel(obj.children_);
        end

        function c = child(obj, k)
            %CHILD  1-based child access.
            n = numel(obj.children_);
            if k < 1 || k > n
                error("mat2ppt:IndexOutOfRange", ...
                    "Child index %d out of range. Valid indices are 1 through %d (1-based).", ...
                    k, n);
            end
            c = obj.children_{k};
        end

        function p = getparent(obj)
            p = obj.parent_;
        end

        function f = find(obj, tag)
            %FIND  First direct child with Clark or prefix:local tag, or [].
            tag = string(tag);
            if contains(tag, ":") && ~startsWith(tag, "{")
                tag = string(mat2ppt.oxml.qn(tag));
            end
            f = [];
            for i = 1:numel(obj.children_)
                if obj.children_{i}.tag == tag
                    f = obj.children_{i};
                    return
                end
            end
        end

        function list = findall(obj, tag)
            tag = string(tag);
            if contains(tag, ":") && ~startsWith(tag, "{")
                tag = string(mat2ppt.oxml.qn(tag));
            end
            list = {};
            for i = 1:numel(obj.children_)
                if obj.children_{i}.tag == tag
                    list{end+1} = obj.children_{i}; %#ok<AGROW>
                end
            end
        end

        function s = localName(obj)
            t = char(obj.tag);
            if t(1) == '{'
                s = extractAfter(string(t), "}");
            else
                s = string(t);
            end
        end

        function setNsDecls(obj, decls)
            %SETNSDECLS  Store ordered xmlns decls {prefix,uri} cell rows.
            % prefix '' (empty char) means default xmlns.
            if isempty(decls)
                obj.nsDecls_ = {};
            else
                obj.nsDecls_ = decls;
            end
        end

        function decls = getNsDecls(obj)
            %GETNSDECLS  Ordered {prefix, uri} cell (Nx2) or {}.
            decls = obj.nsDecls_;
        end

        function tf = hasNsDecls(obj)
            tf = ~isempty(obj.nsDecls_);
        end
    end

    methods (Access = private)
        function idx = findAttrIndex_(obj, name)
            idx = 0;
            for i = 1:numel(obj.attribNames_)
                if strcmp(obj.attribNames_{i}, name)
                    idx = i;
                    return
                end
            end
        end

        function detach_(obj)
            if ~isempty(obj.parent_) && isvalid(obj.parent_)
                try
                    obj.parent_.remove(obj);
                catch
                    obj.parent_ = [];
                end
            end
            obj.parent_ = [];
        end
    end
end
