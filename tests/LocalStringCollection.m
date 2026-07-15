classdef LocalStringCollection < mat2ppt.shared.Collection
    % Test helper collection of strings.
    methods
        function obj = LocalStringCollection(vals)
            if isstring(vals)
                for i = 1:numel(vals)
                    obj.items_{i} = vals(i); %#ok<AGROW>
                end
            end
        end
    end
end
