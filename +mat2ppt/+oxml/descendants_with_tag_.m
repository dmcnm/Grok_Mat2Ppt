function list = descendants_with_tag_(elm, tag)
    list = {};
    tag = string(tag);
    if contains(tag, ":") && ~startsWith(tag, "{")
        tag = string(mat2ppt.oxml.qn(tag));
    end
    kids = elm.getchildren();
    for i = 1:numel(kids)
        c = kids{i};
        if c.tag == tag
            list{end+1} = c; %#ok<AGROW>
        end
        sub = mat2ppt.oxml.descendants_with_tag_(c, tag);
        list = [list, sub]; %#ok<AGROW>
    end
end
