classdef Test_r3_w5_placeholders_title < matlab.unittest.TestCase
    %TEST_R3_W5_PLACEHOLDERS_TITLE  SlideShapes.placeholders / title (R3-W5).

    methods (Test)
        function title_on_title_layout(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            tit = s.shapes().title();
            tc.verifyFalse(isempty(tit));
            phs = s.shapes().placeholders();
            tc.verifyGreaterThanOrEqual(phs.length, 1);
        end
    end
end
