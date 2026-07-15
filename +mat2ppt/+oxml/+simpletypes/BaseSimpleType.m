classdef BaseSimpleType
%BASESIMPLETYPE  Validation + XML convert helpers for attribute simple types.
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/simpletypes.py::BaseSimpleType

    methods (Static)
        function validate_int(value)
            if ~(isnumeric(value) && isscalar(value) && value == floor(value))
                error("mat2ppt:TypeError", "value must be an integral type");
            end
        end

        function validate_float(value)
            if ~(isnumeric(value) && isscalar(value))
                error("mat2ppt:TypeError", "value must be a number");
            end
        end

        function validate_int_in_range(value, minInc, maxInc)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_int(value);
            if value < minInc || value > maxInc
                error("mat2ppt:ValueError", ...
                    "value must be in range %d to %d inclusive, got %g", minInc, maxInc, value);
            end
        end

        function validate_float_in_range(value, minInc, maxInc)
            mat2ppt.oxml.simpletypes.BaseSimpleType.validate_float(value);
            if value < minInc || value > maxInc
                error("mat2ppt:ValueError", ...
                    "value must be in range %g to %g inclusive, got %g", minInc, maxInc, value);
            end
        end

        function s = validate_string(value)
            if isstring(value) || ischar(value)
                s = char(string(value));
                return
            end
            error("mat2ppt:TypeError", "value must be a string");
        end
    end
end
