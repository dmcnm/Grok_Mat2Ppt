classdef Test_p1_w7_xmlchemy < matlab.unittest.TestCase
    % P1-W7: registry, BaseOxmlElement, opc CT_*, simpletypes M1 subset

    methods (Test)
        function registerAndLookup(testCase)
            mat2ppt.oxml.register_opc_element_classes();
            cls = mat2ppt.oxml.element_class_for_tag("pr:Relationship");
            testCase.verifyEqual(string(cls), "mat2ppt.oxml.CT_Relationship");
        end

        function relationshipAttrs(testCase)
            r = mat2ppt.oxml.CT_Relationship.new( ...
                "rId1", ...
                "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", ...
                "slides/slide1.xml");
            testCase.verifyEqual(string(r.rId), "rId1");
            testCase.verifyEqual(string(r.targetMode), "Internal");
            r.targetMode = "External";
            testCase.verifyEqual(string(r.targetMode), "External");
        end

        function typesAddDefault(testCase)
            t = mat2ppt.oxml.CT_Types.new();
            t.add_default("xml", "application/xml");
            kids = t.getchildren();
            testCase.verifyEqual(numel(kids), 1);
            testCase.verifyEqual(string(kids{1}.get("Extension")), "xml");
        end

        function xsdBoolean(testCase)
            testCase.verifyTrue(mat2ppt.oxml.simpletypes.XsdBoolean.from_xml("true"));
            testCase.verifyEqual(string(mat2ppt.oxml.simpletypes.XsdBoolean.to_xml(false)), "0");
        end
    end
end
