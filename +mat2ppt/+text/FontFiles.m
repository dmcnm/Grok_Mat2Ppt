classdef FontFiles
%FONTFILES  Font file lookup (B1: file-based; no silent OS font invention for L1).
%
%   find(family, bold, italic) looks up a path previously registered or
%   discovered under optional search directories.
%
%   Ported from python-pptx 1.0.2: src/pptx/text/fonts.py::FontFiles
%   Policy: design §7.12 / docs/font_metrics.md — prefer explicit file paths.

    methods (Static)
        function path = find(familyName, isBold, isItalic)
            %FIND  Absolute path to a registered/discovered font file.
            arguments
                familyName
                isBold (1,1) logical
                isItalic (1,1) logical
            end
            cache = mat2ppt.text.FontFiles.cache_();
            key = mat2ppt.text.FontFiles.key_(familyName, isBold, isItalic);
            if isKey(cache, key)
                path = cache(key);
                return
            end
            error("mat2ppt:KeyError", ...
                "No font file registered for family='%s' bold=%d italic=%d. " + ...
                "Call FontFiles.register or FontFiles.discover_in.", ...
                familyName, isBold, isItalic);
        end

        function register(familyName, isBold, isItalic, filePath)
            %REGISTER  Explicit mapping (preferred for oracle-parity tests).
            arguments
                familyName
                isBold (1,1) logical
                isItalic (1,1) logical
                filePath
            end
            filePath = char(string(filePath));
            if ~isfile(filePath)
                error("mat2ppt:PackageNotFoundError", "Font file not found: %s", filePath);
            end
            cache = mat2ppt.text.FontFiles.cache_();
            key = mat2ppt.text.FontFiles.key_(familyName, isBold, isItalic);
            cache(key) = filePath; %#ok<NASGU>
        end

        function n = discover_in(directory)
            %DISCOVER_IN  Scan a directory for .ttf/.otf and register by family/style.
            % Returns count of fonts registered. Does not invent metrics.
            arguments
                directory
            end
            directory = char(string(directory));
            if ~isfolder(directory)
                error("mat2ppt:PackageNotFoundError", "Not a directory: %s", directory);
            end
            n = 0;
            listing = dir(fullfile(directory, "**", "*.ttf"));
            listing = [listing; dir(fullfile(directory, "**", "*.otf"))];
            listing = [listing; dir(fullfile(directory, "**", "*.TTF"))];
            listing = [listing; dir(fullfile(directory, "**", "*.OTF"))];
            for i = 1:numel(listing)
                if listing(i).isdir, continue; end
                path = fullfile(listing(i).folder, listing(i).name);
                try
                    info = mat2ppt.text.FontFileInfo.open(path);
                    mat2ppt.text.FontFiles.register(info.family_name, info.is_bold, info.is_italic, path);
                    n = n + 1;
                catch
                    % skip unreadable fonts
                end
            end
        end

        function clear()
            %CLEAR  Drop the in-memory cache (tests).
            mat2ppt.text.FontFiles.cache_(true);
        end
    end

    methods (Static, Access = private)
        function c = cache_(reset)
            persistent map
            if nargin >= 1 && reset
                map = containers.Map("KeyType", "char", "ValueType", "char");
            end
            if isempty(map)
                map = containers.Map("KeyType", "char", "ValueType", "char");
            end
            c = map;
        end

        function k = key_(familyName, isBold, isItalic)
            k = sprintf("%s|%d|%d", char(string(familyName)), isBold, isItalic);
        end
    end
end
