function map = element_class_lookup_(reset)
%ELEMENT_CLASS_LOOKUP_  Clark-or-nsptag → element class name registry.
%
%   Ported from python-pptx 1.0.2: oxml/__init__.py register_element_cls pattern
%   (design §7.2 — registration table, not metaclasses).

    persistent reg
    if nargin >= 1 && reset
        reg = containers.Map("KeyType", "char", "ValueType", "char");
    end
    if isempty(reg)
        reg = containers.Map("KeyType", "char", "ValueType", "char");
    end
    map = reg;
end
