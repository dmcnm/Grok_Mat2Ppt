classdef Test_r9_residual_showcase < matlab.unittest.TestCase
    %TEST_R9_RESIDUAL_SHOWCASE  Residual deck covering R3–R7 surfaces (R9-W1).

    methods (Test)
        function residual_showcase_save_l0(tc)
            prs = mat2ppt.Presentation();
            blank = prs.slide_layouts().item(7); % Blank often 7; fall back item 1
            try
                blank = prs.slide_layouts().get_by_name("Blank");
            catch
                blank = prs.slide_layouts().item(1);
            end

            % Slide 1: connector + freeform + action
            s1 = prs.slides().add_slide(blank);
            s1.shapes().add_connector(mat2ppt.enum.MSO_CONNECTOR.STRAIGHT, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(2));
            b = s1.shapes().build_freeform(0, 0, 1.0);
            b.add_line_segments([1000000 0; 500000 1000000], true);
            b.convert_to_shape(mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5));
            sh = s1.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(3), ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(0.8));
            sh.click_action().hyperlink().address = "https://example.com";

            % Slide 2: area chart residual
            s2 = prs.slides().add_slide(blank);
            cd = mat2ppt.chart.CategoryChartData();
            cd.set_categories({"A", "B", "C"});
            cd.add_series("S1", [1, 2, 3]);
            s2.shapes().add_chart(mat2ppt.enum.XL_CHART_TYPE.AREA, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(6), mat2ppt.util.Inches(4), cd);

            % Slide 3: movie (fake mp4)
            s3 = prs.slides().add_slide(blank);
            moviePath = fullfile(tempdir, "r9_fake.mp4");
            fid = fopen(moviePath, "wb");
            fwrite(fid, uint8([0 0 0 18, uint8('ftyp'), uint8('mp42'), uint8(1:20)]), "uint8");
            fclose(fid);
            s3.shapes().add_movie(moviePath, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(3), ...
                [], mat2ppt.opc.CONTENT_TYPE.MP4);

            % Slide 4: OLE
            s4 = prs.slides().add_slide(blank);
            xlsxPath = fullfile(tempdir, "r9_fake.xlsx");
            fid = fopen(xlsxPath, "wb");
            fwrite(fid, uint8(['PK', 3, 4, zeros(1, 20)]), "uint8");
            fclose(fid);
            s4.shapes().add_ole_object(xlsxPath, mat2ppt.enum.PROG_ID.XLSX, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));

            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_r9_residual_showcase.delete_if_(outPath));
            prs.save(char(outPath));
            tc.verifyTrue(isfile(outPath));
            m = mat2ppt.opc.read_zip_blobs(outPath);
            keys = string(m.keys);
            tc.verifyTrue(any(contains(keys, "ppt/slides/slide")), "slides present");
            tc.verifyTrue(any(contains(keys, "ppt/charts")) || any(contains(keys, "chart")), ...
                "chart part");
            tc.verifyTrue(any(contains(keys, "ppt/media/media")), "movie media");
            tc.verifyTrue(any(contains(keys, "embeddings")), "ole embedding");
            fprintf(1, "R9 residual showcase parts: %d\n", numel(keys));
        end
    end

    methods (Static, Access = private)
        function delete_if_(p)
            if isfile(p), delete(p); end
        end
    end
end
