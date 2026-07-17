classdef Test_r4_action_setting < matlab.unittest.TestCase
    %TEST_R4_ACTION_SETTING  ActionSetting + hyperlink + named slide (R4).

    methods (Test)
        function hyperlink_address_on_shape(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            act = sh.click_action();
            tc.verifyEqual(act.action().value, mat2ppt.enum.PP_ACTION.NONE.value);
            act.hyperlink().address = "https://example.com/path";
            tc.verifyEqual(act.action().value, mat2ppt.enum.PP_ACTION.HYPERLINK.value);
            tc.verifyEqual(char(act.hyperlink().address), char("https://example.com/path"));
            act.hyperlink().address = [];
            tc.verifyEqual(act.action().value, mat2ppt.enum.PP_ACTION.NONE.value);
        end

        function named_slide_jump(tc)
            prs = mat2ppt.Presentation();
            s1 = prs.slides().add_slide(prs.slide_layouts().item(1));
            s2 = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s1.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            act = sh.click_action();
            act.set_target_slide(s2);
            tc.verifyEqual(act.action().value, mat2ppt.enum.PP_ACTION.NAMED_SLIDE.value);
            tgt = act.target_slide();
            tc.verifyEqual(char(tgt.partname()), char(s2.partname()));
            act.set_target_slide([]);
            tc.verifyEqual(act.action().value, mat2ppt.enum.PP_ACTION.NONE.value);
        end

        function group_click_action_errors(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            g = s.shapes().add_group_shape();
            tc.verifyError(@() g.click_action(), "mat2ppt:TypeError");
        end
    end
end
