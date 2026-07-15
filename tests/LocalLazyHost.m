classdef LocalLazyHost < handle
    % Test double demonstrating lazyproperty idiom (not public API).

    properties (Access = private)
        foo_cache_
        foo_ready_ (1,1) logical = false
    end

    properties (SetAccess = private)
        computeCount (1,1) double = 0
    end

    properties (Dependent, SetAccess = private)
        foo
    end

    methods
        function v = get.foo(obj)
            if ~obj.foo_ready_
                obj.foo_cache_ = obj.computeFoo();
                obj.foo_ready_ = true;
            end
            v = obj.foo_cache_;
        end

        function v = computeFoo(obj)
            obj.computeCount = obj.computeCount + 1;
            v = 42;
        end
    end
end
