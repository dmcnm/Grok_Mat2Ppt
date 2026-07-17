classdef Picture < mat2ppt.shapes.BaseShape
%PICTURE  Picture shape (p:pic).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/picture.py::Picture (R3-W4 crops)

    properties (Dependent)
        crop_left
        crop_right
        crop_top
        crop_bottom
    end

    methods
        function obj = Picture(pic, parent)
            obj@mat2ppt.shapes.BaseShape(pic, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.PICTURE;
        end

        function v = get.crop_left(obj)
            v = obj.srcRect_attr_("l");
        end
        function set.crop_left(obj, value)
            obj.set_srcRect_attr_("l", value);
        end
        function v = get.crop_right(obj)
            v = obj.srcRect_attr_("r");
        end
        function set.crop_right(obj, value)
            obj.set_srcRect_attr_("r", value);
        end
        function v = get.crop_top(obj)
            v = obj.srcRect_attr_("t");
        end
        function set.crop_top(obj, value)
            obj.set_srcRect_attr_("t", value);
        end
        function v = get.crop_bottom(obj)
            v = obj.srcRect_attr_("b");
        end
        function set.crop_bottom(obj, value)
            obj.set_srcRect_attr_("b", value);
        end

        function ln = line(obj)
            ln = mat2ppt.dml.LineFormat(obj);
        end

        function el = ln(obj)
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            el = spPr.find("a:ln");
            if ~isempty(el), return; end
            kids = spPr.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "ln")
                    el = kids{i}; return
                end
            end
            el = [];
        end

        function el = get_or_add_ln(obj)
            el = obj.ln();
            if ~isempty(el), return; end
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            el = mat2ppt.oxml.OxmlElement("a:ln");
            spPr.append(el);
        end
    end

    methods (Access = private)
        function v = srcRect_attr_(obj, attr)
            src = obj.find_srcRect_();
            if isempty(src)
                v = 0.0;
                return
            end
            raw = src.get(attr);
            if mat2ppt.isAbsent(raw)
                v = 0.0;
            else
                % ST_Percentage style: integer thousandths of percent
                s = char(string(raw));
                if contains(s, "%")
                    v = str2double(erase(s, "%")) / 100.0;
                else
                    v = str2double(s) / 100000.0;
                end
            end
        end

        function set_srcRect_attr_(obj, attr, value)
            src = obj.ensure_srcRect_();
            ival = int64(round(double(value) * 100000.0));
            src.set(attr, char(string(ival)));
        end

        function src = find_srcRect_(obj)
            bf = obj.find_blipFill_();
            src = [];
            if isempty(bf), return; end
            src = bf.find("a:srcRect");
            if ~isempty(src), return; end
            kids = bf.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "srcRect")
                    src = kids{i}; return
                end
            end
        end

        function src = ensure_srcRect_(obj)
            src = obj.find_srcRect_();
            if ~isempty(src), return; end
            bf = obj.find_blipFill_();
            if isempty(bf)
                error("mat2ppt:InvalidXmlError", "pic missing blipFill");
            end
            src = mat2ppt.oxml.OxmlElement("a:srcRect");
            % insert before stretch if present
            kids = bf.getchildren();
            stretch = [];
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "stretch")
                    stretch = kids{i}; break
                end
            end
            if isempty(stretch)
                bf.append(src);
            else
                bf.remove(stretch);
                bf.append(src);
                bf.append(stretch);
            end
        end

        function bf = find_blipFill_(obj)
            bf = obj.sp_.find("p:blipFill");
            if ~isempty(bf), return; end
            kids = obj.sp_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "blipFill")
                    bf = kids{i}; return
                end
            end
            bf = [];
        end
    end

    methods (Static)
        function pic = new_pic_elm(shapeId, name, left, top, width, height, rId, desc)
            %NEW_PIC_ELM  p:pic with blip embed + stretch (python CT_Picture.new_pic).
            %   Optional desc (8th arg) becomes cNvPr@descr (filename).
            if nargin < 8
                desc = "";
            end
            left = double(mat2ppt.util.Length.toEmuInt_(left));
            top = double(mat2ppt.util.Length.toEmuInt_(top));
            width = double(mat2ppt.util.Length.toEmuInt_(width));
            height = double(mat2ppt.util.Length.toEmuInt_(height));

            pic = mat2ppt.oxml.OxmlElement("p:pic");
            nv = mat2ppt.oxml.OxmlElement("p:nvPicPr");
            cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
            cNvPr.set("id", char(string(shapeId)));
            cNvPr.set("name", char(string(name)));
            if ~mat2ppt.isAbsent(desc) && strlength(string(desc)) > 0
                cNvPr.set("descr", char(string(desc)));
            end
            nv.append(cNvPr);
            cNvPicPr = mat2ppt.oxml.OxmlElement("p:cNvPicPr");
            locks = mat2ppt.oxml.OxmlElement("a:picLocks");
            locks.set("noChangeAspect", "1");
            cNvPicPr.append(locks);
            nv.append(cNvPicPr);
            nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
            pic.append(nv);

            blipFill = mat2ppt.oxml.OxmlElement("p:blipFill");
            blip = mat2ppt.oxml.OxmlElement("a:blip");
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            blip.set(sprintf("{%s}embed", R), char(string(rId)));
            blipFill.append(blip);
            stretch = mat2ppt.oxml.OxmlElement("a:stretch");
            stretch.append(mat2ppt.oxml.OxmlElement("a:fillRect"));
            blipFill.append(stretch);
            pic.append(blipFill);

            spPr = mat2ppt.oxml.OxmlElement("p:spPr");
            xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
            off = mat2ppt.oxml.OxmlElement("a:off");
            off.set("x", char(string(round(left))));
            off.set("y", char(string(round(top))));
            ext = mat2ppt.oxml.OxmlElement("a:ext");
            ext.set("cx", char(string(round(width))));
            ext.set("cy", char(string(round(height))));
            xfrm.append(off);
            xfrm.append(ext);
            spPr.append(xfrm);
            prstGeom = mat2ppt.oxml.OxmlElement("a:prstGeom");
            prstGeom.set("prst", "rect");
            prstGeom.append(mat2ppt.oxml.OxmlElement("a:avLst"));
            spPr.append(prstGeom);
            pic.append(spPr);
        end
    end
end
