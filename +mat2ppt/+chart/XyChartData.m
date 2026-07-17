classdef XyChartData < handle
%XYCHARTDATA  XY series of (x,y) points (R5-W2).
%
%   Ported from python-pptx chart/data.py::XyChartData

    properties (Access = private)
        seriesList_ cell = {}  % struct name, xs, ys
    end

    methods
        function obj = XyChartData()
        end

        function s = add_series(obj, name)
            arguments
                obj
                name = ""
            end
            s = struct("name", char(string(name)), "xs", [], "ys", [], "sizes", []);
            obj.seriesList_{end+1} = s; %#ok<AGROW>
            s = obj.seriesList_{end}; % return copy; use add_data_point
        end

        function add_data_point(obj, seriesIdx, x, y, size)
            %ADD_DATA_POINT  1-based series index; size optional (bubble).
            arguments
                obj
                seriesIdx (1,1) double
                x (1,1) double
                y (1,1) double
                size = []
            end
            s = obj.seriesList_{seriesIdx};
            s.xs(end+1) = x; %#ok<AGROW>
            s.ys(end+1) = y; %#ok<AGROW>
            if ~mat2ppt.isAbsent(size)
                s.sizes(end+1) = double(size); %#ok<AGROW>
            end
            obj.seriesList_{seriesIdx} = s;
        end

        function n = series_count(obj)
            n = numel(obj.seriesList_);
        end

        function s = series(obj, idx)
            s = obj.seriesList_{idx};
        end
    end
end
