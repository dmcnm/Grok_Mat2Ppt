classdef Test_p7_w4_image_metrics < matlab.unittest.TestCase
    % P7-W4: image metrics without Pillow

    methods (Test)
        function fixturePngMetrics(testCase)
            img = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w3_picture\fixture.png';
            testCase.assumeTrue(isfile(img));
            m = mat2ppt.util.ImageMetrics.from_file(img);
            testCase.verifyEqual(m.width_px, 100);
            testCase.verifyEqual(m.height_px, 50);
            testCase.verifyEqual(string(m.ext), "png");
            testCase.verifyEqual(string(m.content_type), "image/png");
            % 100 px @ 72 dpi => 914400 * 100 / 72 EMU
            testCase.verifyEqual(double(m.width_emu), floor(914400 * 100 / 72));
            testCase.verifyEqual(double(m.height_emu), floor(914400 * 50 / 72));
            [cx, cy, ext, ct] = mat2ppt.util.image_size_emu(img);
            testCase.verifyEqual(cx, m.width_emu);
            testCase.verifyEqual(cy, m.height_emu);
            testCase.verifyEqual(string(ext), m.ext);
            testCase.verifyEqual(string(ct), m.content_type);
        end

        function missingFileErrors(testCase)
            testCase.verifyError( ...
                @() mat2ppt.util.ImageMetrics.from_file("C:\no_such_image_zzz.png"), ...
                "mat2ppt:PackageNotFoundError");
        end
    end
end
