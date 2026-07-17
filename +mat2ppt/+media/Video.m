classdef Video < handle
%VIDEO  Immutable video blob value object (R6-W1).
%
%   Ported from python-pptx 1.0.2: src/pptx/media.py::Video

    properties (Access = private)
        blob_
        mimeType_
        filename_
        sha1_
    end

    methods
        function obj = Video(blob, mimeType, filename)
            arguments
                blob
                mimeType = mat2ppt.opc.CONTENT_TYPE.VIDEO
                filename = []
            end
            if ischar(blob) || isstring(blob)
                error("mat2ppt:ArgumentError", "use Video.from_path for file paths");
            end
            obj.blob_ = uint8(blob(:))';
            obj.mimeType_ = char(string(mimeType));
            if mat2ppt.isAbsent(filename)
                obj.filename_ = [];
            else
                obj.filename_ = char(string(filename));
            end
            obj.sha1_ = mat2ppt.opc.sha1_hex_(obj.blob_);
        end

        function b = blob(obj)
            b = obj.blob_;
        end

        function c = content_type(obj)
            c = obj.mimeType_;
        end

        function e = ext(obj)
            if ~isempty(obj.filename_)
                [~, ~, e] = fileparts(obj.filename_);
                e = char(erase(string(e), "."));
                if strlength(string(e)) > 0
                    return
                end
            end
            CT = mat2ppt.opc.CONTENT_TYPE;
            switch string(obj.mimeType_)
                case string(CT.MP4), e = "mp4";
                case string(CT.MOV), e = "mov";
                case string(CT.AVI), e = "avi";
                case string(CT.WMV), e = "wmv";
                case string(CT.MPG), e = "mpg";
                case string(CT.ASF), e = "asf";
                case string(CT.MS_VIDEO), e = "avi";
                case string(CT.X_MS_VIDEO), e = "avi";
                otherwise, e = "vid";
            end
        end

        function f = filename(obj)
            if ~isempty(obj.filename_)
                f = obj.filename_;
            else
                f = sprintf("movie.%s", obj.ext());
            end
        end

        function h = sha1(obj)
            h = obj.sha1_;
        end
    end

    methods (Static)
        function v = from_blob(blob, mimeType, filename)
            arguments
                blob
                mimeType = mat2ppt.opc.CONTENT_TYPE.VIDEO
                filename = []
            end
            v = mat2ppt.media.Video(blob, mimeType, filename);
        end

        function v = from_path(moviePath, mimeType)
            arguments
                moviePath
                mimeType = mat2ppt.opc.CONTENT_TYPE.VIDEO
            end
            moviePath = char(string(moviePath));
            fid = fopen(moviePath, "rb");
            if fid < 0
                error("mat2ppt:IOError", "Cannot open movie %s", moviePath);
            end
            cleaner = onCleanup(@() fclose(fid));
            blob = fread(fid, inf, "*uint8");
            [~, name, ext] = fileparts(moviePath);
            fname = [name, ext];
            v = mat2ppt.media.Video(blob, mimeType, fname);
        end
    end
end
