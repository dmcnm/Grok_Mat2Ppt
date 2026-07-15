classdef Part < handle
%PART  Package part base (blob payload).
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/package.py::Part

    properties (Access = protected)
        partname_      % PackURI or char path with leading /
        contentType_
        package_
        blob_
    end

    methods
        function obj = Part(partname, contentType, package, blob)
            if nargin >= 1
                obj.partname_ = partname;
            end
            if nargin >= 2
                obj.contentType_ = char(string(contentType));
            end
            if nargin >= 3
                obj.package_ = package;
            end
            if nargin >= 4
                obj.blob_ = uint8(blob(:));
            else
                obj.blob_ = uint8([]);
            end
        end

        function b = blob(obj)
            b = obj.blob_;
        end

        function set_blob(obj, b)
            obj.blob_ = uint8(b(:));
        end

        function ct = content_type(obj)
            ct = obj.contentType_;
        end

        function p = partname(obj)
            p = obj.partname_;
        end

        function pkg = package(obj)
            pkg = obj.package_;
        end
    end

    methods (Static)
        function obj = load(partname, contentType, package, blob)
            obj = mat2ppt.opc.Part(partname, contentType, package, blob);
        end
    end
end
