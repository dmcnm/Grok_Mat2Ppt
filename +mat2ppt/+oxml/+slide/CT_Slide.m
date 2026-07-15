classdef CT_Slide
%CT_SLIDE  Factory for blank p:sld root (P6-W3).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/slide.py::CT_Slide.new

    methods (Static)
        function elm = new()
            ns = mat2ppt.oxml.nsdecls("a", "p", "r");
            lines = {
                ['<p:sld ' ns '>']
                '  <p:cSld>'
                '    <p:spTree>'
                '      <p:nvGrpSpPr>'
                '        <p:cNvPr id="1" name=""/>'
                '        <p:cNvGrpSpPr/>'
                '        <p:nvPr/>'
                '      </p:nvGrpSpPr>'
                '      <p:grpSpPr/>'
                '    </p:spTree>'
                '  </p:cSld>'
                '  <p:clrMapOvr>'
                '    <a:masterClrMapping/>'
                '  </p:clrMapOvr>'
                '</p:sld>'
                };
            xml = strjoin(lines, newline);
            elm = mat2ppt.oxml.parse_xml(xml);
        end
    end
end
