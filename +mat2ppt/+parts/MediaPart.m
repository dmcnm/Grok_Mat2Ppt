classdef MediaPart < mat2ppt.opc.Part
%MEDIAPART  Media part containing audio/video blob (R6-W1).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/media.py::MediaPart

    properties (Access = private)
        sha1_
    end

    methods
        function obj = MediaPart(partname, contentType, package, blob)
            obj@mat2ppt.opc.Part(partname, contentType, package, blob);
            if ~mat2ppt.isAbsent(blob) && ~isempty(blob)
                obj.sha1_ = mat2ppt.opc.sha1_hex_(uint8(blob(:)));
            else
                obj.sha1_ = "";
            end
        end

        function h = sha1(obj)
            h = obj.sha1_;
        end
    end

    methods (Static)
        function obj = load(partname, contentType, package, blob)
            obj = mat2ppt.parts.MediaPart(partname, contentType, package, blob);
        end

        function obj = new(package, media)
            %NEW  Create media part from Video (or media value object).
            arguments
                package
                media
            end
            ext = char(string(media.ext()));
            ct = char(string(media.content_type()));
            blob = media.blob();
            pn = mat2ppt.parts.MediaPart.next_media_partname_(package, ext);
            package.add_blob_part(pn, blob, ct);
            obj = mat2ppt.parts.MediaPart(pn, ct, package, blob);
        end

        function pn = next_media_partname_(pkg, ext)
            %NEXT_MEDIA_PARTNAME_  /ppt/media/mediaN.ext
            names = pkg.list_partnames();
            idxs = [];
            for i = 1:numel(names)
                tok = regexp(char(names(i)), "^/ppt/media/media(\d+)\.", "tokens", "once");
                if ~isempty(tok)
                    idxs(end+1) = str2double(tok{1}); %#ok<AGROW>
                end
            end
            n = 1;
            if ~isempty(idxs)
                for candidate = 1:(max(idxs) + 1)
                    if ~any(idxs == candidate)
                        n = candidate;
                        break
                    end
                end
            end
            pn = sprintf("/ppt/media/media%d.%s", n, char(string(ext)));
        end

        function mediaPn = get_or_add_media_partname(pkg, media)
            %GET_OR_ADD_MEDIA_PARTNAME  Reuse by SHA-1 or create; return partname.
            sha = char(string(media.sha1()));
            names = pkg.list_partnames();
            for i = 1:numel(names)
                pn = char(names(i));
                if isempty(regexp(pn, "^/ppt/media/media\d+\.", "once"))
                    continue
                end
                blob = pkg.get_blob(pn);
                if isempty(blob)
                    continue
                end
                if strcmp(mat2ppt.opc.sha1_hex_(blob), sha)
                    mediaPn = pn;
                    return
                end
            end
            mp = mat2ppt.parts.MediaPart.new(pkg, media);
            mediaPn = char(string(mp.partname()));
        end
    end
end
