classdef Test_r7_prog_id < matlab.unittest.TestCase
    %TEST_R7_PROG_ID  PROG_ID full metadata (R7-W1 / DEF-011).

    methods (Test)
        function members_have_progId_icon_size(tc)
            x = mat2ppt.enum.PROG_ID.XLSX;
            tc.verifyEqual(char(x.progId), 'Excel.Sheet.12');
            tc.verifyEqual(char(x.icon_filename), 'xlsx-icon.emf');
            tc.verifyEqual(x.width, 965200);
            tc.verifyEqual(x.height, 609600);
            tc.verifyEqual(char(x.name), 'XLSX');

            d = mat2ppt.enum.PROG_ID.DOCX;
            tc.verifyEqual(char(d.progId), 'Word.Document.12');
            tc.verifyEqual(char(d.icon_filename), 'docx-icon.emf');

            p = mat2ppt.enum.PROG_ID.PPTX;
            tc.verifyEqual(char(p.progId), 'PowerPoint.Show.12');
            tc.verifyEqual(char(p.icon_filename), 'pptx-icon.emf');
        end

        function icons_exist_in_templates(tc)
            root = fileparts(fileparts(which("mat2ppt.Presentation")));
            % which may point to +mat2ppt; fall back
            if ~isfolder(fullfile(root, "resources", "templates"))
                here = fileparts(mfilename("fullpath")); % tests/
                root = fileparts(here);
            end
            for f = ["docx-icon.emf", "pptx-icon.emf", "xlsx-icon.emf", "generic-icon.emf"]
                p = fullfile(root, "resources", "templates", f);
                tc.verifyTrue(isfile(p), char(f + " present"));
            end
        end

        function is_member_and_from_name(tc)
            tc.verifyTrue(mat2ppt.enum.PROG_ID.is_member(mat2ppt.enum.PROG_ID.XLSX));
            tc.verifyFalse(mat2ppt.enum.PROG_ID.is_member("Excel.Sheet.12"));
            m = mat2ppt.enum.PROG_ID.from_name("xlsx");
            tc.verifyEqual(char(m.progId), 'Excel.Sheet.12');
        end
    end
end
