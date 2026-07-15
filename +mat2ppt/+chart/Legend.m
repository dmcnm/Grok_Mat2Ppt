classdef Legend < handle
%LEGEND  Chart legend proxy (P9-W3).
%
%   Ported subset from python-pptx chart/legend.py::Legend

    properties (Access = private)
        legElm_
    end

    methods
        function obj = Legend(legElm)
            obj.legElm_ = legElm;
        end

        function elm = element(obj)
            elm = obj.legElm_;
        end

        function pos = position(obj)
            %POSITION  legendPos@val e.g. "r","b","l","t" (char).
            pos = mat2ppt.oxml.chart.CT_Legend.legendPos_val(obj.legElm_);
        end

        function set_position(obj, pos)
            pos = char(string(pos));
            kids = obj.legElm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "legendPos")
                    kids{i}.set("val", pos);
                    return
                end
            end
            lp = mat2ppt.oxml.OxmlElement("c:legendPos");
            lp.set("val", pos);
            obj.legElm_.insert(1, lp);
        end

        function tf = include_in_layout(obj)
            %INCLUDE_IN_LAYOUT  inverse of overlay=0 semantics shell.
            kids = obj.legElm_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "overlay")
                    got = kids{i}.get("val");
                    if mat2ppt.isAbsent(got)
                        tf = true;
                        return
                    end
                    s = lower(strtrim(char(string(got))));
                    tf = ~(strcmp(s, "0") || strcmp(s, "false"));
                    return
                end
            end
            tf = true;
        end
    end
end
