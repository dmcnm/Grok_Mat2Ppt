classdef Test_r1_w2_notes_master < matlab.unittest.TestCase
    %TEST_R1_W2_NOTES_MASTER  Presentation.notes_master (R1-W2).
    % Source: python-pptx presentation.py::notes_master

    methods (Test)
        function notes_master_lazy_create(tc)
            prs = mat2ppt.Presentation();
            nm = prs.notes_master();
            tc.verifyClass(nm, "mat2ppt.slide.NotesMaster");
            tc.verifyFalse(isempty(nm.element()));
            tc.verifyGreaterThan(strlength(string(nm.partname())), 0);
            % second call returns usable master (same package part)
            nm2 = prs.notes_master();
            tc.verifyEqual(char(nm2.partname()), char(nm.partname()));
        end

        function notes_master_has_placeholders(tc)
            prs = mat2ppt.Presentation();
            nm = prs.notes_master();
            phs = nm.placeholders();
            tc.verifyGreaterThanOrEqual(phs.length, 1);
        end

        function notes_master_part_in_package(tc)
            prs = mat2ppt.Presentation();
            nm = prs.notes_master();
            elm = prs.package().xml_part_element(nm.partname());
            tc.verifyFalse(isempty(elm));
            ln = char(string(elm.localName()));
            tc.verifyTrue(strcmpi(ln, "notesMaster") || contains(lower(ln), "notesmaster"), ...
                "expected notesMaster local name, got: " + string(ln));
        end
    end
end
