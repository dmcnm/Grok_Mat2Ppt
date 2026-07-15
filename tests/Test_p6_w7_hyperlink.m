classdef Test_p6_w7_hyperlink < matlab.unittest.TestCase
    % P6-W7: run hyperlink address + package L1

    methods (Test)
        function hyperlinkApi(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            p = tb.text_frame().paragraphs();
            p = p{1};
            p.clear_content();
            r = p.add_run();
            r.text = "Click me";
            r.hyperlink().address = "https://example.com/";
            testCase.verifyEqual(string(r.hyperlink().address), "https://example.com/");
        end

        function hyperlinkPackageL1(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            p = tb.text_frame().paragraphs();
            p = p{1};
            p.clear_content();
            r = p.add_run();
            r.text = "Click me";
            r.hyperlink().address = "https://example.com/";
            prs.save(outPath);

            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p6_w7_hyperlink\oracle.pptx';
            testCase.verifyTrue(isfile(oracle));
            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            cMap = mat2ppt.opc.read_zip_blobs(outPath);
            oKeys = sort(oMap.keys);
            cKeys = sort(cMap.keys);
            onlyO = setdiff(oKeys, cKeys);
            onlyC = setdiff(cKeys, oKeys);
            for i = 1:numel(onlyO), fprintf(1, "ONLY_ORACLE %s\n", onlyO{i}); end
            for i = 1:numel(onlyC), fprintf(1, "ONLY_CAND %s\n", onlyC{i}); end
            testCase.verifyEqual(cKeys, oKeys, "L0 inventory");
            nMatch = 0; nDiff = 0;
            for i = 1:numel(oKeys)
                k = oKeys{i};
                if strcmp(mat2ppt.opc.sha256_hex_(oMap(k)), mat2ppt.opc.sha256_hex_(cMap(k)))
                    nMatch = nMatch + 1;
                else
                    nDiff = nDiff + 1;
                    fprintf(1, "DIFF %s\n", k);
                end
            end
            fprintf(1, "P6-W7 L1: %d / %d (diff %d)\n", nMatch, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0, sprintf("%d L1 diffs", nDiff));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
