classdef CT_Series
%CT_SERIES  Helpers for c:ser composite (P8-W7).
%
%   Ported subset from python-pptx oxml/chart/series.py::CT_SeriesComposite

    methods (Static)
        function v = idx_val(serElm)
            v = mat2ppt.oxml.chart.CT_Series.direct_child_val_(serElm, "idx", 0);
        end

        function v = order_val(serElm)
            v = mat2ppt.oxml.chart.CT_Series.direct_child_val_(serElm, "order", 0);
        end

        function name = series_name(serElm)
            %SERIES_NAME  Text of c:tx//c:v, or "".
            name = "";
            if isempty(serElm)
                return
            end
            tx = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, "tx");
            if isempty(tx)
                return
            end
            texts = mat2ppt.oxml.chart.CT_ChartSpace.collect_v_texts(tx);
            if ~isempty(texts)
                name = char(texts(1));
            end
        end

        function n = cat_ptCount_val(serElm)
            n = mat2ppt.oxml.chart.CT_Series.ptCount_under_(serElm, "cat");
        end

        function n = val_ptCount_val(serElm)
            n = mat2ppt.oxml.chart.CT_Series.ptCount_under_(serElm, "val");
        end

        function ref = cat_formula(serElm)
            ref = mat2ppt.oxml.chart.CT_Series.formula_under_(serElm, "cat");
        end

        function ref = val_formula(serElm)
            ref = mat2ppt.oxml.chart.CT_Series.formula_under_(serElm, "val");
        end

        function vals = val_point_values(serElm)
            %VAL_POINT_VALUES  double vector of c:val//c:pt/c:v in idx order.
            vals = zeros(0, 1);
            valElm = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, "val");
            if isempty(valElm)
                return
            end
            pts = mat2ppt.oxml.chart.CT_Series.collect_pts_(valElm);
            if isempty(pts)
                return
            end
            maxIdx = -1;
            for i = 1:numel(pts)
                maxIdx = max(maxIdx, pts(i).idx);
            end
            vals = nan(maxIdx + 1, 1);
            for i = 1:numel(pts)
                vals(pts(i).idx + 1) = pts(i).value;
            end
        end

        function cats = cat_point_labels(serElm)
            %CAT_POINT_LABELS  cellstr of category labels in idx order.
            cats = {};
            catElm = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, "cat");
            if isempty(catElm)
                return
            end
            pts = mat2ppt.oxml.chart.CT_Series.collect_pts_(catElm);
            if isempty(pts)
                return
            end
            maxIdx = -1;
            for i = 1:numel(pts)
                maxIdx = max(maxIdx, pts(i).idx);
            end
            cats = cell(1, maxIdx + 1);
            for i = 1:numel(pts)
                cats{pts(i).idx + 1} = pts(i).label;
            end
        end

        function dPt = new_dPt(idx)
            %NEW_DPT  Loose c:dPt with c:idx.
            dPt = mat2ppt.oxml.OxmlElement("c:dPt");
            idxElm = mat2ppt.oxml.OxmlElement("c:idx");
            idxElm.set("val", char(string(double(idx))));
            dPt.append(idxElm);
        end
    end

    methods (Static, Access = private)
        function ch = find_child_(parent, localName)
            ch = [];
            if isempty(parent)
                return
            end
            kids = parent.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), char(string(localName)))
                    ch = kids{i};
                    return
                end
            end
        end

        function v = direct_child_val_(serElm, localName, defaultVal)
            v = defaultVal;
            ch = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, localName);
            if isempty(ch)
                return
            end
            got = ch.get("val");
            if ~mat2ppt.isAbsent(got)
                v = str2double(char(string(got)));
                if isnan(v)
                    v = defaultVal;
                end
            end
        end

        function n = ptCount_under_(serElm, branchLocal)
            n = 0;
            branch = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, branchLocal);
            if isempty(branch)
                return
            end
            % walk for ptCount
            stack = {branch};
            while ~isempty(stack)
                e = stack{1};
                stack(1) = [];
                if strcmp(char(e.localName()), "ptCount")
                    got = e.get("val");
                    if ~mat2ppt.isAbsent(got)
                        n = str2double(char(string(got)));
                        if isnan(n), n = 0; end
                    end
                    return
                end
                kids = e.getchildren();
                for i = 1:numel(kids)
                    stack{end+1} = kids{i}; %#ok<AGROW>
                end
            end
        end

        function ref = formula_under_(serElm, branchLocal)
            ref = "";
            branch = mat2ppt.oxml.chart.CT_Series.find_child_(serElm, branchLocal);
            if isempty(branch)
                return
            end
            stack = {branch};
            while ~isempty(stack)
                e = stack{1};
                stack(1) = [];
                if strcmp(char(e.localName()), "f")
                    if ~mat2ppt.isAbsent(e.text)
                        ref = char(string(e.text));
                    end
                    return
                end
                kids = e.getchildren();
                for i = 1:numel(kids)
                    stack{end+1} = kids{i}; %#ok<AGROW>
                end
            end
        end

        function pts = collect_pts_(root)
            pts = struct("idx", {}, "value", {}, "label", {});
            stack = {root};
            while ~isempty(stack)
                e = stack{1};
                stack(1) = [];
                if strcmp(char(e.localName()), "pt")
                    idx = 0;
                    got = e.get("idx");
                    if ~mat2ppt.isAbsent(got)
                        idx = str2double(char(string(got)));
                        if isnan(idx), idx = 0; end
                    end
                    label = "";
                    value = NaN;
                    kids = e.getchildren();
                    for j = 1:numel(kids)
                        if strcmp(char(kids{j}.localName()), "v")
                            if ~mat2ppt.isAbsent(kids{j}.text)
                                label = char(string(kids{j}.text));
                                value = str2double(label);
                            end
                        end
                    end
                    pts(end+1) = struct("idx", idx, "value", value, "label", label); %#ok<AGROW>
                else
                    kids = e.getchildren();
                    for i = 1:numel(kids)
                        stack{end+1} = kids{i}; %#ok<AGROW>
                    end
                end
            end
        end
    end
end
