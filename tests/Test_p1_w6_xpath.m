classdef Test_p1_w6_xpath < matlab.unittest.TestCase
    % P1-W6: mini-XPath subset

    methods (Test)
        function directChildPrefixed(testCase)
            p = mat2ppt.oxml.OxmlElement("p:sp");
            t = mat2ppt.oxml.OxmlElement("a:t");
            t.text = "hi";
            p.append(t);
            r = mat2ppt.oxml.evaluate_xpath(p, "./a:t");
            testCase.verifyEqual(numel(r), 1);
            testCase.verifyEqual(r{1}.text, "hi");
        end

        function descendant(testCase)
            root = mat2ppt.oxml.OxmlElement("p:sld");
            mid = mat2ppt.oxml.OxmlElement("p:cSld");
            t = mat2ppt.oxml.OxmlElement("a:t");
            t.text = "x";
            mid.append(t);
            root.append(mid);
            r = mat2ppt.oxml.evaluate_xpath(root, ".//a:t");
            testCase.verifyEqual(numel(r), 1);
        end

        function attribute(testCase)
            e = mat2ppt.oxml.OxmlElement("p:sld");
            e.set("name", "Title");
            r = mat2ppt.oxml.evaluate_xpath(e, "@name");
            testCase.verifyEqual(numel(r), 1);
            testCase.verifyEqual(string(r{1}), "Title");
        end
    end
end
