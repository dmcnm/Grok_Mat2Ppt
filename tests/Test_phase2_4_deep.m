classdef Test_phase2_4_deep < matlab.unittest.TestCase
    % Deep Phase 2–4: proxies, coreprops, enums, RGB, fonts

    methods (Test)
        function elementProxyEquality(testCase)
            e = mat2ppt.oxml.OxmlElement("a:t");
            p1 = mat2ppt.shared.ElementProxy(e);
            p2 = mat2ppt.shared.ElementProxy(e);
            p3 = mat2ppt.shared.ElementProxy(mat2ppt.oxml.OxmlElement("a:t"));
            testCase.verifyTrue(p1 == p2);
            testCase.verifyFalse(p1 == p3);
            testCase.verifyEqual(p1.element().tag, e.tag);
        end

        function corePropertiesReadWrite(testCase)
            prs = mat2ppt.Presentation();
            cp = prs.core_properties();
            testCase.verifyEqual(cp.comments, "generated using python-pptx");
            cp.author = "Mat2Ppt";
            testCase.verifyEqual(cp.author, "Mat2Ppt");
            cp.title = "Probe Title";
            testCase.verifyEqual(cp.title, "Probe Title");
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs.save(outPath);
            prs2 = mat2ppt.Presentation(outPath);
            cp2 = prs2.core_properties();
            testCase.verifyEqual(cp2.author, "Mat2Ppt");
            testCase.verifyEqual(cp2.title, "Probe Title");
        end

        function enumXmlRoundTrip(testCase)
            a = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.CENTER;
            testCase.verifyEqual(a.value, 2);
            testCase.verifyEqual(string(a.xml_value), "ctr");
            m = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.from_xml("l");
            testCase.verifyEqual(m.value, 1);
            x = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.to_xml(a);
            testCase.verifyEqual(string(x), "ctr");
            % alias
            testCase.verifyEqual(mat2ppt.enum.PP_ALIGN.LEFT.value, 1);
            testCase.verifyEqual(mat2ppt.enum.MSO_THEME_COLOR.ACCENT_1.value, ...
                mat2ppt.enum.MSO_THEME_COLOR_INDEX.ACCENT_1.value);
        end

        function shapeEnumPresent(testCase)
            s = mat2ppt.enum.MSO_SHAPE.RECTANGLE;
            testCase.verifyTrue(isa(s, "mat2ppt.enum.BaseXmlEnum"));
            testCase.verifyGreaterThan(s.value, 0);
        end

        function rgbValidation(testCase)
            c = mat2ppt.dml.RGBColor(12, 34, 56);
            testCase.verifyEqual(c.hex, "0C2238");
            testCase.verifyEqual(string(char(c)), "0C2238");
            testCase.verifyError(@() mat2ppt.dml.RGBColor(1.5, 0, 0), "mat2ppt:ValueError");
            testCase.verifyError(@() mat2ppt.dml.RGBColor(-1, 0, 0), "mat2ppt:ValueError");
        end

        function fontFilesRegister(testCase)
            mat2ppt.text.FontFiles.clear();
            tmp = [tempname() '.ttf'];
            % minimal invalid file should fail open; register requires isfile
            fid = fopen(tmp, "w"); fwrite(fid, uint8(0)); fclose(fid);
            cleaner = onCleanup(@() delete_if_(tmp));
            mat2ppt.text.FontFiles.register("Dummy", false, false, tmp);
            p = mat2ppt.text.FontFiles.find("Dummy", false, false);
            testCase.verifyEqual(string(p), string(tmp));
            testCase.verifyError(@() mat2ppt.text.FontFiles.find("Missing", true, false), ...
                "mat2ppt:KeyError");
        end

        function simpletypesBooleanAndCoord(testCase)
            testCase.verifyTrue(mat2ppt.oxml.simpletypes.XsdBoolean.from_xml("1"));
            testCase.verifyEqual(string(mat2ppt.oxml.simpletypes.XsdBoolean.to_xml(false)), "0");
            e = mat2ppt.oxml.simpletypes.ST_Coordinate.from_xml("914400");
            testCase.verifyEqual(e.inches, 1, "AbsTol", 1e-9);
            s = mat2ppt.oxml.simpletypes.ST_Coordinate.to_xml(mat2ppt.util.Inches(1));
            testCase.verifyEqual(string(s), "914400");
        end

        function fillAndLineShells(testCase)
            f = mat2ppt.dml.FillFormat();
            f.solid();
            testCase.verifyEqual(f.type().value, mat2ppt.enum.MSO_FILL.SOLID.value);
            f.set_fore_color_rgb(mat2ppt.dml.RGBColor(255, 0, 0));
            testCase.verifyEqual(f.fore_color_rgb().hex, "FF0000");
            ln = mat2ppt.dml.LineFormat();
            ln.width = mat2ppt.util.Pt(2);
            testCase.verifyEqual(ln.width.pt, 2, "AbsTol", 1e-9);
        end

        function m1StillHolds(testCase)
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs = mat2ppt.Presentation();
            prs.save(outPath);
            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\m1_default_open_save\oracle.pptx';
            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            cMap = mat2ppt.opc.read_zip_blobs(outPath);
            oKeys = sort(oMap.keys);
            nMatch = 0;
            for i = 1:numel(oKeys)
                k = oKeys{i};
                if isKey(cMap, k) && strcmp(mat2ppt.opc.sha256_hex_(oMap(k)), mat2ppt.opc.sha256_hex_(cMap(k)))
                    nMatch = nMatch + 1;
                end
            end
            testCase.verifyEqual(nMatch, numel(oKeys));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
