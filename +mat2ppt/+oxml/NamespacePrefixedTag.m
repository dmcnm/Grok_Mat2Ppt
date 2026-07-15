classdef NamespacePrefixedTag
%NAMESPACEPREFIXEDTAG  Value object for a namespace-prefixed XML tag.
%
%   t = mat2ppt.oxml.NamespacePrefixedTag("a:foobar")
%   t.clark_name, t.local_part, t.nspfx, t.nsuri, t.nsmap, t.tag
%
%   Behaves like a string via .tag / char/string conversion.
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/ns.py::NamespacePrefixedTag

    properties (SetAccess = private)
        tag (1,1) string
        nspfx (1,1) string
        local_part (1,1) string
        nsuri (1,1) string
    end

    properties (Dependent, SetAccess = private)
        clark_name
        nsmap
    end

    methods
        function obj = NamespacePrefixedTag(nstag)
            nstag = string(nstag);
            parts = split(nstag, ":");
            if numel(parts) ~= 2
                error("mat2ppt:InvalidTag", ...
                    "Namespace-prefixed tag must look like 'pfx:local', got '%s'.", nstag);
            end
            obj.tag = nstag;
            obj.nspfx = parts(1);
            obj.local_part = parts(2);
            m = mat2ppt.oxml.nsmap_data();
            pfx = char(obj.nspfx);
            if ~isKey(m, pfx)
                error("mat2ppt:UnknownNamespacePrefix", ...
                    "Unknown namespace prefix '%s'.", pfx);
            end
            obj.nsuri = string(m(pfx));
        end

        function v = get.clark_name(obj)
            v = sprintf("{%s}%s", obj.nsuri, obj.local_part);
        end

        function v = get.nsmap(obj)
            % Single-entry map prefix → uri (like Python dict)
            v = containers.Map({char(obj.nspfx)}, {char(obj.nsuri)});
        end

        function s = char(obj)
            s = char(obj.tag);
        end

        function s = string(obj)
            s = obj.tag;
        end

        function tf = eq(a, b)
            tf = string(a) == string(b);
        end
    end

    methods (Static)
        function obj = from_clark_name(clark_name)
            %FROM_CLARK_NAME  Build from '{uri}local' Clark notation.
            clark_name = char(clark_name);
            if clark_name(1) ~= '{'
                error("mat2ppt:InvalidClarkName", ...
                    "Clark name must start with '{', got '%s'.", clark_name);
            end
            close = find(clark_name == '}', 1, 'first');
            nsuri = clark_name(2:close-1);
            local_name = clark_name(close+1:end);
            pm = mat2ppt.oxml.pfxmap_data();
            if ~isKey(pm, nsuri)
                error("mat2ppt:UnknownNamespaceUri", ...
                    "Unknown namespace URI '%s'.", nsuri);
            end
            nstag = sprintf("%s:%s", pm(nsuri), local_name);
            obj = mat2ppt.oxml.NamespacePrefixedTag(nstag);
        end
    end
end
