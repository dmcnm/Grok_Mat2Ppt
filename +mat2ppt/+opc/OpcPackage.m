classdef OpcPackage < handle
%OPCPACKAGE  OPC package open/save (python-pptx opc.package.OpcPackage subset).
%
%   pkg = mat2ppt.opc.OpcPackage.open(path)
%   pkg.save(path)
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/package.py::OpcPackage
%   M1-focused: load parts, re-serialize XmlPart content types on save.

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
            for i = 1:numel(keys)
                member = keys{i};
                partname = "/" + string(member);
                ct = mat2ppt.opc.content_type_for_part(partname, obj.defaults_, obj.overrides_);
                isRels = endsWith(string(member), ".rels");
                isCT = strcmp(member, "[Content_Types].xml");

                if isKey(obj.xmlParts_, char(partname))
                    % XmlPart: re-serialize element
                    elm = obj.xmlParts_(char(partname));
                    outMap(member) = mat2ppt.oxml.serialize_part_xml(elm);
                elseif isRels || isCT
                    % parse+serialize relationship and content-types streams
                    % (python regenerates these; we re-serialize loaded tree)
                    if isKey(obj.xmlParts_, char(partname))
                        outMap(member) = mat2ppt.oxml.serialize_part_xml(obj.xmlParts_(char(partname)));
                    else
                        try
                            elm = mat2ppt.oxml.parse_xml(obj.blobMap_(member));
                            outMap(member) = mat2ppt.oxml.serialize_part_xml(elm);
                        catch
                            outMap(member) = obj.blobMap_(member);
                        end
                    end
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
