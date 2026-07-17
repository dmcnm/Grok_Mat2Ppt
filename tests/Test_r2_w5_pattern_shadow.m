classdef Test_r2_w5_pattern_shadow < matlab.unittest.TestCase
    %TEST_R2_W5_PATTERN_SHADOW  patterned fill + ShadowFormat.inherit (R2-W5).

    methods (Test)
        function patterned_fill(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            fill = sh.fill();
            fill.patterned();
            tc.verifyEqual(fill.type().value, mat2ppt.enum.MSO_FILL.PATTERNED.value);
            cf = fill.fore_color();
            cf.rgb = mat2ppt.dml.RGBColor(0, 0, 255);
            tc.verifyEqual(char(cf.rgb.hex), char("0000FF"));
        end

        function shadow_inherit(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            shd = sh.shadow();
            tc.verifyTrue(shd.inherit);
            shd.inherit = false;
            tc.verifyFalse(shd.inherit);
            shd.inherit = true;
            tc.verifyTrue(shd.inherit);
        end
    end
end
