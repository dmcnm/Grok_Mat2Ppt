classdef Test_p5_w1_shapes < matlab.unittest.TestCase
    % P5-W1: BaseShape name/id

    methods (Test)
        function nameGetSet(testCase)
            sp = mat2ppt.oxml.OxmlElement("p:sp");
            nv = mat2ppt.oxml.OxmlElement("p:nvSpPr");
            cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
            cNvPr.set("id", "2");
            cNvPr.set("name", "Rectangle 1");
            nv.append(cNvPr);
            sp.append(nv);
            parent = struct("part", "stub");
            sh = mat2ppt.shapes.BaseShape(sp, parent);
            testCase.verifyEqual(sh.name, "Rectangle 1");
            testCase.verifyEqual(sh.shape_id(), 2);
            sh.name = "Box";
            testCase.verifyEqual(sh.name, "Box");
            testCase.verifyEqual(string(cNvPr.get("name")), "Box");
        end
    end
end
