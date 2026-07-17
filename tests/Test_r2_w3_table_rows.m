classdef Test_r2_w3_table_rows < matlab.unittest.TestCase
    %TEST_R2_W3_TABLE_ROWS  Table.rows/columns/banding/iter_cells (R2-W3).

    methods (Test)
        function rows_columns_iter(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            gf = s.shapes().add_table(2, 3, mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(2));
            tbl = gf.table();
            tc.verifyEqual(tbl.rows().length, 2);
            tc.verifyEqual(tbl.columns().length, 3);
            cells = tbl.iter_cells();
            tc.verifyEqual(numel(cells), 6);
            tc.verifyEqual(tbl.rows().item(1).cells().length, 3);
        end

        function banding_flags(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            gf = s.shapes().add_table(2, 2, mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(2));
            tbl = gf.table();
            % CT_Table.new_tbl defaults firstRow/bandRow on (python-pptx twin)
            tc.verifyTrue(tbl.first_row());
            tc.verifyTrue(tbl.horz_banding());
            tbl.set_first_row(false);
            tc.verifyFalse(tbl.first_row());
            tbl.set_first_col(true);
            tc.verifyTrue(tbl.first_col());
            tbl.set_horz_banding(false);
            tc.verifyFalse(tbl.horz_banding());
        end
    end
end
