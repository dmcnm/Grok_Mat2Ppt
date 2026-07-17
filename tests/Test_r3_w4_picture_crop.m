classdef Test_r3_w4_picture_crop < matlab.unittest.TestCase
    %TEST_R3_W4_PICTURE_CROP  Picture crop_* properties (R3-W4).

    methods (Test)
        function crop_roundtrip(tc)
            img = fullfile(fileparts(mfilename("fullpath")), "..", "examples", "sample_image.png");
            tc.assumeTrue(isfile(img), "sample_image.png missing");
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            pic = s.shapes().add_picture(img, mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            tc.verifyEqual(pic.crop_left, 0.0);
            pic.crop_left = 0.1;
            pic.crop_right = 0.2;
            pic.crop_top = 0.05;
            pic.crop_bottom = 0.15;
            tc.verifyEqual(pic.crop_left, 0.1, "AbsTol", 1e-6);
            tc.verifyEqual(pic.crop_right, 0.2, "AbsTol", 1e-6);
            tc.verifyEqual(pic.crop_top, 0.05, "AbsTol", 1e-6);
            tc.verifyEqual(pic.crop_bottom, 0.15, "AbsTol", 1e-6);
        end
    end
end
