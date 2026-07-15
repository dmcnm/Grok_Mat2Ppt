classdef Collection < handle
%COLLECTION  Base for 1-based ordered collections (A16).
%
%   Implements .item(k), subsref (), and .length.
%   Subclasses implement items_ cell array of handles/values.

    properties (Access = protected)
        items_ cell = {}
    end

    properties (Dependent, SetAccess = private)
        length
    end

    methods
        function n = get.length(obj)
            n = numel(obj.items_);
        end

        function x = item(obj, k)
            n = obj.length;
            k = double(k);
            if k < 1 || k > n || k ~= floor(k)
                error("mat2ppt:IndexOutOfRange", ...
                    "Index %g out of range. Valid indices are 1 through %d (1-based).", k, n);
            end
            x = obj.items_{k};
        end

        function varargout = subsref(obj, s)
            if strcmp(s(1).type, "()")
                idx = s(1).subs{1};
                x = obj.item(idx);
                if numel(s) == 1
                    varargout{1} = x;
                else
                    [varargout{1:nargout}] = builtin("subsref", x, s(2:end));
                end
            else
                [varargout{1:nargout}] = builtin("subsref", obj, s);
            end
        end
    end
end
