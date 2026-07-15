function clone_layout_placeholders(slide, slideLayout)
%CLONE_LAYOUT_PLACEHOLDERS  Copy non-latent placeholders from layout to slide.
%
%   Ported from python-pptx SlideShapes.clone_layout_placeholders (P6-W3).
%   Skips date / footer / slide number (latent).

    [~, spTree] = mat2ppt.slide.find_cSld_spTree(slide.element());
    [~, layTree] = mat2ppt.slide.find_cSld_spTree(slideLayout.element());

    nextId = 2;
    kids = spTree.getchildren();
    for i = 1:numel(kids)
        idv = mat2ppt.slide.shape_id_(kids{i});
        if ~isempty(idv) && idv >= nextId
            nextId = idv + 1;
        end
    end

    layKids = layTree.getchildren();
    for i = 1:numel(layKids)
        spElm = layKids{i};
        if ~strcmp(char(spElm.localName()), "sp")
            continue
        end
        if ~mat2ppt.shapes.PlaceholderMixin.element_is_placeholder(spElm)
            continue
        end
        phType = mat2ppt.shapes.PlaceholderMixin.placeholder_type(spElm);
        % char cells (not string cells) — strcmp must match char phType
        if any(strcmp(char(string(phType)), {'dt', 'ftr', 'sldNum'}))
            continue
        end
        [orient, sz, idx] = mat2ppt.slide.ph_attrs_(spElm);
        name = mat2ppt.slide.next_ph_name_(phType, nextId, orient);
        newSp = mat2ppt.oxml.shapes.new_placeholder_sp(nextId, name, phType, orient, sz, idx);
        spTree.append(newSp);
        nextId = nextId + 1;
    end
end
