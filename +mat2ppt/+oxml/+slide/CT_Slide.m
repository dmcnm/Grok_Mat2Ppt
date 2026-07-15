classdef CT_Slide
%CT_SLIDE  Factory for blank p:sld root (P6-W3).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/slide.py::CT_Slide.new
%   Built with OxmlElement for compact serialize (no pretty whitespace).

    methods (Static)
        function elm = new()
            elm = mat2ppt.oxml.OxmlElement("p:sld");
            % root ns order a, p, r like python-pptx
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
            spTree.append(mat2ppt.oxml.OxmlElement("p:grpSpPr"));
            cSld.append(spTree);
            elm.append(cSld);
            clr = mat2ppt.oxml.OxmlElement("p:clrMapOvr");
            clr.append(mat2ppt.oxml.OxmlElement("a:masterClrMapping"));
            elm.append(clr);
        end
    end
end
