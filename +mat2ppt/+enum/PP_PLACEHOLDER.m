classdef PP_PLACEHOLDER
%PP_PLACEHOLDER  Alias of mat2ppt.enum.PP_PLACEHOLDER_TYPE.
%
%   Ported from python-pptx 1.0.2: PP_PLACEHOLDER = PP_PLACEHOLDER_TYPE

    properties (Constant)
        BITMAP = mat2ppt.enum.PP_PLACEHOLDER_TYPE.BITMAP
        BODY = mat2ppt.enum.PP_PLACEHOLDER_TYPE.BODY
        CENTER_TITLE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.CENTER_TITLE
        CHART = mat2ppt.enum.PP_PLACEHOLDER_TYPE.CHART
        DATE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.DATE
        FOOTER = mat2ppt.enum.PP_PLACEHOLDER_TYPE.FOOTER
        HEADER = mat2ppt.enum.PP_PLACEHOLDER_TYPE.HEADER
        MEDIA_CLIP = mat2ppt.enum.PP_PLACEHOLDER_TYPE.MEDIA_CLIP
        OBJECT = mat2ppt.enum.PP_PLACEHOLDER_TYPE.OBJECT
        ORG_CHART = mat2ppt.enum.PP_PLACEHOLDER_TYPE.ORG_CHART
        PICTURE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.PICTURE
        SLIDE_IMAGE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.SLIDE_IMAGE
        SLIDE_NUMBER = mat2ppt.enum.PP_PLACEHOLDER_TYPE.SLIDE_NUMBER
        SUBTITLE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.SUBTITLE
        TABLE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.TABLE
        TITLE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.TITLE
        VERTICAL_BODY = mat2ppt.enum.PP_PLACEHOLDER_TYPE.VERTICAL_BODY
        VERTICAL_OBJECT = mat2ppt.enum.PP_PLACEHOLDER_TYPE.VERTICAL_OBJECT
        VERTICAL_TITLE = mat2ppt.enum.PP_PLACEHOLDER_TYPE.VERTICAL_TITLE
        MIXED = mat2ppt.enum.PP_PLACEHOLDER_TYPE.MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.PP_PLACEHOLDER_TYPE.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.PP_PLACEHOLDER_TYPE.to_xml(value);
        end
    end
end
