classdef Test_r3_w2_add_group < matlab.unittest.TestCase
    %TEST_R3_W2_ADD_GROUP  add_group_shape + GroupShape.shapes (R3-W2).

    methods (Test)
        function empty_group(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            g = s.shapes().add_group_shape();
            tc.verifyClass(g, "mat2ppt.shapes.GroupShape");
            tc.verifyEqual(g.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.GROUP.value);
            tc.verifyEqual(g.shapes().length, 0);
        end

        function group_with_shapes(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh1 = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            sh2 = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.OVAL, ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(2), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            nBefore = s.shapes().length;
            g = s.shapes().add_group_shape({sh1, sh2});
            tc.verifyClass(g, "mat2ppt.shapes.GroupShape");
            tc.verifyEqual(g.shapes().length, 2);
            % originals reparented out of slide tree (count drops by 2, +1 group)
            tc.verifyEqual(s.shapes().length, nBefore - 2 + 1);
        end
    end
end
