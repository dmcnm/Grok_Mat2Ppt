classdef Test_r2_w1_textframe_margins < matlab.unittest.TestCase
    %TEST_R2_W1_TEXTFRAME_MARGINS  margins + vertical_anchor (R2-W1).

    methods (Test)
        function default_margins(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(7)); % blank-ish
            % add textbox shape if needed
            if s.shapes().length < 1
                sh = s.shapes().add_textbox(mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                    mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            else
                sh = s.shapes().item(1);
            end
            tf = sh.text_frame();
            tc.verifyEqual(double(tf.margin_left.emu), 91440);
            tc.verifyEqual(double(tf.margin_right.emu), 91440);
            tc.verifyEqual(double(tf.margin_top.emu), 45720);
            tc.verifyEqual(double(tf.margin_bottom.emu), 45720);
        end

        function set_margins_and_anchor(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_textbox(mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(1));
            tf = sh.text_frame();
            tf.margin_left = mat2ppt.util.Inches(0.1);
            tf.margin_top = 10000;
            tf.vertical_anchor = mat2ppt.enum.MSO_VERTICAL_ANCHOR.MIDDLE;
            tc.verifyEqual(double(tf.margin_left.emu), double(mat2ppt.util.Inches(0.1).emu));
            tc.verifyEqual(double(tf.margin_top.emu), 10000);
            tc.verifyEqual(tf.vertical_anchor.value, mat2ppt.enum.MSO_VERTICAL_ANCHOR.MIDDLE.value);
        end
    end
end
