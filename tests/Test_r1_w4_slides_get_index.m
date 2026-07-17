classdef Test_r1_w4_slides_get_index < matlab.unittest.TestCase
    %TEST_R1_W4_SLIDES_GET_INDEX  Slides.get / index (1-based) (R1-W4).

    methods (Test)
        function get_by_slide_id(tc)
            prs = mat2ppt.Presentation();
            lay = prs.slide_layouts().item(1);
            s1 = prs.slides().add_slide(lay);
            s2 = prs.slides().add_slide(lay);
            id1 = s1.slide_id();
            id2 = s2.slide_id();
            g1 = prs.slides().get(id1);
            g2 = prs.slides().get(id2);
            tc.verifyEqual(char(g1.partname()), char(s1.partname()));
            tc.verifyEqual(char(g2.partname()), char(s2.partname()));
            miss = prs.slides().get(999999, []);
            tc.verifyTrue(isempty(miss));
        end

        function index_is_one_based(tc)
            prs = mat2ppt.Presentation();
            lay = prs.slide_layouts().item(1);
            s1 = prs.slides().add_slide(lay);
            s2 = prs.slides().add_slide(lay);
            slides = prs.slides();
            tc.verifyEqual(slides.index(s1), 1);
            tc.verifyEqual(slides.index(s2), 2);
        end
    end
end
