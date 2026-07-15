classdef Test_p10_w1_showcase < matlab.unittest.TestCase
    % P10-W1: multi-feature showcase deck (structural inventory + API)

    properties (Constant)
        RefDir = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\p10_w1_showcase'
    end

    methods (Test)
        function showcaseBuildsAndInventory(testCase)
            png = fullfile(Test_p10_w1_showcase.RefDir, 'fixture.png');
            testCase.assumeTrue(isfile(png));
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_p10_w1_showcase.delete_quiet_(outPath));

            prs = Test_p10_w1_showcase.build_showcase_(png);
            testCase.verifyEqual(prs.slides().length, 6);
            prs.save(outPath);

            blobs = mat2ppt.opc.read_zip_blobs(outPath);
            keys = string(blobs.keys);
            % six slides
            for i = 1:6
                testCase.verifyTrue(any(keys == sprintf("ppt/slides/slide%d.xml", i)), ...
                    sprintf("missing slide%d", i));
            end
            testCase.verifyTrue(any(keys == "ppt/charts/chart1.xml"));
            testCase.verifyTrue(any(contains(keys, "Microsoft_Excel_Sheet")));
            testCase.verifyTrue(any(contains(keys, "ppt/media/image")));
            testCase.verifyTrue(any(contains(keys, "notesSlide")));
            % chart content
            chartXml = string(native2unicode(blobs("ppt/charts/chart1.xml"), "UTF-8"));
            testCase.verifyTrue(contains(chartXml, "Sales") || contains(chartXml, "barChart"));
            % hyperlink external rel on slide 6
            rel6 = "ppt/slides/_rels/slide6.xml.rels";
            testCase.verifyTrue(any(keys == rel6));
            relXml = string(native2unicode(blobs(rel6), "UTF-8"));
            testCase.verifyTrue(contains(relXml, "example.com") || contains(relXml, "hyperlink"));
        end

        function showcaseOracleL0Structural(testCase)
            % L0: same part *kinds* as frozen python oracle (ignore embedding SHA / D-xlsx).
            png = fullfile(Test_p10_w1_showcase.RefDir, 'fixture.png');
            oracle = fullfile(Test_p10_w1_showcase.RefDir, 'oracle.pptx');
            testCase.assumeTrue(isfile(png) && isfile(oracle));
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_p10_w1_showcase.delete_quiet_(outPath));
            prs = Test_p10_w1_showcase.build_showcase_(png);
            prs.save(outPath);

            oKeys = string(sort(mat2ppt.opc.read_zip_blobs(oracle).keys));
            cKeys = string(sort(mat2ppt.opc.read_zip_blobs(outPath).keys));
            % Normalize: ignore zip order; require critical prefixes present in both
            need = [ ...
                "ppt/slides/slide1.xml", "ppt/slides/slide2.xml", "ppt/slides/slide3.xml", ...
                "ppt/slides/slide4.xml", "ppt/slides/slide5.xml", "ppt/slides/slide6.xml", ...
                "ppt/charts/chart1.xml" ...
                ];
            for i = 1:numel(need)
                testCase.verifyTrue(any(oKeys == need(i)), "oracle missing " + need(i));
                testCase.verifyTrue(any(cKeys == need(i)), "candidate missing " + need(i));
            end
            testCase.verifyTrue(any(contains(oKeys, "Microsoft_Excel_Sheet")));
            testCase.verifyTrue(any(contains(cKeys, "Microsoft_Excel_Sheet")));
            testCase.verifyTrue(any(contains(oKeys, "ppt/media/image")));
            testCase.verifyTrue(any(contains(cKeys, "ppt/media/image")));
            testCase.verifyTrue(any(contains(oKeys, "notesSlide")));
            testCase.verifyTrue(any(contains(cKeys, "notesSlide")));
            fprintf(1, "P10-W1 L0 structural: oracle parts=%d cand parts=%d\n", ...
                numel(oKeys), numel(cKeys));
        end
    end

    methods (Static)
        function prs = build_showcase_(pngPath)
            prs = mat2ppt.Presentation();
            % 1 Title
            titleLay = prs.slide_layouts().get_by_name("Title Slide");
            s1 = prs.slides().add_slide(titleLay);
            s1.shapes().item(1).text_frame().text = "Mat2Ppt Showcase";
            s1.shapes().item(2).text_frame().text = "python-pptx parity campaign";

            blank = prs.slide_layouts().get_by_name("Blank");

            % 2 Shapes
            s2 = prs.slides().add_slide(blank);
            s2.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            tb = s2.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(2.5), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            tb.text_frame().text = "Shapes and text";

            % 3 Table + picture
            s3 = prs.slides().add_slide(blank);
            gf = s3.shapes().add_table(2, 2, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
            t = gf.table();
            t.cell(1, 1).text = "T";
            t.cell(2, 2).text = "X";
            s3.shapes().add_picture(pngPath, ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));

            % 4 Chart
            s4 = prs.slides().add_slide(blank);
            data = mat2ppt.chart.CategoryChartData();
            data.set_categories({"East", "West"});
            data.add_series("Sales", [1.2, 2.3]);
            s4.shapes().add_chart( ...
                mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(6), mat2ppt.util.Inches(4), data);

            % 5 Notes
            s5 = prs.slides().add_slide(blank);
            s5.notes_slide().notes_text_frame().text = "Speaker notes for showcase";

            % 6 Hyperlink
            s6 = prs.slides().add_slide(blank);
            tb6 = s6.shapes().add_textbox( ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1));
            paras = tb6.text_frame().paragraphs();
            p = paras{1};
            p.clear_content();
            r = p.add_run();
            r.text = "Click me";
            r.hyperlink().address = "https://example.com/";
        end

        function delete_quiet_(path)
            if isfile(path)
                try, delete(path); catch, end
            end
        end
    end
end
