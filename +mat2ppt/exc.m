classdef exc
%EXC  Exception factory helpers (python-pptx pptx.exc twin).
%
%   Prefer error("mat2ppt:PackageNotFoundError", ...) IDs; this class
%   documents the public error ID surface.
%
%   Ported from python-pptx 1.0.2: src/pptx/exc.py

    properties (Constant)
        PackageNotFoundError = "mat2ppt:PackageNotFoundError"
        InvalidXmlError = "mat2ppt:InvalidXmlError"
        ArgumentError = "mat2ppt:ArgumentError"
        ValueError = "mat2ppt:ValueError"
        TypeError = "mat2ppt:TypeError"
        IndexOutOfRange = "mat2ppt:IndexOutOfRange"
    end

    methods (Static)
        function throw_package_not_found(path)
            error(mat2ppt.exc.PackageNotFoundError, ...
                "Package not found at '%s'.", path);
        end

        function throw_invalid_xml(msg)
            error(mat2ppt.exc.InvalidXmlError, "%s", msg);
        end
    end
end
