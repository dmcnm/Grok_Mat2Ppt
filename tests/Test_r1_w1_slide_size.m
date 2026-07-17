classdef Test_r1_w1_slide_size < matlab.unittest.TestCase
    %TEST_R1_W1_SLIDE_SIZE  Presentation.slide_width / slide_height (R1-W1).
    % Source: python-pptx presentation.py::Presentation.slide_width/height

    methods (Test)
        function default_template_has_standard_size(tc)
            prs = mat2ppt.Presentation();
            w = prs.slide_width;
            h = prs.slide_height;
            tc.verifyFalse(isempty(w));
            tc.verifyFalse(isempty(h));
            tc.verifyEqual(double(w.emu), 9144000);
            tc.verifyEqual(double(h.emu), 6858000);
        end

        function set_widescreen_and_read_back(tc)
            prs = mat2ppt.Presentation();
            prs.slide_width = mat2ppt.util.Inches(13.333);
            prs.slide_height = mat2ppt.util.Inches(7.5);
            tc.verifyEqual(double(prs.slide_width.emu), 12191695); % floor from Inches
            tc.verifyEqual(double(prs.slide_height.emu), 6858000);
        end

        function set_with_numeric_emu(tc)
            prs = mat2ppt.Presentation();
            prs.slide_width = 10000000;
            prs.slide_height = 5000000;
            tc.verifyEqual(double(prs.slide_width.emu), 10000000);
            tc.verifyEqual(double(prs.slide_height.emu), 5000000);
        end
    end
end
