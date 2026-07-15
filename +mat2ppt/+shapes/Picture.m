classdef Picture < mat2ppt.shapes.BaseShape
%PICTURE  Picture shape (p:pic).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/picture.py::Picture (P5-W4)

    methods
        function obj = Picture(pic, parent)
            obj@mat2ppt.shapes.BaseShape(pic, parent);
        end

        function t = shape_type(obj)
            t = mat2ppt.enum.MSO_SHAPE_TYPE.PICTURE;
        end
    end

    methods (Static)
        function pic = new_pic_elm(shapeId, name, left, top, width, height, rId)
            %NEW_PIC_ELM  Minimal p:pic skeleton with blip r:embed.
            pic = mat2ppt.oxml.OxmlElement("p:pic");
            nv = mat2ppt.oxml.OxmlElement("p:nvPicPr");
            cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
            cNvPr.set("id", char(string(shapeId)));
            cNvPr.set("name", char(string(name)));
            nv.append(cNvPr);
            nv.append(mat2ppt.oxml.OxmlElement("p:cNvPicPr"));
            nv.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
            pic.append(nv);
            blipFill = mat2ppt.oxml.OxmlElement("p:blipFill");
            blip = mat2ppt.oxml.OxmlElement("a:blip");
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            blip.set(sprintf("{%s}embed", R), char(string(rId)));
            blipFill.append(blip);
            pic.append(blipFill);
            spPr = mat2ppt.oxml.OxmlElement("p:spPr");
            xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
            off = mat2ppt.oxml.OxmlElement("a:off");
            off.set("x", char(string(round(double(mat2ppt.util.Length.toEmuInt_(left))))));
            off.set("y", char(string(round(double(mat2ppt.util.Length.toEmuInt_(top))))));
            ext = mat2ppt.oxml.OxmlElement("a:ext");
            ext.set("cx", char(string(round(double(mat2ppt.util.Length.toEmuInt_(width))))));
            ext.set("cy", char(string(round(double(mat2ppt.util.Length.toEmuInt_(height))))));
            xfrm.append(off); xfrm.append(ext);
            spPr.append(xfrm);
            pic.append(spPr);
        end
    end
end
