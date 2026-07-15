# lazyproperty MATLAB idiom (P1-W1)

python-pptx `util.lazyproperty` is a decorator that caches a method result on
first attribute access and forbids assignment.

**Mat2Ppt pattern (handle classes only):**

```matlab
classdef MyPart < handle
    properties (Access = private)
        collab_cache_
        collab_ready_ (1,1) logical = false
    end
    properties (Dependent, SetAccess = private)
        collab
    end
    methods
        function v = get.collab(obj)
            if ~obj.collab_ready_
                obj.collab_cache_ = obj.buildCollab();  % expensive once
                obj.collab_ready_ = true;
            end
            v = obj.collab_cache_;
        end
        % no set.collab — read-only like lazyproperty
    end
end
```

Ported from python-pptx 1.0.2: `src/pptx/util.py::lazyproperty`.
