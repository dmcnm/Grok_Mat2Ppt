classdef Test_oxml_tree < matlab.unittest.TestCase
    % P1-W3: XmlElement tree surface

    methods (Test)
        function createAndAppend(testCase)
            p = mat2ppt.oxml.OxmlElement("p:cSld");
            t = mat2ppt.oxml.OxmlElement("a:t");
            t.text = "hi";
            p.append(t);
            testCase.verifyEqual(p.childCount(), 1);
            testCase.verifyEqual(p.child(1).text, "hi");
            testCase.verifyEqual(p.child(1).getparent(), p);
        end

        function findDirectChild(testCase)
            p = mat2ppt.oxml.OxmlElement("p:cSld");
            t = mat2ppt.oxml.OxmlElement("a:t");
            p.append(t);
            f = p.find("a:t");
            testCase.verifyEqual(f, t);
            testCase.verifyTrue(isempty(p.find("a:r")));
        end

        function attrGetSet(testCase)
            e = mat2ppt.oxml.OxmlElement("a:off");
            e.set("x", "100");
            testCase.verifyEqual(string(e.get("x")), "100");
            testCase.verifyTrue(isempty(e.get("y")));
            testCase.verifyEqual(e.get("y", "0"), "0");
        end

        function textNoneVsEmpty(testCase)
            e = mat2ppt.oxml.OxmlElement("a:t");
            testCase.verifyTrue(mat2ppt.isAbsent(e.text));
            e.text = "";
            testCase.verifyFalse(mat2ppt.isAbsent(e.text));
            testCase.verifyEqual(e.text, "");
        end

        function removeChild(testCase)
            p = mat2ppt.oxml.OxmlElement("p:cSld");
            t = mat2ppt.oxml.OxmlElement("a:t");
            p.append(t);
            p.remove(t);
            testCase.verifyEqual(p.childCount(), 0);
            testCase.verifyTrue(isempty(t.getparent()));
        end

        function insertOneBased(testCase)
            p = mat2ppt.oxml.OxmlElement("p:spTree");
            a = mat2ppt.oxml.OxmlElement("a:t");
            a.text = "a";
            b = mat2ppt.oxml.OxmlElement("a:t");
            b.text = "b";
            p.append(b);
            p.insert(1, a);
            testCase.verifyEqual(p.child(1).text, "a");
            testCase.verifyEqual(p.child(2).text, "b");
        end
    end
end
