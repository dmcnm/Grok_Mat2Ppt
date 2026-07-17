classdef Test_r1_w3_slide_props < matlab.unittest.TestCase
    %TEST_R1_W3_SLIDE_PROPS  slide_id, slide_layout, follow_master_background (R1-W3).

    methods (Test)
        function slide_id_and_layout(tc)
            prs = mat2ppt.Presentation();
            layout = prs.slide_layouts().item(1);
            s = prs.slides().add_slide(layout);
            id = s.slide_id();
            tc.verifyGreaterThanOrEqual(id, 256);
            lay = s.slide_layout();
            tc.verifyClass(lay, "mat2ppt.slide.SlideLayout");
            tc.verifyEqual(char(lay.partname()), char(layout.partname()));
        end

        function follow_master_background_default_true(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            tc.verifyTrue(s.follow_master_background());
        end
    end
end
