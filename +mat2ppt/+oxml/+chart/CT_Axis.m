classdef CT_Axis
%CT_AXIS  Helpers for c:catAx / c:valAx / c:dateAx (P8-W8).
%
%   Ported subset from python-pptx oxml/chart/axis.py

    methods (Static)
        function axes = list_axes(plotArea)
            %LIST_AXES  Cell of axis elements under plotArea (cat/val/date).
            axes = {};
            if isempty(plotArea)
                return
            end
            known = ["catAx", "valAx", "dateAx"];
            kids = plotArea.getchildren();
            for i = 1:numel(kids)
                if any(string(kids{i}.localName()) == known)
                    axes{end+1} = kids{i}; %#ok<AGROW>
                end
            end
        end

        function ax = find_catAx(plotArea)
            ax = mat2ppt.oxml.chart.CT_Axis.find_local_(plotArea, "catAx");
        end

        function ax = find_valAx(plotArea)
            ax = mat2ppt.oxml.chart.CT_Axis.find_local_(plotArea, "valAx");
        end

        function id = axId_val(axElm)
            id = [];
            ch = mat2ppt.oxml.chart.CT_Axis.find_child_(axElm, "axId");
            if isempty(ch)
                return
            end
            got = ch.get("val");
            if ~mat2ppt.isAbsent(got)
                id = str2double(char(string(got)));
            end
        end

        function pos = axPos_val(axElm)
            pos = mat2ppt.oxml.chart.CT_Axis.child_val_(axElm, "axPos", "");
        end

        function crosses = crosses_val(axElm)
            crosses = mat2ppt.oxml.chart.CT_Axis.child_val_(axElm, "crosses", "");
        end

        function orient = orientation_val(axElm)
            %ORIENTATION_VAL  c:scaling/c:orientation@val or "minMax".
            orient = "minMax";
            sc = mat2ppt.oxml.chart.CT_Axis.find_child_(axElm, "scaling");
            if isempty(sc)
                return
            end
            got = mat2ppt.oxml.chart.CT_Axis.child_val_(sc, "orientation", "minMax");
            orient = got;
        end
    end

    methods (Static, Access = private)
        function elm = find_local_(parent, localName)
            elm = [];
            if isempty(parent)
                return
            end
            kids = parent.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), char(string(localName)))
                    elm = kids{i};
                    return
                end
            end
        end

        function ch = find_child_(parent, localName)
            ch = mat2ppt.oxml.chart.CT_Axis.find_local_(parent, localName);
        end

        function v = child_val_(parent, localName, defaultVal)
            v = defaultVal;
            ch = mat2ppt.oxml.chart.CT_Axis.find_child_(parent, localName);
            if isempty(ch)
                return
            end
            got = ch.get("val");
            if ~mat2ppt.isAbsent(got)
                v = char(string(got));
            end
        end
    end
end
