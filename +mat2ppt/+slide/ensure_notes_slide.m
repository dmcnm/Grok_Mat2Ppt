function notes = ensure_notes_slide(slide)
%ENSURE_NOTES_SLIDE  Create notes slide part + rels if missing; return NotesSlide.
%
%   Ported from python-pptx NotesSlidePart.new / SlidePart.notes_slide (P6-W6).

    prs = slide.presentation();
    pkg = prs.package();
    slidePn = slide.partname();

    if mat2ppt.opc.has_rel_type(pkg, slidePn, mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_SLIDE)
        notesPn = mat2ppt.opc.related_partname_by_type(pkg, slidePn, ...
            mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_SLIDE);
        elm = pkg.xml_part_element(notesPn);
        notes = mat2ppt.slide.NotesSlide(elm, notesPn, prs);
        return
    end

    masterPn = mat2ppt.slide.ensure_notes_master(prs);
    masterElm = pkg.xml_part_element(masterPn);

    % next notes slide partname
    n = 1;
    names = pkg.list_partnames();
    for i = 1:numel(names)
        tok = regexp(char(names(i)), "^/ppt/notesSlides/notesSlide(\d+)\.xml$", "tokens", "once");
        if ~isempty(tok)
            n = max(n, str2double(tok{1}) + 1);
        end
    end
    notesPn = sprintf("/ppt/notesSlides/notesSlide%d.xml", n);

    notesElm = mat2ppt.oxml.slide.CT_Notes.new();
    mat2ppt.slide.clone_notes_master_placeholders(notesElm, masterElm);

    pkg.add_xml_part(notesPn, notesElm, mat2ppt.opc.CONTENT_TYPE.PML_NOTES_SLIDE);
    pkg.add_relationship(notesPn, mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_MASTER, masterPn);
    pkg.add_relationship(notesPn, mat2ppt.opc.RELATIONSHIP_TYPE.SLIDE, slidePn);
    pkg.add_relationship(slidePn, mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_SLIDE, notesPn);

    notes = mat2ppt.slide.NotesSlide(notesElm, notesPn, prs);
end
