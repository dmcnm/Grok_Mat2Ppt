classdef CoreProperties < handle
%COREPROPERTIES  Dublin Core package metadata (/docProps/core.xml).
%
%   Ported from python-pptx 1.0.2: parts/coreprops.py + oxml/coreprops.py
%   P2-W2 strings/revision; P2-W2b created/modified/last_printed (W3CDTF).

    properties (Access = private)
        elm_  % XmlElement root cp:coreProperties
    end

    properties (Dependent)
        author
        category
        comments
        content_status
        identifier
        keywords
        language
        last_modified_by
        subject
        title
        version
        revision
        created
        modified
        last_printed
    end

    methods
        function obj = CoreProperties(elm)
            arguments
                elm (1,1) mat2ppt.oxml.XmlElement
            end
            obj.elm_ = elm;
        end

        function e = element(obj)
            e = obj.elm_;
        end

        function v = get.author(obj), v = obj.textOf_("creator"); end
        function set.author(obj, v), obj.setText_("creator", v); end

        function v = get.category(obj), v = obj.textOf_("category"); end
        function set.category(obj, v), obj.setText_("category", v); end

        function v = get.comments(obj), v = obj.textOf_("description"); end
        function set.comments(obj, v), obj.setText_("description", v); end

        function v = get.content_status(obj), v = obj.textOf_("contentStatus"); end
        function set.content_status(obj, v), obj.setText_("contentStatus", v); end

        function v = get.identifier(obj), v = obj.textOf_("identifier"); end
        function set.identifier(obj, v), obj.setText_("identifier", v); end

        function v = get.keywords(obj), v = obj.textOf_("keywords"); end
        function set.keywords(obj, v), obj.setText_("keywords", v); end

        function v = get.language(obj), v = obj.textOf_("language"); end
        function set.language(obj, v), obj.setText_("language", v); end

        function v = get.last_modified_by(obj), v = obj.textOf_("lastModifiedBy"); end
        function set.last_modified_by(obj, v), obj.setText_("lastModifiedBy", v); end

        function v = get.subject(obj), v = obj.textOf_("subject"); end
        function set.subject(obj, v), obj.setText_("subject", v); end

        function v = get.title(obj), v = obj.textOf_("title"); end
        function set.title(obj, v), obj.setText_("title", v); end

        function v = get.version(obj), v = obj.textOf_("version"); end
        function set.version(obj, v), obj.setText_("version", v); end

        function v = get.revision(obj)
            s = obj.textOf_("revision");
            if strlength(s) == 0
                v = 0;
            else
                v = str2double(s);
                if isnan(v) || v ~= floor(v) || v < 0
                    v = 0;
                end
            end
        end
        function set.revision(obj, v)
            v = double(v);
            if v ~= floor(v) || v < 1
                error("mat2ppt:ValueError", ...
                    "revision property requires positive int, got '%g'", v);
            end
            obj.setText_("revision", string(round(v)));
        end

        function v = get.created(obj)
            v = obj.datetimeOf_("created");
        end
        function set.created(obj, v)
            obj.setDatetime_("created", v, true);
        end

        function v = get.modified(obj)
            v = obj.datetimeOf_("modified");
        end
        function set.modified(obj, v)
            obj.setDatetime_("modified", v, true);
        end

        function v = get.last_printed(obj)
            v = obj.datetimeOf_("lastPrinted");
        end
        function set.last_printed(obj, v)
            obj.setDatetime_("lastPrinted", v, false);
        end
    end

    methods (Static)
        function obj = from_xml_bytes(blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.CoreProperties(elm);
        end
    end

    methods (Access = private)
        function s = textOf_(obj, localName)
            kids = obj.elm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    t = kids{i}.text;
                    if mat2ppt.isAbsent(t)
                        s = "";
                    else
                        s = string(t);
                    end
                    return
                end
            end
            s = "";
        end

        function setText_(obj, localName, value)
            value = string(value);
            if strlength(value) > 255
                error("mat2ppt:ValueError", ...
                    "Core property string exceeds 255 characters.");
            end
            el = obj.getOrAddChild_(localName);
            if strlength(value) == 0
                el.text = [];
            else
                el.text = char(value);
            end
        end

        function v = datetimeOf_(obj, localName)
            %DATETIMEOF_  [] if missing/invalid (python None).
            kids = obj.elm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    t = kids{i}.text;
                    if mat2ppt.isAbsent(t) || strlength(string(t)) == 0
                        v = [];
                        return
                    end
                    try
                        v = mat2ppt.parts.CoreProperties.parseW3CDTF_(char(string(t)));
                    catch
                        v = [];
                    end
                    return
                end
            end
            v = [];
        end

        function setDatetime_(obj, localName, value, needsXsiType)
            if mat2ppt.isAbsent(value)
                error("mat2ppt:ValueError", ...
                    "property requires datetime object, got empty/absent");
            end
            if ~isdatetime(value) || ~isscalar(value)
                error("mat2ppt:ValueError", ...
                    "property requires datetime object, got %s", class(value));
            end
            % Serialize like python: %Y-%m-%dT%H:%M:%SZ (naive wall clock as Z)
            dtStr = char(value, "yyyy-MM-dd'T'HH:mm:ss'Z'");
            el = obj.getOrAddChild_(localName);
            el.text = dtStr;
            if needsXsiType
                XSI = "http://www.w3.org/2001/XMLSchema-instance";
                el.set(sprintf("{%s}type", XSI), "dcterms:W3CDTF");
                obj.ensureRootXsiDecl_();
            end
        end

        function el = getOrAddChild_(obj, localName)
            kids = obj.elm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    el = kids{i};
                    return
                end
            end
            uri = mat2ppt.parts.CoreProperties.uriForLocal_(localName);
            el = mat2ppt.oxml.XmlElement(sprintf("{%s}%s", uri, localName));
            obj.elm_.append(el);
        end

        function ensureRootXsiDecl_(obj)
            % Ensure root carries xmlns:xsi (lxml identity for dcterms children).
            XSI = "http://www.w3.org/2001/XMLSchema-instance";
            if obj.elm_.hasNsDecls()
                decls = obj.elm_.getNsDecls();
                for i = 1:size(decls, 1)
                    if strcmp(char(string(decls{i, 2})), XSI)
                        return
                    end
                end
                decls(end+1, 1:2) = {"xsi", XSI}; %#ok<AGROW>
                obj.elm_.setNsDecls(decls);
            else
                obj.elm_.setNsDecls({"xsi", XSI});
            end
        end
    end

    methods (Static)
        function v = parseW3CDTF_(w3cdtf_str)
            %PARSEW3CDTF_  Twin of CT_CoreProperties._parse_W3CDTF_to_datetime.
            w3cdtf_str = char(string(w3cdtf_str));
            parseable = w3cdtf_str;
            if numel(w3cdtf_str) >= 19
                parseable = w3cdtf_str(1:min(19, numel(w3cdtf_str)));
            end
            offsetStr = "";
            if numel(w3cdtf_str) > 19
                offsetStr = w3cdtf_str(20:end);
            end
            % Strip trailing Z from parseable for datetime
            p = parseable;
            if endsWith(string(p), "Z")
                p = p(1:end-1);
            end
            formats = { ...
                "yyyy-MM-dd'T'HH:mm:ss", ...
                "yyyy-MM-dd", ...
                "yyyy-MM", ...
                "yyyy" ...
                };
            v = [];
            for i = 1:numel(formats)
                try
                    v = datetime(p, "InputFormat", formats{i});
                    break
                catch
                end
            end
            if isempty(v)
                error("mat2ppt:ValueError", ...
                    "could not parse W3CDTF datetime string '%s'", w3cdtf_str);
            end
            if numel(offsetStr) == 6 && (offsetStr(1) == '+' || offsetStr(1) == '-')
                % python: sign_factor = -1 if sign == "+" else 1
                sign = offsetStr(1);
                hh = str2double(offsetStr(2:3));
                mm = str2double(offsetStr(5:6));
                if sign == '+'
                    signFactor = -1;
                else
                    signFactor = 1;
                end
                v = v + hours(hh * signFactor) + minutes(mm * signFactor);
            end
        end
    end

    methods (Static, Access = private)
        function uri = uriForLocal_(localName)
            CP = "http://schemas.openxmlformats.org/package/2006/metadata/core-properties";
            DC = "http://purl.org/dc/elements/1.1/";
            DCT = "http://purl.org/dc/terms/";
            switch localName
                case {"creator", "description", "identifier", "language", "subject", "title"}
                    uri = DC;
                case {"created", "modified"}
                    uri = DCT;
                otherwise
                    % category, keywords, lastModifiedBy, revision, version, lastPrinted, ...
                    uri = CP;
            end
        end
    end
end
