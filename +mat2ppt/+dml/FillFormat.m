classdef FillFormat < handle
%FILLFORMAT  Fill properties API surface.
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/fill.py::FillFormat (P5-W11 live)

    properties (Access = private)
        parentElm_ = []
        type_ = []
        solidElm_ = []
        foreRgb_ = []
    end

    methods
        function obj = FillFormat(parentElm)
            if nargin >= 1
                obj.parentElm_ = parentElm;
            end
        end

        function t = type(obj)
            t = obj.type_;
        end

        function solid(obj)
            obj.type_ = mat2ppt.enum.MSO_FILL.SOLID;
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            if ~isempty(obj.parentElm_) && isvalid(obj.parentElm_)
                kids = obj.parentElm_.getchildren();
                for i = numel(kids):-1:1
                    ln = char(kids{i}.localName());
                    if any(strcmp(ln, {"noFill","solidFill","gradFill","blipFill","pattFill","grpFill"}))
                        obj.parentElm_.remove(kids{i});
                    end
                end
                sf = mat2ppt.oxml.dml.CT_SolidColorFillProperties(sprintf("{%s}solidFill", A));
                obj.parentElm_.append(sf);
                obj.solidElm_ = sf;
            else
                % shell mode (no XML parent): keep a private solidFill element
                obj.solidElm_ = mat2ppt.oxml.dml.CT_SolidColorFillProperties(sprintf("{%s}solidFill", A));
            end
        end

        function background(obj)
            obj.type_ = mat2ppt.enum.MSO_FILL.BACKGROUND;
            if ~isempty(obj.parentElm_) && isvalid(obj.parentElm_)
                kids = obj.parentElm_.getchildren();
                for i = numel(kids):-1:1
                    ln = char(kids{i}.localName());
                    if any(strcmp(ln, {"noFill","solidFill","gradFill","blipFill","pattFill","grpFill"}))
                        obj.parentElm_.remove(kids{i});
                    end
                end
                nf = mat2ppt.oxml.OxmlElement("a:noFill");
                obj.parentElm_.append(nf);
            end
        end

        function c = fore_color(obj)
            %FORE_COLOR  ColorFormat on solidFill (creates solid if needed).
            if isempty(obj.solidElm_) || ~isvalid(obj.solidElm_)
                obj.solid();
            end
            c = mat2ppt.dml.ColorFormat.from_colorchoice_parent(obj.solidElm_);
        end

        function c = fore_color_rgb(obj)
            c = obj.foreRgb_;
            try
                c = obj.fore_color().rgb;
            catch
            end
        end

        function set_fore_color_rgb(obj, rgb)
            arguments
                obj
                rgb (1,1) mat2ppt.dml.RGBColor
            end
            obj.fore_color().rgb = rgb;
            obj.foreRgb_ = rgb;
        end
    end

    methods (Static)
        function f = from_fill_parent(parentElm)
            f = mat2ppt.dml.FillFormat(parentElm);
        end
    end
end

