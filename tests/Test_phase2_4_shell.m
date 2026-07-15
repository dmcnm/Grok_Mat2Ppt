classdef Test_phase2_4_shell < matlab.unittest.TestCase
    % Thin Phase 2–4 shells: collection, enum, RGB, font, xpath

    methods (Test)
        function collectionItemAndParen(testCase)
            c = LocalStringCollection(["a", "b", "c"]);
            testCase.verifyEqual(c.length, 3);
            testCase.verifyEqual(c.item(1), "a");
            testCase.verifyEqual(c(2), "b");
            testCase.verifyError(@() c.item(0), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() c.item(4), "mat2ppt:IndexOutOfRange");
        end

        function enumMembers(testCase)
            a = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.LEFT;
            testCase.verifyEqual(a.value, 1);
            testCase.verifyEqual(string(a.name), "LEFT");
        end

        function rgbColor(testCase)
            c = mat2ppt.dml.RGBColor(255, 0, 0);
            testCase.verifyEqual(c.hex, "FF0000");
            c2 = mat2ppt.dml.RGBColor.from_string("00FF00");
            testCase.verifyEqual(c2.g, 255);
        end

        function fontAbsentDefaults(testCase)
            f = mat2ppt.text.Font();
            testCase.verifyTrue(mat2ppt.isAbsent(f.bold));
            f.bold = true;
            testCase.verifyTrue(f.bold);
            f.bold = [];
            testCase.verifyTrue(mat2ppt.isAbsent(f.bold));
        end

        function xpathDirectChild(testCase)
            p = mat2ppt.oxml.OxmlElement("p:sp");
            t = mat2ppt.oxml.OxmlElement("a:t");
            t.text = "x";
            p.append(t);
            r = mat2ppt.oxml.evaluate_xpath(p, "./a:t");
            testCase.verifyEqual(numel(r), 1);
            testCase.verifyEqual(r{1}.text, "x");
        end
    end
end
