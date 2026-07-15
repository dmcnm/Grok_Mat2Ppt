classdef PackURI
%PACKURI  Absolute pack URI (partname) starting with '/'.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/packuri.py::PackURI

    properties (SetAccess = private)
        uri (1,1) string
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
            u = char(obj.uri);
            if strcmp(u, "/")
                v = "/";
                return
            end
            [p, ~] = fileparts(strrep(u, "/", filesep));
            v = strrep(p, filesep, "/");
            if isempty(v), v = "/"; end
            if v(1) ~= "/", v = ["/" + string(v)]; v = char(v); end
        end

        function v = get.filename(obj)
            u = char(obj.uri);
            if strcmp(u, "/"), v = ""; return; end
            [~, name, ext] = fileparts(strrep(u, "/", filesep));
            v = [name, ext];
        end

        function v = get.ext(obj)
            [~, ~, e] = fileparts(obj.filename);
            if ~isempty(e) && e(1) == ".", v = e(2:end); else, v = e; end
        end

        function v = get.membername(obj)
            u = char(obj.uri);
            if strcmp(u, "/"), v = ""; else, v = u(2:end); end
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
            rels = sprintf("%s/_rels/%s.rels", base, fn);
            if startsWith(string(rels), "//")
                rels = extractAfter(string(rels), 1);
            end
            r = mat2ppt.opc.PackURI(rels);
        end
    end

    methods (Static)
        function u = from_rel_ref(baseURI, relative_ref)
            % Join and normalize like posixpath.abspath
            baseURI = char(string(baseURI));
            relative_ref = char(string(relative_ref));
            if baseURI(end) ~= "/"
                joined = [baseURI, "/", relative_ref];
            else
                joined = [baseURI, relative_ref];
            end
            joined = strrep(joined, "\", "/");
            % collapse .. and .
            parts = split(string(joined), "/");
            stack = strings(0);
            for i = 1:numel(parts)
                p = parts(i);
                if p == "" || p == "."
                    continue
                elseif p == ".."
                    if ~isempty(stack), stack(end) = []; end
                else
                    stack(end+1) = p; %#ok<AGROW>
                end
            end
            absu = "/" + join(stack, "/");
            if strlength(absu) == 0, absu = "/"; end
            u = mat2ppt.opc.PackURI(absu);
        end
    end
end
