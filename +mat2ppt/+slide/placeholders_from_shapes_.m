function coll = placeholders_from_shapes_(shapes)
%PLACEHOLDERS_FROM_SHAPES_  1-based Collection of placeholder shapes only.
    coll = mat2ppt.shared.Collection();
    items = {};
    for i = 1:shapes.length
        sh = shapes.item(i);
        if mat2ppt.shapes.PlaceholderMixin.element_is_placeholder(sh.element())
            items{end+1} = sh; %#ok<AGROW>
        end
    end
    coll.set_items_(items);
end
