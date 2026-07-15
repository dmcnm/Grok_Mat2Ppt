classdef Test_p6_w6_notes < matlab.unittest.TestCase
    % P6-W6: notes slide + placeholders

    methods (Test)
        function notesTextApi(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            testCase.verifyFalse(s.has_notes_slide());
            ns = s.notes_slide();
            testCase.verifyTrue(s.has_notes_slide());
            tf = ns.notes_text_frame();
            testCase.verifyFalse(isempty(tf));
            tf.text = "Hello notes";
            testCase.verifyEqual(string(tf.text), "Hello notes");
            % title slide placeholders present after layout clone
            titleLay = prs.slide_layouts().get_by_name("Title Slide");
            s2 = prs.slides().add_slide(titleLay);
            testCase.verifyGreaterThanOrEqual(s2.placeholders().length, 2);
        end

        function notesPackageL1(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            s.notes_slide().notes_text_frame().text = "Hello notes";
            prs.save(outPath);

            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p6_w6_notes\oracle.pptx';
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
            fprintf(1, "P6-W6 L1: %d / %d (diff %d)\n", nMatch, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0, sprintf("%d L1 diffs", nDiff));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
