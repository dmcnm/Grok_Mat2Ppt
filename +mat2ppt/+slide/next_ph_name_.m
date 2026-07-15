function name = next_ph_name_(phType, shapeId, orient)
%NEXT_PH_NAME_  Placeholder display name (python _next_ph_name subset).
    t = char(string(phType));
    switch t
        case "title"
            base = "Title";
        case "ctrTitle"
            base = "Title";
        case "subTitle"
            base = "Subtitle";
        case "body"
            base = "Text Placeholder";
        case "obj"
            base = "Content Placeholder";
        case "chart"
            base = "Chart Placeholder";
        case "tbl"
            base = "Table Placeholder";
        case "pic"
            base = "Picture Placeholder";
        case "media"
            base = "Media Placeholder";
        otherwise
            base = "Placeholder";
    end
    if ~mat2ppt.isAbsent(orient) && strcmp(char(string(orient)), "vert")
        base = ["Vertical " base];
        base = char(base);
    end
    name = sprintf("%s %d", base, shapeId - 1);
end
