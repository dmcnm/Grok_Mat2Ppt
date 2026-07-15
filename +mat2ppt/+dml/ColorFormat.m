classdef ColorFormat < handle
%COLORFORMAT  Color settings (RGB / theme) on a color-choice parent.
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/color.py::ColorFormat (P5-W11)

    properties (Access = private)
        parentElm_  % element that may contain a:srgbClr / a:schemeClr
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
            % clear other colors, set srgb
            kids = obj.parentElm_.getchildren();
            for i = numel(kids):-1:1
                ln = char(kids{i}.localName());
                if any(strcmp(ln, {"srgbClr","schemeClr","scrgbClr","hslClr","sysClr","prstClr"}))
                    obj.parentElm_.remove(kids{i});
                end
            end
            srgb = mat2ppt.oxml.dml.CT_SRgbColor.new(char(rgb.hex));
            obj.parentElm_.append(srgb);
        end
    end

    properties (Dependent)
        rgb
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
    end

    methods (Static)
        function cf = from_colorchoice_parent(parentElm)
            cf = mat2ppt.dml.ColorFormat(parentElm);
        end
    end
end
