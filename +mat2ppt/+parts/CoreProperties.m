classdef CoreProperties < handle
%COREPROPERTIES  Dublin Core package metadata (/docProps/core.xml).
%
%   Ported from python-pptx 1.0.2: parts/coreprops.py + oxml/coreprops text API
%   (without full xmlchemy engine).

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
                if isnan(v), v = 0; end
            end
        end
        function set.revision(obj, v)
            obj.setText_("revision", string(round(double(v))));
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
            kids = obj.elm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    if strlength(value) == 0
                        kids{i}.text = [];
                    else
                        kids{i}.text = char(value);
                    end
                    return
                end
            end
            uri = mat2ppt.parts.CoreProperties.uriForLocal_(localName);
            child = mat2ppt.oxml.XmlElement(sprintf("{%s}%s", uri, localName));
            if strlength(value) > 0
                child.text = char(value);
            end
            obj.elm_.append(child);
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
                    uri = CP;
            end
        end
    end
end
