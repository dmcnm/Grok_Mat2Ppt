classdef Test_p7_w5_combined < matlab.unittest.TestCase
    % P7-W5: table + picture on one slide L1

    methods (Test)
        function combinedPackageL1(testCase)
            png = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w3_picture\fixture.png';
            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w5_combined\oracle.pptx';
            testCase.assumeTrue(isfile(png) && isfile(oracle));
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));

            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            gf = s.shapes().add_table(2, 2, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
            t = gf.table();
            t.cell(1, 1).text = "T";
            t.cell(2, 2).text = "X";
            s.shapes().add_picture(png, ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5), ...
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
            fprintf(1, "P7-W5 L1: %d / %d (diff %d)\n", numel(oKeys) - nDiff, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0);
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
