classdef Test_r2_w2_auto_size_fit < matlab.unittest.TestCase
    %TEST_R2_W2_AUTO_SIZE_FIT  TextFrame.auto_size + fit_text (R2-W2).

    methods (Test)
        function auto_size_set_get(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_textbox(mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(1));
            tf = sh.text_frame();
            % new textboxes often ship with spAutoFit; clear first
            tf.auto_size = [];
            tc.verifyTrue(isempty(tf.auto_size));
            tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.NONE;
            tc.verifyEqual(tf.auto_size.value, mat2ppt.enum.MSO_AUTO_SIZE.NONE.value);
            tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.TEXT_TO_FIT_SHAPE;
            tc.verifyEqual(tf.auto_size.value, mat2ppt.enum.MSO_AUTO_SIZE.TEXT_TO_FIT_SHAPE.value);
            tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
            tc.verifyEqual(tf.auto_size.value, mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT.value);
            tf.auto_size = [];
            tc.verifyTrue(isempty(tf.auto_size));
        end

        function fit_text_with_registered_font(tc)
            % Use a real TTF if available under Windows Fonts
            fontDir = "C:\Windows\Fonts";
            candidates = ["arial.ttf", "calibri.ttf", "segoeui.ttf"];
            fontPath = "";
            for i = 1:numel(candidates)
                p = fullfile(fontDir, candidates(i));
                if isfile(p)
                    fontPath = p;
                    break
                end
            end
            tc.assumeTrue(strlength(fontPath) > 0, "No system TTF found for fit_text test");
            mat2ppt.text.FontFiles.clear();
            mat2ppt.text.FontFiles.register("TestFitFace", false, false, fontPath);

            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_textbox(mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1.5));
            tf = sh.text_frame();
            tf.text = "Hello fit text";
            tf.fit_text("TestFitFace", 24, false, false, []);
            tc.verifyEqual(tf.auto_size.value, mat2ppt.enum.MSO_AUTO_SIZE.NONE.value);
            tc.verifyTrue(logical(tf.word_wrap));
            ps = tf.paragraphs();
            rs = ps{1}.runs();
            tc.verifyGreaterThan(numel(rs), 0);
            f = rs{1}.font();
            tc.verifyEqual(char(string(f.name)), char("TestFitFace"));
            tc.verifyFalse(isempty(f.size));
            tc.verifyLessThanOrEqual(double(f.size.pt), 24);
        end
    end
end
