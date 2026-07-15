function className = element_class_for_tag(tag)
%ELEMENT_CLASS_FOR_TAG  Registered class name for Clark or pfx:local tag, or ''.

    tag = char(string(tag));
    if contains(tag, ":") && ~startsWith(tag, "{")
        tag = mat2ppt.oxml.qn(tag);
    end
    reg = mat2ppt.oxml.element_class_lookup_();
    if isKey(reg, tag)
        className = reg(tag);
    else
        className = "";
    end
end
