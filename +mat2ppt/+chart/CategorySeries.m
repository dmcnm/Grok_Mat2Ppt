classdef CategorySeries < handle
%CATEGORYSERIES  One c:ser on a category plot (P9-W2).
%
%   Public point/series collection indices are **1-based**.
%   Ported from python-pptx chart/series.py::_BaseCategorySeries

    properties (Access = private)
        serElm_
        plot_   % parent Plot handle (optional)
    end

    methods
        function obj = CategorySeries(serElm, plot)
            arguments
                serElm
                plot = []
            end
            obj.serElm_ = serElm;
            obj.plot_ = plot;
        end

        function elm = element(obj)
            elm = obj.serElm_;
        end

        function v = index(obj)
            %INDEX  0-based XML c:idx@val (matches python-pptx).
            v = mat2ppt.oxml.chart.CT_Series.idx_val(obj.serElm_);
        end

        function n = name(obj)
            n = mat2ppt.oxml.chart.CT_Series.series_name(obj.serElm_);
        end

        function vals = values(obj)
            %VALUES  Row double vector of series values (NaN for gaps).
            col = mat2ppt.oxml.chart.CT_Series.val_point_values(obj.serElm_);
            vals = col(:)';
        end

        function cats = categories(obj)
            %CATEGORIES  Cellstr of category labels from this series' cat cache.
            cats = mat2ppt.oxml.chart.CT_Series.cat_point_labels(obj.serElm_);
        end

        function n = point_count(obj)
            n = mat2ppt.oxml.chart.CT_Series.val_ptCount_val(obj.serElm_);
        end

        function ref = values_ref(obj)
            ref = mat2ppt.oxml.chart.CT_Series.val_formula(obj.serElm_);
        end

        function ref = categories_ref(obj)
            ref = mat2ppt.oxml.chart.CT_Series.cat_formula(obj.serElm_);
        end
    end
end
