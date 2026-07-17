classdef ColorFormat < handle
%COLORFORMAT  Color settings (RGB / theme / brightness) on a color-choice parent.
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/color.py::ColorFormat (R2-W4)

    properties (Access = private)
        parentElm_  % element that may contain a:srgbClr / a:schemeClr
    end

    properties (Dependent)
        rgb
        theme_color
        brightness
    end

    methods
        function obj = ColorFormat(parentElm)
            arguments
                parentElm (1,1) mat2ppt.oxml.XmlElement
            end
            obj.parentElm_ = parentElm;
        end

        function t = type(obj)
            if ~isempty(obj.find_child_("srgbClr"))
                t = mat2ppt.enum.MSO_COLOR_TYPE.RGB;
            elseif ~isempty(obj.find_child_("schemeClr"))
                t = mat2ppt.enum.MSO_COLOR_TYPE.SCHEME;
            else
                t = [];
            end
        end

        function c = get.rgb(obj)
            srgb = obj.find_child_("srgbClr");
            if isempty(srgb)
                error("mat2ppt:AttributeError", "no .rgb property on this color type");
            end
            raw = srgb.get("val");
            c = mat2ppt.dml.RGBColor.from_string(raw);
        end

        function set.rgb(obj, rgb)
            arguments
                obj
                rgb (1,1) mat2ppt.dml.RGBColor
            end
            obj.clear_color_children_();
            srgb = mat2ppt.oxml.dml.CT_SRgbColor.new(char(rgb.hex));
            obj.parentElm_.append(srgb);
        end

        function tc = get.theme_color(obj)
            scheme = obj.find_child_("schemeClr");
            if isempty(scheme)
                error("mat2ppt:AttributeError", "no .theme_color property on this color type");
            end
            raw = scheme.get("val");
            if mat2ppt.isAbsent(raw)
                tc = mat2ppt.enum.MSO_THEME_COLOR.NOT_THEME_COLOR;
            else
                tc = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(raw)));
            end
        end

        function set.theme_color(obj, themeColor)
            obj.clear_color_children_();
            scheme = mat2ppt.oxml.dml.CT_SchemeColor();
            xml = mat2ppt.enum.MSO_THEME_COLOR.to_xml(themeColor);
            scheme.set("val", char(string(xml)));
            obj.parentElm_.append(scheme);
        end

        function b = get.brightness(obj)
            %BRIGHTNESS  -1..1 luminance adjustment (0 if none).
            clr = obj.color_elm_();
            if isempty(clr)
                b = 0;
                return
            end
            lumOff = obj.find_under_(clr, "lumOff");
            lumMod = obj.find_under_(clr, "lumMod");
            if ~isempty(lumOff)
                b = mat2ppt.dml.ColorFormat.pct_from_xml_(lumOff.get("val"));
            elseif ~isempty(lumMod)
                b = mat2ppt.dml.ColorFormat.pct_from_xml_(lumMod.get("val")) - 1.0;
            else
                b = 0;
            end
        end

        function set.brightness(obj, value)
            value = double(value);
            if value < -1.0 || value > 1.0
                error("mat2ppt:ValueError", "brightness must be number in range -1.0 to 1.0");
            end
            clr = obj.color_elm_();
            if isempty(clr)
                error("mat2ppt:ValueError", ...
                    "can't set brightness when color.type is None. Set color.rgb or .theme_color first.");
            end
            mat2ppt.dml.ColorFormat.clear_lum_(clr);
            if value > 0
                % tint: lumMod = 1-value, lumOff = value
                mat2ppt.dml.ColorFormat.add_lum_(clr, "lumMod", 1.0 - value);
                mat2ppt.dml.ColorFormat.add_lum_(clr, "lumOff", value);
            elseif value < 0
                % shade: lumMod = 1-|value|
                mat2ppt.dml.ColorFormat.add_lum_(clr, "lumMod", 1.0 - abs(value));
            end
        end
    end

    methods (Access = private)
        function el = find_child_(obj, localName)
            el = [];
            kids = obj.parentElm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    el = kids{i};
                    return
                end
            end
        end

        function clear_color_children_(obj)
            kids = obj.parentElm_.getchildren();
            for i = numel(kids):-1:1
                ln = char(kids{i}.localName());
                if any(strcmp(ln, {"srgbClr","schemeClr","scrgbClr","hslClr","sysClr","prstClr"}))
                    obj.parentElm_.remove(kids{i});
                end
            end
        end

        function clr = color_elm_(obj)
            names = {"srgbClr","schemeClr","scrgbClr","hslClr","sysClr","prstClr"};
            clr = [];
            for i = 1:numel(names)
                clr = obj.find_child_(names{i});
                if ~isempty(clr), return; end
            end
        end

        function el = find_under_(~, parent, localName)
            el = parent.find("a:" + string(localName));
            if ~isempty(el), return; end
            kids = parent.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    el = kids{i};
                    return
                end
            end
            el = [];
        end
    end

    methods (Static)
        function cf = from_colorchoice_parent(parentElm)
            cf = mat2ppt.dml.ColorFormat(parentElm);
        end

        function v = pct_from_xml_(raw)
            if mat2ppt.isAbsent(raw)
                v = 0;
                return
            end
            s = char(string(raw));
            if contains(s, "%")
                v = str2double(erase(s, "%")) / 100.0;
            else
                v = str2double(s) / 100000.0;
            end
        end

        function add_lum_(clrElm, localName, floatVal)
            el = mat2ppt.oxml.OxmlElement("a:" + string(localName));
            el.set("val", char(string(int64(round(floatVal * 100000.0)))));
            clrElm.append(el);
        end

        function clear_lum_(clrElm)
            % Remove by local name via childCount (handle-equality remove can miss).
            i = clrElm.childCount();
            while i >= 1
                kid = clrElm.child(i);
                ln = char(string(kid.localName()));
                if strcmp(ln, "lumMod") || strcmp(ln, "lumOff")
                    clrElm.remove(kid);
                end
                i = i - 1;
            end
        end
    end
end
