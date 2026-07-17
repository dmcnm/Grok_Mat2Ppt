classdef Test_r7_ole < matlab.unittest.TestCase
    %TEST_R7_OLE  add_ole_object + ole_format (R7 DEF-010b/011).

    methods (Test)
        function add_ole_xlsx_icon_and_package(tc)
            xlsxPath = Test_r7_ole.fake_xlsx_path_();
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_ole_object(xlsxPath, mat2ppt.enum.PROG_ID.XLSX, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            tc.verifyEqual(sh.shape_type().value, ...
                mat2ppt.enum.MSO_SHAPE_TYPE.EMBEDDED_OLE_OBJECT.value);
            of = sh.ole_format();
            tc.verifyEqual(char(of.prog_id()), 'Excel.Sheet.12');
            tc.verifyTrue(of.show_as_icon());

            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_r7_ole.delete_if_(outPath));
            prs.save(char(outPath));
            m = mat2ppt.opc.read_zip_blobs(outPath);
            keys = m.keys;
            hasEmbed = false;
            hasIcon = false;
            for i = 1:numel(keys)
                k = string(keys{i});
                if contains(k, "embeddings")
                    hasEmbed = true;
                end
                if contains(k, "ppt/media/")
                    hasIcon = true;
                end
            end
            tc.verifyTrue(hasEmbed, "embedding part");
            tc.verifyTrue(hasIcon, "icon media part");

            srel = "";
            for i = 1:numel(keys)
                if endsWith(string(keys{i}), "slide1.xml.rels")
                    b = m(keys{i});
                    if isnumeric(b)
                        srel = string(native2unicode(uint8(b(:))', "UTF-8"));
                    else
                        srel = string(b);
                    end
                    break
                end
            end
            tc.verifyTrue(contains(srel, "relationships/package") || ...
                contains(srel, "relationships/oleObject"));
        end

        function ole_format_errors_on_non_ole(tc)
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            sh = s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(0.5), mat2ppt.util.Inches(0.5), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            % rectangle is not GraphicFrame — only GF has ole_format
            gf = s.shapes().add_table(2, 2, ...
                mat2ppt.util.Inches(2), mat2ppt.util.Inches(2), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(2));
            tc.verifyError(@() gf.ole_format(), "mat2ppt:ValueError");
        end
    end

    methods (Static, Access = private)
        function p = fake_xlsx_path_()
            p = fullfile(tempdir, "fake_embed.xlsx");
            fid = fopen(p, "wb");
            % minimal zip-like blob (not a real xlsx — package tests structural only)
            fwrite(fid, uint8(['PK', 3, 4, zeros(1, 40), 'mat2ppt-r7-ole']), "uint8");
            fclose(fid);
        end

        function delete_if_(p)
            if isfile(p), delete(p); end
        end
    end
end
