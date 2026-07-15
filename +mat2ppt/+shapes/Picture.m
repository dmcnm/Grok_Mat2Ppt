classdef Picture < mat2ppt.shapes.BaseShape
%PICTURE  Picture shape (p:pic).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/picture.py::Picture (P5-W4 / P7-W3)

    methods
        function obj = Picture(pic, parent)
            obj@mat2ppt.shapes.BaseShape(pic, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.PICTURE;
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
