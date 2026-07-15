classdef FontFileInfo
%FONTFILEINFO  Minimal TTF/OTF name + style reader (python-pptx _Font subset).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/fonts.py::_Font
%   Reads 'name' and 'head' tables only for family_name / is_bold / is_italic.

    properties (SetAccess = private)
        family_name (1,1) string = ""
        is_bold (1,1) logical = false
        is_italic (1,1) logical = false
        path (1,1) string = ""
    end

    methods (Static)
        function info = open(filePath)
            filePath = char(string(filePath));
            fid = fopen(filePath, "r", "b");
            if fid < 0
                error("mat2ppt:IOError", "Cannot open font %s", filePath);
            end
            cleaner = onCleanup(@() fclose(fid));
            info = mat2ppt.text.FontFileInfo();
            info.path = string(filePath);
            % sfnt header
            scaler = fread(fid, 1, "uint32", 0, "b");
            numTables = fread(fid, 1, "uint16", 0, "b");
            fread(fid, 3, "uint16", 0, "b"); %#ok<NASGU> searchRange etc.
            tables = containers.Map("KeyType", "char", "ValueType", "any");
            for i = 1:numTables
                tag = char(fread(fid, 4, "uint8")');
                fread(fid, 1, "uint32", 0, "b"); % checksum
                offset = fread(fid, 1, "uint32", 0, "b");
                length = fread(fid, 1, "uint32", 0, "b");
                tables(tag) = [offset, length];
            end
            if isKey(tables, "head")
                off = tables("head");
                fseek(fid, off(1) + 44, "bof"); % macStyle at offset 44 in head
                macStyle = fread(fid, 1, "uint16", 0, "b");
                info.is_bold = bitand(macStyle, 1) ~= 0;
                info.is_italic = bitand(macStyle, 2) ~= 0;
            end
            if isKey(tables, "name")
                info.family_name = mat2ppt.text.FontFileInfo.readFamily_(fid, tables("name"));
            else
                [~, base, ~] = fileparts(filePath);
                info.family_name = string(base);
            end
        end
    end

    methods (Static, Access = private)
        function name = readFamily_(fid, offLen)
            offset = offLen(1);
            fseek(fid, offset, "bof");
            fread(fid, 1, "uint16", 0, "b"); % format
            count = fread(fid, 1, "uint16", 0, "b");
            stringOffset = fread(fid, 1, "uint16", 0, "b");
            best = "";
            for i = 1:count
                platformID = fread(fid, 1, "uint16", 0, "b");
                encodingID = fread(fid, 1, "uint16", 0, "b"); %#ok<NASGU>
                languageID = fread(fid, 1, "uint16", 0, "b"); %#ok<NASGU>
                nameID = fread(fid, 1, "uint16", 0, "b");
                length = fread(fid, 1, "uint16", 0, "b");
                strOff = fread(fid, 1, "uint16", 0, "b");
                if nameID ~= 1  % Font Family name
                    continue
                end
                pos = ftell(fid);
                fseek(fid, offset + stringOffset + strOff, "bof");
                raw = fread(fid, length, "uint8");
                fseek(fid, pos, "bof");
                if platformID == 0 || platformID == 3
                    % UTF-16BE
                    if mod(numel(raw), 2) == 1
                        raw = raw(1:end-1);
                    end
                    s = native2unicode(uint8(raw(:))', "UTF-16BE");
                else
                    s = char(raw(:)');
                end
                best = string(s);
                if platformID == 3
                    break
                end
            end
            if strlength(best) == 0
                name = "Unknown";
            else
                name = best;
            end
        end
    end
end
