classdef Test_p4_dml_text < matlab.unittest.TestCase
    % Phase 4: dml + text stack formal gates

    methods (Test)
        function rgbAndFillLine(testCase)
            c = mat2ppt.dml.RGBColor.from_string("AABBCC");
            testCase.verifyEqual(c.hex, "AABBCC");
            f = mat2ppt.dml.FillFormat();
            f.solid();
            f.set_fore_color_rgb(c);
            testCase.verifyEqual(f.fore_color_rgb().hex, "AABBCC");
            ln = mat2ppt.dml.LineFormat();
            ln.width = mat2ppt.util.Pt(1.5);
            testCase.verifyEqual(ln.width.pt, 1.5, "AbsTol", 1e-6);
            ln.dash_style = mat2ppt.enum.MSO_LINE.DASH;
            testCase.verifyEqual(ln.dash_style.value, mat2ppt.enum.MSO_LINE.DASH.value);
        end

        function fontBag(testCase)
            f = mat2ppt.text.Font();
            testCase.verifyTrue(mat2ppt.isAbsent(f.bold));
            f.bold = true;
            f.name = "Calibri";
            f.size = mat2ppt.util.Pt(12);
            testCase.verifyTrue(f.bold);
            testCase.verifyEqual(string(f.name), "Calibri");
        end

        function fontFilesB1(testCase)
            mat2ppt.text.FontFiles.clear();
            tmp = [tempname() '.ttf'];
            fid = fopen(tmp, "w"); fwrite(fid, uint8(0:10)); fclose(fid);
            cleaner = onCleanup(@() delete_if_(tmp));
            mat2ppt.text.FontFiles.register("TestFace", false, false, tmp);
            testCase.verifyEqual(string(mat2ppt.text.FontFiles.find("TestFace", false, false)), string(tmp));
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
