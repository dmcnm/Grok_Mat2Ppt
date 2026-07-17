function [cx, cy, ext, contentType] = image_size_emu(imagePath)
%IMAGE_SIZE_EMU  Native image size in EMU via MATLAB imfinfo (no Pillow).
%
%   [cx, cy, ext, contentType] = mat2ppt.util.image_size_emu(path)
%   P7-W3 / P7-W4 image metrics path.
%   EMF/WMF and other formats imfinfo cannot read: returns placeholder size
%   (1" x 1") + correct content type so callers that pass explicit width/height
%   can still embed the blob (R recreation demos).

    imagePath = char(string(imagePath));
    if ~isfile(imagePath)
        error("mat2ppt:PackageNotFoundError", "Image not found: %s", imagePath);
    end

    [~, ~, e] = fileparts(imagePath);
    if ~isempty(e) && e(1) == "."
        e = e(2:end);
    end
    ext = lower(e);
    contentType = content_type_for_ext_(ext);

    EMU_PER_INCH = 914400;
    try
        info = imfinfo(imagePath);
        wPx = double(info.Width);
        hPx = double(info.Height);
        if ~(isfinite(wPx) && isfinite(hPx) && wPx > 0 && hPx > 0)
            error("mat2ppt:ImageMetrics", "non-positive image size");
        end
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
        cx = int64(floor(EMU_PER_INCH * wPx / horzDpi));
        cy = int64(floor(EMU_PER_INCH * hPx / vertDpi));
    catch
        % EMF/WMF/unknown: placeholder native size (callers usually pass explicit size)
        cx = int64(EMU_PER_INCH);
        cy = int64(EMU_PER_INCH);
    end

    switch ext
        case {"jpg", "jpeg", "jpe"}
            ext = "jpg";
    end
end

function contentType = content_type_for_ext_(ext)
    switch lower(char(string(ext)))
        case {"jpg", "jpeg", "jpe"}
            contentType = "image/jpeg";
        case "png"
            contentType = "image/png";
        case "gif"
            contentType = "image/gif";
        case {"tif", "tiff"}
            contentType = "image/tiff";
        case "bmp"
            contentType = "image/bmp";
        case "emf"
            contentType = "image/x-emf";
        case "wmf"
            contentType = "image/x-wmf";
        otherwise
            contentType = "application/octet-stream";
    end
end
