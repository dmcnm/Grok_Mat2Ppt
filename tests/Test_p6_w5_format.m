classdef Test_p6_w5_format < matlab.unittest.TestCase
    % P6-W5 / DEF-007: shape fill + run font bold/size/color package L1

    methods (Test)
        function formatApi(testCase)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            sh.fill().solid();
            sh.fill().set_fore_color_rgb(mat2ppt.dml.RGBColor(255, 0, 0));
            testCase.verifyEqual(sh.fill().fore_color_rgb().hex, "FF0000");

            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(3), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            p = tb.text_frame().paragraphs();
            p = p{1};
            p.clear_content();
            r = p.add_run();
            r.text = "Format me";
            f = r.font();
            f.bold = true;
            f.size = mat2ppt.util.Pt(18);
            f.color().rgb = mat2ppt.dml.RGBColor(0, 0, 255);
            testCase.verifyTrue(f.bold);
            testCase.verifyEqual(round(f.size.pt), 18);
            testCase.verifyEqual(f.color().rgb.hex, "0000FF");
        end

        function formatPackageL1(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));

            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().get_by_name("Blank");
            s = prs.slides().add_slide(blank);
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            sh.fill().solid();
            sh.fill().set_fore_color_rgb(mat2ppt.dml.RGBColor(255, 0, 0));
            tb = s.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(3), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            p = tb.text_frame().paragraphs();
            p = p{1};
            p.clear_content();
            r = p.add_run();
            r.text = "Format me";
            f = r.font();
            f.bold = true;
            f.size = mat2ppt.util.Pt(18);
            f.color().rgb = mat2ppt.dml.RGBColor(0, 0, 255);
            prs.save(outPath);

            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p6_w5_format\oracle.pptx';
            testCase.verifyTrue(isfile(oracle));
            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            cMap = mat2ppt.opc.read_zip_blobs(outPath);
            oKeys = sort(oMap.keys);
            cKeys = sort(cMap.keys);
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
            fprintf(1, "P6-W5 L1: %d / %d (diff %d)\n", nMatch, numel(oKeys), nDiff);
            testCase.verifyEqual(nDiff, 0, sprintf("%d L1 part diffs", nDiff));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
