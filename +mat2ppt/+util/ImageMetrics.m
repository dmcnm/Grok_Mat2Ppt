classdef ImageMetrics
%IMAGEMETRICS  File-based image size/DPI without Pillow (P7-W4).
%
%   m = mat2ppt.util.ImageMetrics.from_file(path)
%   m.width_px, m.height_px, m.horz_dpi, m.vert_dpi
%   m.width_emu, m.height_emu, m.ext, m.content_type
%
%   Ported intent from python-pptx Image._pil_props / ImagePart._native_size
%   using MATLAB imfinfo only.

    properties (SetAccess = private)
        width_px (1,1) double = 0
        height_px (1,1) double = 0
        horz_dpi (1,1) double = 72
        vert_dpi (1,1) double = 72
        width_emu (1,1) int64 = int64(0)
        height_emu (1,1) int64 = int64(0)
        ext (1,1) string = ""
        content_type (1,1) string = ""
        path (1,1) string = ""
    end

    methods (Static)
        function m = from_file(imagePath)
            arguments
                imagePath
            end
            imagePath = char(string(imagePath));
            [cx, cy, ext, ct] = mat2ppt.util.image_size_emu(imagePath);
            info = imfinfo(imagePath);
            m = mat2ppt.util.ImageMetrics();
            m.path = string(imagePath);
            m.width_px = double(info.Width);
            m.height_px = double(info.Height);
            m.width_emu = cx;
            m.height_emu = cy;
            m.ext = string(ext);
            m.content_type = string(ct);
            % recompute dpi for surface (match image_size_emu defaults)
            horzDpi = 72;
            vertDpi = 72;
            if isfield(info, "XResolution") && ~isempty(info.XResolution) && info.XResolution > 0
                horzDpi = double(info.XResolution);
                if isfield(info, "ResolutionUnit") && ...
                        strcmpi(char(string(info.ResolutionUnit)), "centimeter")
                    horzDpi = horzDpi * 2.54;
                end
            end
            if isfield(info, "YResolution") && ~isempty(info.YResolution) && info.YResolution > 0
                vertDpi = double(info.YResolution);
                if isfield(info, "ResolutionUnit") && ...
                        strcmpi(char(string(info.ResolutionUnit)), "centimeter")
                    vertDpi = vertDpi * 2.54;
                end
            end
            if horzDpi < 1 || horzDpi > 2048, horzDpi = 72; end
            if vertDpi < 1 || vertDpi > 2048, vertDpi = 72; end
            m.horz_dpi = horzDpi;
            m.vert_dpi = vertDpi;
        end
    end
end
