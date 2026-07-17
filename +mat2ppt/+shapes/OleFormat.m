classdef OleFormat < handle
%OLEFORMAT  Attributes of an embedded OLE graphic frame (R7-W4).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/graphfrm.py::_OleFormat

    properties (Access = private)
        graphicFrameElm_
        parent_
    end

    methods
        function obj = OleFormat(graphicFrameElm, parent)
            obj.graphicFrameElm_ = graphicFrameElm;
            obj.parent_ = parent;
        end

        function s = prog_id(obj)
            r = mat2ppt.oxml.evaluate_xpath(obj.graphicFrameElm_, ".//p:oleObj");
            if isempty(r)
                s = [];
                return
            end
            raw = r{1}.get("progId");
            if mat2ppt.isAbsent(raw)
                s = [];
            else
                s = char(string(raw));
            end
        end

        function tf = show_as_icon(obj)
            r = mat2ppt.oxml.evaluate_xpath(obj.graphicFrameElm_, ".//p:oleObj");
            if isempty(r)
                tf = false;
                return
            end
            raw = r{1}.get("showAsIcon");
            if mat2ppt.isAbsent(raw)
                tf = false;
            else
                s = lower(strtrim(char(string(raw))));
                tf = any(strcmp(s, {'1', 'true'}));
            end
        end
    end
end
