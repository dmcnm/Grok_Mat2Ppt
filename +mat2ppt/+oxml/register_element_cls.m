function register_element_cls(nsptag, className)
%REGISTER_ELEMENT_CLS  Register custom element class for a ns-prefixed tag.
%
%   mat2ppt.oxml.register_element_cls("pr:Relationship", "mat2ppt.oxml.CT_Relationship")
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/__init__.py::register_element_cls

    arguments
        nsptag
        className
    end
    nsptag = char(string(nsptag));
    className = char(string(className));
    reg = mat2ppt.oxml.element_class_lookup_();
    clark = mat2ppt.oxml.qn(nsptag);
    reg(clark) = className;
    reg(nsptag) = className; %#ok<NASGU>
end
