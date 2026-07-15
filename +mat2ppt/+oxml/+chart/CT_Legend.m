classdef CT_Legend
%CT_LEGEND  Legend element helpers (P8-W8).
%
%   Ported subset from python-pptx oxml/chart/legend.py::CT_Legend

    methods (Static)
        function leg = find_legend(chartElm)
            %FIND_LEGEND  c:legend under c:chart, or [].
            leg = [];
            if isempty(chartElm)
                return
            end
            kids = chartElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "legend")
                    leg = kids{i};
                    return
                end
            end
        end

        function elm = new_legend(pos)
            %NEW_LEGEND  Minimal c:legend with legendPos (default r).
            if nargin < 1 || isempty(pos)
                pos = "r";
            end
            pos = char(string(pos));
            elm = mat2ppt.oxml.OxmlElement("c:legend");
            lp = mat2ppt.oxml.OxmlElement("c:legendPos");
            lp.set("val", pos);
            elm.append(lp);
            layout = mat2ppt.oxml.OxmlElement("c:layout");
            elm.append(layout);
            overlay = mat2ppt.oxml.OxmlElement("c:overlay");
            overlay.set("val", "0");
            elm.append(overlay);
        end

        function pos = legendPos_val(legElm)
            pos = "r";
            if isempty(legElm)
                return
            end
            kids = legElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "legendPos")
                    got = kids{i}.get("val");
                    if ~mat2ppt.isAbsent(got)
                        pos = char(string(got));
                    end
                    return
                end
            end
        end
    end
end
