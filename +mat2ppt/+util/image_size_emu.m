function [cx, cy, ext, contentType] = image_size_emu(imagePath)
%IMAGE_SIZE_EMU  Native image size in EMU via MATLAB imfinfo (no Pillow).
%
%   [cx, cy, ext, contentType] = mat2ppt.util.image_size_emu(path)
%   P7-W3 / P7-W4 image metrics path.

    imagePath = char(string(imagePath));
    if ~isfile(imagePath)
        error("mat2ppt:PackageNotFoundError", "Image not found: %s", imagePath);
    end
    info = imfinfo(imagePath);
    wPx = double(info.Width);
    hPx = double(info.Height);
    horzDpi = 72;
    vertDpi = 72;
    if isfield(info, "XResolution") && ~isempty(info.XResolution) && info.XResolution > 0
        horzDpi = double(info.XResolution);
        if isfield(info, "ResolutionUnit") && strcmpi(char(string(info.ResolutionUnit)), "centimeter")
            horzDpi = horzDpi * 2.54;
        end
    end
    if isfield(info, "YResolution") && ~isempty(info.YResolution) && info.YResolution > 0
        vertDpi = double(info.YResolution);
        if isfield(info, "ResolutionUnit") && strcmpi(char(string(info.ResolutionUnit)), "centimeter")
            vertDpi = vertDpi * 2.54;
        end
    end
    if horzDpi < 1 || horzDpi > 2048, horzDpi = 72; end
    if vertDpi < 1 || vertDpi > 2048, vertDpi = 72; end

    EMU_PER_INCH = 914400;
    cx = int64(floor(EMU_PER_INCH * wPx / horzDpi));
    cy = int64(floor(EMU_PER_INCH * hPx / vertDpi));

    [~, ~, e] = fileparts(imagePath);
    if ~isempty(e) && e(1) == "."
        e = e(2:end);
    end
    ext = lower(e);
    switch ext
        case {"jpg", "jpeg", "jpe"}
            ext = "jpg";
            contentType = "image/jpeg";
        case "png"
            contentType = "image/png";
        case "gif"
            contentType = "image/gif";
        case {"tif", "tiff"}
            ext = "tiff";
            contentType = "image/tiff";
        case "bmp"
            contentType = "image/bmp";
        otherwise
            contentType = "application/octet-stream";
    end
end
