classdef Axis < handle
%AXIS  Category or value axis proxy (P9-W3).
%
%   Ported subset from python-pptx chart/axis.py::_BaseAxis

    properties (Access = private)
        axElm_
    end

    methods
        function obj = Axis(axElm)
            obj.axElm_ = axElm;
        end

        function elm = element(obj)
            elm = obj.axElm_;
        end

        function id = axId(obj)
            id = mat2ppt.oxml.chart.CT_Axis.axId_val(obj.axElm_);
        end

        function pos = axPos(obj)
            pos = mat2ppt.oxml.chart.CT_Axis.axPos_val(obj.axElm_);
        end

        function o = orientation(obj)
            o = mat2ppt.oxml.chart.CT_Axis.orientation_val(obj.axElm_);
        end

        function c = crosses(obj)
            c = mat2ppt.oxml.chart.CT_Axis.crosses_val(obj.axElm_);
        end

        function tf = has_major_gridlines(obj)
            kids = obj.axElm_.getchildren();
            tf = false;
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "majorGridlines")
                    tf = true;
                    return
                end
            end
        end

        function ln = axis_kind(obj)
            %AXIS_KIND  "catAx" | "valAx" | "dateAx"
            ln = char(string(obj.axElm_.localName()));
        end
    end
end
