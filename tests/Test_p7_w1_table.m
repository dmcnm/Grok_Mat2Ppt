classdef Test_p7_w1_table < matlab.unittest.TestCase
    % P7-W1: Table model + add_table package L1 (1-based cells)

    methods (Test)
        function tableApiOneBased(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            gf = s.shapes().add_table(2, 2, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(2));
            testCase.verifyTrue(gf.has_table());
            tbl = gf.table();
            testCase.verifyEqual(tbl.row_count(), 2);
            testCase.verifyEqual(tbl.column_count(), 2);
            tbl.cell(1, 1).text = "A1";
            tbl.cell(2, 2).text = "B2";
            testCase.verifyEqual(string(tbl.cell(1, 1).text), "A1");
            testCase.verifyEqual(string(tbl.cell(2, 2).text), "B2");
            testCase.verifyError(@() tbl.cell(0, 1), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() tbl.cell(1, 3), "mat2ppt:IndexOutOfRange");
        end

        function tablePackageL1(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            gf = s.shapes().add_table(2, 2, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(2));
            tbl = gf.table();
            tbl.cell(1, 1).text = "A1";
            tbl.cell(1, 2).text = "B1";
            tbl.cell(2, 1).text = "A2";
            tbl.cell(2, 2).text = "B2";
            prs.save(outPath);

            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p7_w1_table\oracle.pptx';
            testCase.verifyTrue(isfile(oracle));
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
            fprintf(1, "P7-W1 L1: %d / %d (diff %d)\n", numel(oKeys) - nDiff, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0);
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
