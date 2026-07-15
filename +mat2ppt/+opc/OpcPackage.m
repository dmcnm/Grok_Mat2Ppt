classdef OpcPackage < handle
%OPCPACKAGE  OPC package open/save (python-pptx opc.package.OpcPackage subset).
%
%   pkg = mat2ppt.opc.OpcPackage.open(path)
%   pkg.save(path)
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/package.py::OpcPackage
%   M1: load parts; on save re-serialize XmlParts, regenerate CT + .rels.

    properties (Access = private)
        blobMap_   % membername -> uint8
        defaults_  % ext -> ct
        overrides_ % partname -> ct
        xmlParts_  % containers.Map partname -> XmlElement (for re-serialize)
    end

    methods (Static)
        function pkg = open(pkg_file)
            pkg = mat2ppt.opc.OpcPackage();
            pkg.load_(pkg_file);
        end
    end

    methods
        function save(obj, pkg_file)
            outMap = containers.Map("KeyType", "char", "ValueType", "any");
            keys = obj.blobMap_.keys;

            % Build part list + content types for CT regeneration
            partNames = {};
            partCTs = containers.Map("KeyType", "char", "ValueType", "char");
            for i = 1:numel(keys)
                member = keys{i};
                if strcmp(member, "[Content_Types].xml")
                    continue
                end
                if endsWith(string(member), ".rels")
                    continue
                end
                partname = char("/" + string(member));
                partNames{end+1} = partname; %#ok<AGROW>
                ct = mat2ppt.opc.content_type_for_part(partname, obj.defaults_, obj.overrides_);
                partCTs(partname) = char(string(ct));
            end
            outMap("[Content_Types].xml") = mat2ppt.opc.build_content_types_xml_(partNames, partCTs);

            for i = 1:numel(keys)
                member = keys{i};
                if strcmp(member, "[Content_Types].xml")
                    continue
                end
                partname = char("/" + string(member));
                isRels = endsWith(string(member), ".rels");

                if isRels
                    if isKey(obj.xmlParts_, partname)
                        outMap(member) = mat2ppt.opc.serialize_rels_sorted_(obj.xmlParts_(partname));
                    else
                        try
                            elm = mat2ppt.oxml.parse_xml(obj.blobMap_(member));
                            outMap(member) = mat2ppt.opc.serialize_rels_sorted_(elm);
                        catch
                            outMap(member) = obj.blobMap_(member);
                        end
                    end
                elseif isKey(obj.xmlParts_, partname)
                    elm = obj.xmlParts_(partname);
                    outMap(member) = mat2ppt.oxml.serialize_part_xml(elm);
                else
                    outMap(member) = obj.blobMap_(member);
                end
            end
            mat2ppt.opc.write_zip_blobs(pkg_file, outMap);
        end

        function parts = list_partnames(obj)
            keys = obj.blobMap_.keys;
            parts = strings(0);
            for i = 1:numel(keys)
                m = keys{i};
                if strcmp(m, "[Content_Types].xml"), continue; end
                if endsWith(string(m), ".rels"), continue; end
                parts(end+1) = "/" + string(m); %#ok<AGROW>
            end
        end

        function elm = xml_part_element(obj, partname)
            %XML_PART_ELEMENT  Parsed XmlElement for partname, or [].
            pn = char(string(partname));
            if isKey(obj.xmlParts_, pn)
                elm = obj.xmlParts_(pn);
            else
                elm = [];
            end
        end

        function replace_xml_part(obj, partname, elm)
            %REPLACE_XML_PART  Update in-memory XML part (for CoreProperties edits).
            arguments
                obj
                partname
                elm (1,1) mat2ppt.oxml.XmlElement
            end
            pn = char(string(partname));
            obj.xmlParts_(pn) = elm;
            % keep blobMap member name in sync for inventory
            member = pn;
            if startsWith(string(member), "/")
                member = member(2:end);
            end
            obj.blobMap_(member) = mat2ppt.oxml.serialize_part_xml(elm);
        end

        function add_xml_part(obj, partname, elm, contentType)
            %ADD_XML_PART  Insert/replace XML part and content-type override (P6-W3).
            arguments
                obj
                partname
                elm (1,1) mat2ppt.oxml.XmlElement
                contentType
            end
            pn = char(string(partname));
            if ~startsWith(string(pn), "/")
                pn = ["/" + string(pn)];
                pn = char(pn);
            end
            obj.replace_xml_part(pn, elm);
            obj.overrides_(pn) = char(string(contentType));
        end

        function rId = add_relationship(obj, sourcePartname, reltype, targetPartname)
            %ADD_RELATIONSHIP  Internal rel from source to target; returns rId.
            arguments
                obj
                sourcePartname
                reltype
                targetPartname
            end
            src = char(string(sourcePartname));
            tgt = char(string(targetPartname));
            srcPu = mat2ppt.opc.PackURI(src);
            relsPn = char(srcPu.rels_uri);
            relsElm = obj.xml_part_element(relsPn);
            if isempty(relsElm)
                PR = "http://schemas.openxmlformats.org/package/2006/relationships";
                relsElm = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationships", PR));
                relsElm.setNsDecls({"", PR});
            end
            rId = mat2ppt.opc.next_rId_(relsElm);
            targetRef = mat2ppt.opc.relative_pack_ref(src, tgt);
            PR = "http://schemas.openxmlformats.org/package/2006/relationships";
            rel = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationship", PR));
            rel.set("Id", rId);
            rel.set("Type", char(string(reltype)));
            rel.set("Target", targetRef);
            relsElm.append(rel);
            obj.replace_xml_part(relsPn, relsElm);
        end

        function rId = add_external_relationship(obj, sourcePartname, reltype, targetUrl)
            %ADD_EXTERNAL_RELATIONSHIP  External TargetMode rel (e.g. hyperlink URL).
            arguments
                obj
                sourcePartname
                reltype
                targetUrl
            end
            src = char(string(sourcePartname));
            srcPu = mat2ppt.opc.PackURI(src);
            relsPn = char(srcPu.rels_uri);
            relsElm = obj.xml_part_element(relsPn);
            if isempty(relsElm)
                PR = "http://schemas.openxmlformats.org/package/2006/relationships";
                relsElm = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationships", PR));
                relsElm.setNsDecls({"", PR});
            end
            rId = mat2ppt.opc.next_rId_(relsElm);
            PR = "http://schemas.openxmlformats.org/package/2006/relationships";
            rel = mat2ppt.oxml.XmlElement(sprintf("{%s}Relationship", PR));
            rel.set("Id", rId);
            rel.set("Type", char(string(reltype)));
            rel.set("Target", char(string(targetUrl)));
            rel.set("TargetMode", "External");
            relsElm.append(rel);
            obj.replace_xml_part(relsPn, relsElm);
        end

        function url = external_target(obj, sourcePartname, rId)
            %EXTERNAL_TARGET  Target URL of External relationship, or [].
            src = mat2ppt.opc.PackURI(char(string(sourcePartname)));
            relsElm = obj.xml_part_element(char(src.rels_uri));
            url = [];
            if isempty(relsElm), return; end
            rId = char(string(rId));
            kids = relsElm.getchildren();
            for i = 1:numel(kids)
                el = kids{i};
                if ~strcmp(char(el.localName()), "Relationship"), continue; end
                if ~strcmp(char(string(el.get("Id"))), rId), continue; end
                url = char(string(el.get("Target")));
                return
            end
        end
    end

    methods (Access = private)
        function load_(obj, pkg_file)
            obj.blobMap_ = mat2ppt.opc.read_zip_blobs(pkg_file);
            if ~isKey(obj.blobMap_, "[Content_Types].xml")
                error("mat2ppt:InvalidPackage", "Missing [Content_Types].xml");
            end
            [obj.defaults_, obj.overrides_] = mat2ppt.opc.parse_content_types( ...
                obj.blobMap_("[Content_Types].xml"));
            obj.xmlParts_ = containers.Map("KeyType", "char", "ValueType", "any");

            keys = obj.blobMap_.keys;
            for i = 1:numel(keys)
                member = keys{i};
                partname = char("/" + string(member));
                blob = obj.blobMap_(member);
                isRels = endsWith(string(member), ".rels");
                isCT = strcmp(member, "[Content_Types].xml");
                ct = mat2ppt.opc.content_type_for_part(partname, obj.defaults_, obj.overrides_);

                if isCT || isRels || mat2ppt.opc.is_xml_part_content_type(ct)
                    try
                        elm = mat2ppt.oxml.parse_xml(blob);
                        obj.xmlParts_(partname) = elm;
                    catch
                        % leave as opaque blob
                    end
                end
            end
        end
    end
end
