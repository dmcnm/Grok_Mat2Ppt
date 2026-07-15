classdef DataLabels < handle
%DATALABELS  Plot/series dLbls proxy (P9-W3).
%
%   Ported subset from python-pptx chart/datalabel.py::DataLabels

    properties (Access = private)
        dLblsElm_
    end

    methods
        function obj = DataLabels(dLblsElm)
            obj.dLblsElm_ = dLblsElm;
        end

        function elm = element(obj)
            elm = obj.dLblsElm_;
        end

        function tf = show_value(obj)
            tf = mat2ppt.oxml.chart.CT_DLbls.show_flag(obj.dLblsElm_, "showVal");
        end

        function set_show_value(obj, value)
            mat2ppt.chart.DataLabels.set_flag_(obj.dLblsElm_, "showVal", value);
        end

        function tf = show_category_name(obj)
            tf = mat2ppt.oxml.chart.CT_DLbls.show_flag(obj.dLblsElm_, "showCatName");
        end

        function set_show_category_name(obj, value)
            mat2ppt.chart.DataLabels.set_flag_(obj.dLblsElm_, "showCatName", value);
        end

        function tf = show_percentage(obj)
            tf = mat2ppt.oxml.chart.CT_DLbls.show_flag(obj.dLblsElm_, "showPercent");
        end
    end

    methods (Static, Access = private)
        function set_flag_(dLblsElm, localName, value)
            kids = dLblsElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), char(string(localName)))
                    if logical(value)
                        kids{i}.set("val", "1");
                    else
                        kids{i}.set("val", "0");
                    end
                    return
                end
            end
            el = mat2ppt.oxml.OxmlElement(["c:" char(string(localName))]);
            if logical(value)
                el.set("val", "1");
            else
                el.set("val", "0");
            end
            dLblsElm.append(el);
        end
    end
end
