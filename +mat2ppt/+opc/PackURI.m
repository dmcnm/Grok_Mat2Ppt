classdef PackURI
%PACKURI  Absolute pack URI (partname) starting with '/'.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/packuri.py::PackURI

    properties (SetAccess = private)
        uri (1,1) string
    end

    properties (Dependent, SetAccess = private)
        baseURI
        filename
        ext
        membername
        rels_uri
    end

    methods
        function obj = PackURI(pack_uri_str)
            pack_uri_str = string(pack_uri_str);
            if strlength(pack_uri_str) < 1 || extractBefore(pack_uri_str, 2) ~= "/"
                error("mat2ppt:ValueError", ...
                    "PackURI must begin with slash, got %s.", pack_uri_str);
            end
            obj.uri = pack_uri_str;
        end

        function s = char(obj), s = char(obj.uri); end
        function s = string(obj), s = obj.uri; end
        function tf = eq(a, b), tf = string(a) == string(b); end

        function v = get.baseURI(obj)
            % Directory of the pack URI (posix), e.g. /ppt/presentation.xml -> /ppt
            u = char(obj.uri);
            if strcmp(u, "/")
                v = "/";
                return
            end
            parts = split(string(u), "/");
            % parts(1) empty before first /
            if numel(parts) <= 2
                v = "/";
                return
            end
            v = char("/" + join(parts(2:end-1), "/"));
        end

        function v = get.filename(obj)
            u = char(obj.uri);
            if strcmp(u, "/")
                v = "";
                return
            end
            parts = split(string(u), "/");
            v = char(parts(end));
        end

        function v = get.ext(obj)
            fn = obj.filename;
            if isempty(fn)
                v = "";
                return
            end
            tokens = split(string(fn), ".");
            if numel(tokens) < 2
                v = "";
            else
                v = char(tokens(end));
            end
        end

        function v = get.membername(obj)
            u = char(obj.uri);
            if strcmp(u, "/")
                v = "";
            else
                v = u(2:end);
            end
        end

        function r = get.rels_uri(obj)
            % /ppt/slides/slide1.xml -> /ppt/slides/_rels/slide1.xml.rels
            % / -> /_rels/.rels
            if obj.uri == "/"
                r = mat2ppt.opc.PackURI("/_rels/.rels");
                return
            end
            base = obj.baseURI;
            fn = obj.filename;
            if strcmp(base, "/")
                rels = sprintf("/_rels/%s.rels", fn);
            else
                rels = sprintf("%s/_rels/%s.rels", base, fn);
            end
            r = mat2ppt.opc.PackURI(rels);
        end
    end

    methods (Static)
        function u = from_rel_ref(baseURI, relative_ref)
            % Join and normalize like posixpath.abspath (OPC pack URIs).
            baseURI = string(baseURI);
            relative_ref = string(relative_ref);
            relative_ref = strrep(relative_ref, "\", "/");
            if startsWith(relative_ref, "/")
                joined = relative_ref;
            else
                if ~endsWith(baseURI, "/")
                    baseURI = baseURI + "/";
                end
                joined = baseURI + relative_ref;
            end
            joined = strrep(joined, "\", "/");
            % collapse .. and .
            parts = split(joined, "/");
            stack = strings(0);
            for i = 1:numel(parts)
                p = parts(i);
                if p == "" || p == "."
                    continue
                elseif p == ".."
                    if ~isempty(stack)
                        stack(end) = [];
                    end
                else
                    stack(end+1) = p; %#ok<AGROW>
                end
            end
            if isempty(stack)
                absu = "/";
            else
                absu = "/" + join(stack, "/");
            end
            u = mat2ppt.opc.PackURI(absu);
        end
    end
end
