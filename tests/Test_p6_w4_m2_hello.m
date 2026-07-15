classdef Test_p6_w4_m2_hello < matlab.unittest.TestCase
    % P6-W4 / M2: title slide + title text + textbox + L1 vs python-pptx oracle

    methods (Test)
        function helloWorldApi(testCase)
            prs = mat2ppt.Presentation();
            layout = prs.slide_layouts().get_by_name("Title Slide");
            s = prs.slides().add_slide(layout);
            testCase.verifyEqual(s.shapes().length, 2);  % title + subtitle only
            s.shapes().item(1).text_frame().text = "Hello Title";
            s.shapes().item(2).text_frame().text = "Hello Sub";
            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(4), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(1));
            tb.text_frame().text = "Textbox body";
            testCase.verifyEqual(string(s.shapes().item(1).text_frame().text), "Hello Title");
            testCase.verifyEqual(string(tb.text_frame().text), "Textbox body");
            testCase.verifyEqual(s.shapes().length, 3);
        end

        function helloWorldL1Parts(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));

            prs = mat2ppt.Presentation();
            layout = prs.slide_layouts().get_by_name("Title Slide");
            s = prs.slides().add_slide(layout);
            s.shapes().item(1).text_frame().text = "Hello Title";
            s.shapes().item(2).text_frame().text = "Hello Sub";
            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(4), ...
                mat2ppt.util.Inches(5), mat2ppt.util.Inches(1));
            tb.text_frame().text = "Textbox body";
            prs.save(outPath);

            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\m2_hello_world\oracle.pptx';
            testCase.verifyTrue(isfile(oracle), "M2 oracle missing — freeze with python-pptx");

            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            cMap = mat2ppt.opc.read_zip_blobs(outPath);
            oKeys = sort(oMap.keys);
            cKeys = sort(cMap.keys);
            % L0 inventory may grow if we omit parts python includes — report diffs
            nMatch = 0;
            nDiff = 0;
            common = intersect(oKeys, cKeys);
            for i = 1:numel(common)
                k = common{i};
                oh = mat2ppt.opc.sha256_hex_(oMap(k));
                ch = mat2ppt.opc.sha256_hex_(cMap(k));
                if strcmp(oh, ch)
                    nMatch = nMatch + 1;
                else
                    nDiff = nDiff + 1;
                    fprintf(1, "DIFF %s\n", k);
                end
            end
            onlyO = setdiff(oKeys, cKeys);
            onlyC = setdiff(cKeys, oKeys);
            for i = 1:numel(onlyO)
                fprintf(1, "ONLY_ORACLE %s\n", onlyO{i});
            end
            for i = 1:numel(onlyC)
                fprintf(1, "ONLY_CANDIDATE %s\n", onlyC{i});
            end
            fprintf(1, "M2 L1 parts identical: %d / %d common (diff %d); onlyO=%d onlyC=%d\n", ...
                nMatch, numel(common), nDiff, numel(onlyO), numel(onlyC));
            % Soft gate for first land: require inventory match + high identity;
            % full 100% L1 may need D#s — assert inventory equality first.
            testCase.verifyEqual(cKeys, oKeys, "M2 L0 part inventory must match oracle");
            testCase.verifyEqual(nDiff, 0, ...
                sprintf("M2 L1 requires all parts byte-identical; %d diffs of %d", nDiff, numel(common)));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
