classdef Test_r3_w3_freeform < matlab.unittest.TestCase
    %TEST_R3_W3_FREEFORM  build_freeform + convert_to_shape (R3-W3).

    methods (Test)
        function triangle_freeform(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            % local units = EMU (scale 1)
            b = s.shapes().build_freeform(0, 0, 1.0);
            b.add_line_segments([1000000 0; 500000 1000000], true);
            sh = b.convert_to_shape(mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            tc.verifyClass(sh, "mat2ppt.shapes.Shape");
            % pathLst present
            r = mat2ppt.oxml.evaluate_xpath(sh.shape_element(), ".//a:path");
            tc.verifyFalse(isempty(r));
            % has close
            r2 = mat2ppt.oxml.evaluate_xpath(sh.shape_element(), ".//a:close");
            tc.verifyFalse(isempty(r2));
        end

        function line_to_open_path(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            b = s.shapes().build_freeform(0, 0, 1);
            b.line_to(2000000, 0);
            b.line_to(2000000, 1000000);
            sh = b.convert_to_shape(0, 0);
            tc.verifyClass(sh, "mat2ppt.shapes.Shape");
            nBefore = s.shapes().length;
            tc.verifyGreaterThanOrEqual(nBefore, 1);
        end
    end
end
