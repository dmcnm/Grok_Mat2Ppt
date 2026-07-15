function s = default_content_types_()
%DEFAULT_CONTENT_TYPES_  Set of (ext, contentType) pairs from python-pptx opc.spec.
%
%   Returns containers.Map with keys "ext|contentType" -> true

    persistent cache
    if ~isempty(cache)
        s = cache;
        return
    end
    pairs = {
        'bin', 'application/vnd.openxmlformats-officedocument.presentationml.printerSettings'
        'bin', 'application/vnd.openxmlformats-officedocument.spreadsheetml.printerSettings'
        'bin', 'application/vnd.openxmlformats-officedocument.wordprocessingml.printerSettings'
        'bmp', 'image/bmp'
        'emf', 'image/x-emf'
        'fntdata', 'application/x-fontdata'
        'gif', 'image/gif'
        'jpe', 'image/jpeg'
        'jpeg', 'image/jpeg'
        'jpg', 'image/jpeg'
        'mov', 'video/quicktime'
        'mp4', 'video/mp4'
        'mpg', 'video/mpeg'
        'png', 'image/png'
        'rels', 'application/vnd.openxmlformats-package.relationships+xml'
        'tif', 'image/tiff'
        'tiff', 'image/tiff'
        'vid', 'video/unknown'
        'wdp', 'image/vnd.ms-photo'
        'wmf', 'image/x-wmf'
        'wmv', 'video/x-ms-wmv'
        'xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        'xml', 'application/xml'
        };
    s = containers.Map("KeyType", "char", "ValueType", "logical");
    for i = 1:size(pairs, 1)
        k = sprintf("%s|%s", pairs{i, 1}, pairs{i, 2});
        s(k) = true;
    end
    cache = s;
end
