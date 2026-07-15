classdef CT_DLbls
%CT_DLBLS  Data label factories and helpers (P8-W8).
%
%   Ported from python-pptx oxml/chart/datalabel.py::CT_DLbls

    methods (Static)
        function elm = new_dLbls()
            %NEW_DLBLS  Default c:dLbls element (python CT_DLbls.new_dLbls).
            xml = [ ...
                '<c:dLbls xmlns:c="http://schemas.openxmlformats.org/drawingml/2006/chart">' ...
                '<c:showLegendKey val="0"/>' ...
                '<c:showVal val="0"/>' ...
                '<c:showCatName val="0"/>' ...
                '<c:showSerName val="0"/>' ...
                '<c:showPercent val="0"/>' ...
                '<c:showBubbleSize val="0"/>' ...
                '<c:showLeaderLines val="1"/>' ...
                '</c:dLbls>'];
            elm = mat2ppt.oxml.parse_xml(xml);
        end

        function v = show_flag(dLblsElm, localName)
            %SHOW_FLAG  Boolean from c:showVal etc. @val (default false if missing).
            v = false;
            if isempty(dLblsElm)
                return
            end
            kids = dLblsElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), char(string(localName)))
                    got = kids{i}.get("val");
                    if mat2ppt.isAbsent(got)
                        v = true; % schema default true when attribute absent
                    else
                        s = lower(strtrim(char(string(got))));
                        v = strcmp(s, "1") || strcmp(s, "true");
                    end
                    return
                end
            end
        end
    end
end
