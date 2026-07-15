classdef CT_Notes
%CT_NOTES  Factory for blank p:notes root (P6-W6).
%
%   Ported from python-pptx templates/notes.xml + CT_NotesSlide.new

    methods (Static)
        function elm = new()
            elm = mat2ppt.oxml.OxmlElement("p:notes");
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            P = "http://schemas.openxmlformats.org/presentationml/2006/main";
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            elm.setNsDecls({"a", A; "p", P; "r", R});
            cSld = mat2ppt.oxml.OxmlElement("p:cSld");
            spTree = mat2ppt.oxml.OxmlElement("p:spTree");
            nvGrp = mat2ppt.oxml.OxmlElement("p:nvGrpSpPr");
            cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
            cNvPr.set("id", "1");
            cNvPr.set("name", "");
            nvGrp.append(cNvPr);
            nvGrp.append(mat2ppt.oxml.OxmlElement("p:cNvGrpSpPr"));
            nvGrp.append(mat2ppt.oxml.OxmlElement("p:nvPr"));
            spTree.append(nvGrp);
            grpSpPr = mat2ppt.oxml.OxmlElement("p:grpSpPr");
            xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
            off = mat2ppt.oxml.OxmlElement("a:off");
            off.set("x", "0");
            off.set("y", "0");
            ext = mat2ppt.oxml.OxmlElement("a:ext");
            ext.set("cx", "0");
            ext.set("cy", "0");
            chOff = mat2ppt.oxml.OxmlElement("a:chOff");
            chOff.set("x", "0");
            chOff.set("y", "0");
            chExt = mat2ppt.oxml.OxmlElement("a:chExt");
            chExt.set("cx", "0");
            chExt.set("cy", "0");
            xfrm.append(off);
            xfrm.append(ext);
            xfrm.append(chOff);
            xfrm.append(chExt);
            grpSpPr.append(xfrm);
            spTree.append(grpSpPr);
            cSld.append(spTree);
            elm.append(cSld);
            clr = mat2ppt.oxml.OxmlElement("p:clrMapOvr");
            clr.append(mat2ppt.oxml.OxmlElement("a:masterClrMapping"));
            elm.append(clr);
        end
    end
end
