function clone_notes_master_placeholders(notesElm, masterElm)
%CLONE_NOTES_MASTER_PLACEHOLDERS  sldImg / body / sldNum from notes master.
%
%   Ported from python-pptx NotesSlide.clone_master_placeholders (P6-W6).

    [~, spTree] = mat2ppt.slide.find_cSld_spTree(notesElm);
    [~, masterTree] = mat2ppt.slide.find_cSld_spTree(masterElm);

    nextId = 2;
    kids = spTree.getchildren();
    for i = 1:numel(kids)
        idv = mat2ppt.slide.shape_id_(kids{i});
        if ~isempty(idv) && idv >= nextId
            nextId = idv + 1;
        end
    end

    cloneable = {'sldImg', 'body', 'sldNum'};
    layKids = masterTree.getchildren();
    for i = 1:numel(layKids)
        spElm = layKids{i};
        if ~strcmp(char(spElm.localName()), "sp")
            continue
        end
        if ~mat2ppt.shapes.PlaceholderMixin.element_is_placeholder(spElm)
            continue
        end
        phType = mat2ppt.shapes.PlaceholderMixin.placeholder_type(spElm);
        if ~any(strcmp(char(string(phType)), cloneable))
            continue
        end
        [orient, sz, idx] = mat2ppt.slide.ph_attrs_(spElm);
        name = mat2ppt.slide.next_ph_name_(phType, nextId, orient);
        newSp = mat2ppt.oxml.shapes.new_placeholder_sp(nextId, name, phType, orient, sz, idx);
        spTree.append(newSp);
        nextId = nextId + 1;
    end
end
