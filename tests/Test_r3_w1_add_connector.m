classdef Test_r3_w1_add_connector < matlab.unittest.TestCase
    %TEST_R3_W1_ADD_CONNECTOR  SlideShapes.add_connector + begin/end (R3-W1).

    methods (Test)
        function add_straight_connector(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            cxn = s.shapes().add_connector( ...
                mat2ppt.enum.MSO_CONNECTOR.STRAIGHT, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(2));
            tc.verifyClass(cxn, "mat2ppt.shapes.Connector");
            tc.verifyEqual(cxn.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.LINE.value);
            tc.verifyEqual(double(cxn.begin_x.emu), double(mat2ppt.util.Inches(1).emu));
            tc.verifyEqual(double(cxn.begin_y.emu), double(mat2ppt.util.Inches(1).emu));
            tc.verifyEqual(double(cxn.end_x.emu), double(mat2ppt.util.Inches(3).emu));
            tc.verifyEqual(double(cxn.end_y.emu), double(mat2ppt.util.Inches(2).emu));
        end

        function flipped_connector_endpoints(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            % begin to the right/below of end → flipH/flipV
            cxn = s.shapes().add_connector( ...
                mat2ppt.enum.MSO_CONNECTOR.STRAIGHT, ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(3), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            tc.verifyEqual(double(cxn.begin_x.emu), double(mat2ppt.util.Inches(4).emu));
            tc.verifyEqual(double(cxn.begin_y.emu), double(mat2ppt.util.Inches(3).emu));
            tc.verifyEqual(double(cxn.end_x.emu), double(mat2ppt.util.Inches(1).emu));
            tc.verifyEqual(double(cxn.end_y.emu), double(mat2ppt.util.Inches(1).emu));
        end
    end
end
