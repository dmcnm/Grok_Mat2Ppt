function [names, vals] = order_relationship_attrs_(names, vals)
%ORDER_RELATIONSHIP_ATTRS_  lxml/python-pptx order: Id, Type, Target, TargetMode

    order = {'Id', 'Type', 'Target', 'TargetMode'};
    newNames = {};
    newVals = {};
    used = false(1, numel(names));
    for o = 1:numel(order)
        key = order{o};
        for i = 1:numel(names)
            if used(i)
                continue
            end
            plain = plain_attr_name_(names{i});
            if strcmp(plain, key)
                newNames{end+1} = names{i}; %#ok<AGROW>
                newVals{end+1} = vals{i}; %#ok<AGROW>
                used(i) = true;
            end
        end
    end
    for i = 1:numel(names)
        if ~used(i)
            newNames{end+1} = names{i}; %#ok<AGROW>
            newVals{end+1} = vals{i}; %#ok<AGROW>
        end
    end
    names = newNames;
    vals = newVals;
end

function plain = plain_attr_name_(n)
    n = char(string(n));
    if ~isempty(n) && n(1) == '{'
        plain = char(extractAfter(string(n), '}'));
    else
        plain = n;
    end
end
