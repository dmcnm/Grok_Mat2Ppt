classdef CT_Types < mat2ppt.oxml.BaseOxmlElement
%CT_TYPES  ct:Types content-types root.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::CT_Types

    methods
        function obj = CT_Types(tag)
            if nargin < 1, tag = "ct:Types"; end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function el = add_default(obj, ext, contentType)
            CT = "http://schemas.openxmlformats.org/package/2006/content-types";
            el = mat2ppt.oxml.CT_Default(sprintf("{%s}Default", CT));
            el.extension = ext;
            el.contentType = contentType;
            obj.append(el);
        end

        function el = add_override(obj, partName, contentType)
            CT = "http://schemas.openxmlformats.org/package/2006/content-types";
            el = mat2ppt.oxml.CT_Override(sprintf("{%s}Override", CT));
            el.partName = char(string(partName));
            el.contentType = contentType;
            obj.append(el);
        end
    end

    methods (Static)
        function obj = new()
            CT = "http://schemas.openxmlformats.org/package/2006/content-types";
            obj = mat2ppt.oxml.CT_Types(sprintf("{%s}Types", CT));
            obj.setNsDecls({"", CT});
        end
    end
end
