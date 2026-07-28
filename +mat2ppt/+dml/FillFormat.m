classdef FillFormat < handle
%FILLFORMAT  Fill properties API surface.
%
%   Ported from python-pptx 1.0.2: src/pptx/dml/fill.py::FillFormat (P5-W11 live)

    properties (Access = private)
        parentElm_ = []
        type_ = []
        solidElm_ = []
        pattElm_ = []
        foreRgb_ = []
    end

    methods
        function obj = FillFormat(parentElm)
            if nargin >= 1
                obj.parentElm_ = parentElm;
                obj.rehydrate_();
            end
        end

        function t = type(obj)
            if isempty(obj.type_)
                obj.rehydrate_();
            end
            t = obj.type_;
        end

        function solid(obj)
            obj.type_ = mat2ppt.enum.MSO_FILL.SOLID;
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            if ~isempty(obj.parentElm_) && isvalid(obj.parentElm_)
                kids = obj.parentElm_.getchildren();
                for i = numel(kids):-1:1
                    ln = char(kids{i}.localName());
                    if any(strcmp(ln, {'noFill','solidFill','gradFill','blipFill','pattFill','grpFill'}))
                        obj.parentElm_.remove(kids{i});
                    end
                end
                sf = mat2ppt.oxml.dml.CT_SolidColorFillProperties(sprintf("{%s}solidFill", A));
                % OOXML CT_TextCharacterProperties / CT_ShapeProperties: fill
                % elements must precede latin/ea/cs. Appending after latin
                % makes PowerPoint ignore solidFill (text stays black).
                idx = mat2ppt.dml.FillFormat.fill_insert_index_(obj.parentElm_);
                obj.parentElm_.insert(idx, sf);
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
                    if any(strcmp(ln, {'noFill','solidFill','gradFill','blipFill','pattFill','grpFill'}))
                        obj.parentElm_.remove(kids{i});
                    end
                end
                nf = mat2ppt.oxml.OxmlElement("a:noFill");
                obj.parentElm_.append(nf);
            end
        end

        function patterned(obj)
            %PATTERNED  Select pattern fill type (R2-W5).
            obj.type_ = mat2ppt.enum.MSO_FILL.PATTERNED;
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            if ~isempty(obj.parentElm_) && isvalid(obj.parentElm_)
                kids = obj.parentElm_.getchildren();
                for i = numel(kids):-1:1
                    ln = char(kids{i}.localName());
                    if any(strcmp(ln, {'noFill','solidFill','gradFill','blipFill','pattFill','grpFill'}))
                        obj.parentElm_.remove(kids{i});
                    end
                end
                pf = mat2ppt.oxml.OxmlElement(sprintf("{%s}pattFill", A));
                obj.parentElm_.append(pf);
                obj.solidElm_ = [];  % not solid
                obj.pattElm_ = pf;
            else
                obj.pattElm_ = mat2ppt.oxml.OxmlElement(sprintf("{%s}pattFill", A));
            end
        end

        function c = fore_color(obj)
            %FORE_COLOR  ColorFormat on solidFill or pattFill fgClr.
            if ~isempty(obj.pattElm_) && isvalid(obj.pattElm_)
                fg = obj.ensure_patt_fg_();
                c = mat2ppt.dml.ColorFormat.from_colorchoice_parent(fg);
                return
            end
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

    methods (Access = private)
        function rehydrate_(obj)
            if isempty(obj.parentElm_) || ~isvalid(obj.parentElm_)
                return
            end
            kids = obj.parentElm_.getchildren();
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                if strcmp(ln, 'solidFill')
                    obj.solidElm_ = kids{i};
                    obj.type_ = mat2ppt.enum.MSO_FILL.SOLID;
                    return
                elseif strcmp(ln, 'pattFill')
                    obj.pattElm_ = kids{i};
                    obj.type_ = mat2ppt.enum.MSO_FILL.PATTERNED;
                    return
                elseif strcmp(ln, 'noFill')
                    obj.type_ = mat2ppt.enum.MSO_FILL.BACKGROUND;
                    return
                end
            end
        end

        function fg = ensure_patt_fg_(obj)
            pf = obj.pattElm_;
            fg = pf.find("a:fgClr");
            if isempty(fg)
                kids = pf.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "fgClr")
                        fg = kids{i}; return
                    end
                end
            end
            if isempty(fg)
                fg = mat2ppt.oxml.OxmlElement("a:fgClr");
                pf.append(fg);
            end
        end
    end

    methods (Static)
        function f = from_fill_parent(parentElm)
            f = mat2ppt.dml.FillFormat(parentElm);
        end

        function idx = fill_insert_index_(parentElm)
            %FILL_INSERT_INDEX_  1-based child index for solidFill/noFill/etc.
            % Must come before effectLst / latin / ea / cs (OOXML sequence).
            % Use string arrays (not cell) so ln == afterFill works.
            afterFill = [ ...
                "effectLst", "effectDag", "highlight", ...
                "uLnTx", "uLn", "uFillTx", "uFill", ...
                "latin", "ea", "cs", "sym", ...
                "hlinkClick", "hlinkMouseOver", "rtl", "extLst"];
            kids = parentElm.getchildren();
            for i = 1:numel(kids)
                ln = string(kids{i}.localName());
                if any(ln == afterFill)
                    idx = i;
                    return
                end
            end
            idx = numel(kids) + 1;
        end
    end
end

