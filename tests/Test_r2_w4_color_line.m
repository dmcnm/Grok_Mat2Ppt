classdef Test_r2_w4_color_line < matlab.unittest.TestCase
    %TEST_R2_W4_COLOR_LINE  theme_color, brightness, LineFormat.color (R2-W4).

    methods (Test)
        function theme_color_and_brightness(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            fill = sh.fill();
            fill.solid();
            cf = fill.fore_color();
            cf.theme_color = mat2ppt.enum.MSO_THEME_COLOR.ACCENT_1;
            tc.verifyEqual(cf.type().value, mat2ppt.enum.MSO_COLOR_TYPE.SCHEME.value);
            tc.verifyEqual(cf.theme_color.value, mat2ppt.enum.MSO_THEME_COLOR.ACCENT_1.value);
            cf.brightness = 0.25;
            tc.verifyEqual(cf.brightness, 0.25, "AbsTol", 1e-6);
            cf.brightness = -0.3;
            tc.verifyEqual(cf.brightness, -0.3, "AbsTol", 1e-6);
            cf.brightness = 0;
            tc.verifyEqual(cf.brightness, 0, "AbsTol", 1e-9);
        end

        function line_color_solid_side_effect(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            ln = sh.line();
            c = ln.color();
            c.rgb = mat2ppt.dml.RGBColor(255, 0, 0);
            tc.verifyEqual(char(c.rgb.hex), char("FF0000"));
            f = ln.fill();
            tc.verifyEqual(f.type().value, mat2ppt.enum.MSO_FILL.SOLID.value);
            ln.width = mat2ppt.util.Pt(2);
            tc.verifyGreaterThan(double(ln.width.emu), 0);
        end
    end
end
