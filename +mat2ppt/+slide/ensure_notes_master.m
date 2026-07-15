function masterPn = ensure_notes_master(prs)
%ENSURE_NOTES_MASTER  Install notes master + theme if missing; return master partname.
    pkg = prs.package();
    masterPn = "/ppt/notesMasters/notesMaster1.xml";
    if ~isempty(pkg.xml_part_element(masterPn)) || ...
            mat2ppt.opc.has_rel_type(pkg, "/ppt/presentation.xml", ...
                mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_MASTER)
        % resolve existing target
        try
            % find notes master via presentation rels
            src = mat2ppt.opc.PackURI("/ppt/presentation.xml");
            rels = pkg.xml_part_element(char(src.rels_uri));
            kids = rels.getchildren();
            for i = 1:numel(kids)
                el = kids{i};
                if ~strcmp(char(el.localName()), "Relationship"), continue; end
                t = el.get("Type");
                if ~mat2ppt.isAbsent(t) && contains(string(t), "notesMaster")
                    tgt = el.get("Target");
                    masterPn = char(mat2ppt.opc.PackURI.from_rel_ref(src.baseURI, char(string(tgt))));
                    return
                end
            end
        catch
        end
        if ~isempty(pkg.xml_part_element(masterPn))
            return
        end
    end

    % theme2 for notes master (python package.next_partname theme%d)
    themePn = "/ppt/theme/theme2.xml";
    if isempty(pkg.xml_part_element(themePn))
        % prefer notesTheme.xml if present (oracle-sized); else theme.xml
        try
            themeElm = mat2ppt.opc.load_template_xml("notesTheme.xml");
        catch
            themeElm = mat2ppt.opc.load_template_xml("theme.xml");
        end
        pkg.add_xml_part(themePn, themeElm, mat2ppt.opc.CONTENT_TYPE.OFC_THEME);
    end

    masterElm = mat2ppt.opc.load_template_xml("notesMaster.xml");
    pkg.add_xml_part(masterPn, masterElm, mat2ppt.opc.CONTENT_TYPE.PML_NOTES_MASTER);
    pkg.add_relationship(masterPn, mat2ppt.opc.RELATIONSHIP_TYPE.THEME, themePn);
    pkg.add_relationship("/ppt/presentation.xml", ...
        mat2ppt.opc.RELATIONSHIP_TYPE.NOTES_MASTER, masterPn);
end
