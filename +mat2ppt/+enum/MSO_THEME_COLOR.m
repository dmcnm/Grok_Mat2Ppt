classdef MSO_THEME_COLOR
%MSO_THEME_COLOR  Alias of mat2ppt.enum.MSO_THEME_COLOR_INDEX.
%
%   Ported from python-pptx 1.0.2: MSO_THEME_COLOR = MSO_THEME_COLOR_INDEX

    properties (Constant)
        NOT_THEME_COLOR = mat2ppt.enum.MSO_THEME_COLOR_INDEX.NOT_THEME_COLOR
        ACCENT_1 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_1
        ACCENT_2 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_2
        ACCENT_3 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_3
        ACCENT_4 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_4
        ACCENT_5 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_5
        ACCENT_6 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_6
        BACKGROUND_1 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.BACKGROUND_1
        BACKGROUND_2 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.BACKGROUND_2
        DARK_1 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.DARK_1
        DARK_2 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.DARK_2
        FOLLOWED_HYPERLINK = mat2ppt.enum.MSO_THEME_COLOR_INDEX.FOLLOWED_HYPERLINK
        HYPERLINK = mat2ppt.enum.MSO_THEME_COLOR_INDEX.HYPERLINK
        LIGHT_1 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.LIGHT_1
        LIGHT_2 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.LIGHT_2
        TEXT_1 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.TEXT_1
        TEXT_2 = mat2ppt.enum.MSO_THEME_COLOR_INDEX.TEXT_2
        MIXED = mat2ppt.enum.MSO_THEME_COLOR_INDEX.MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.MSO_THEME_COLOR_INDEX.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.MSO_THEME_COLOR_INDEX.to_xml(value);
        end
    end
end
