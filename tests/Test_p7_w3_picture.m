classdef Test_p7_w3_picture < matlab.unittest.TestCase
    % P7-W3: add_picture full package path

    methods (Test)
        function addPictureApi(testCase)
            img = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w3_picture\fixture.png';
            testCase.assumeTrue(isfile(img));
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            pic = s.shapes().add_picture(img, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            testCase.verifyEqual(string(pic.name), "Picture 1");
            testCase.verifyEqual(pic.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.PICTURE.value);
        end

        function addPicturePackageL1(testCase)
            img = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w3_picture\fixture.png';
            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w3_picture\oracle.pptx';
            testCase.assumeTrue(isfile(img) && isfile(oracle));
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            s.shapes().add_picture(img, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            prs.save(outPath);
            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            cMap = mat2ppt.opc.read_zip_blobs(outPath);
            oKeys = sort(oMap.keys);
            cKeys = sort(cMap.keys);
            testCase.verifyEqual(cKeys, oKeys, "L0 inventory");
            nDiff = 0;
            for i = 1:numel(oKeys)
                k = oKeys{i};
                if ~strcmp(mat2ppt.opc.sha256_hex_(oMap(k)), mat2ppt.opc.sha256_hex_(cMap(k)))
                    nDiff = nDiff + 1;
                    fprintf(1, "DIFF %s\n", k);
                end
            end
            fprintf(1, "P7-W3 L1: %d / %d (diff %d)\n", numel(oKeys) - nDiff, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0);
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
