classdef Test_r8_registry < matlab.unittest.TestCase
    %TEST_R8_REGISTRY  domain CT registration + xpath forms (R8).

    methods (Test)
        function domain_tags_registered(tc)
            mat2ppt.oxml.register_domain_element_classes();
            tags = {"a:srgbClr", "a:r", "p:sld", "c:chartSpace", "c:barChart", "c:ser"};
            for i = 1:numel(tags)
                cn = mat2ppt.oxml.element_class_for_tag(tags{i});
                tc.verifyTrue(strlength(string(cn)) > 0, tags{i});
            end
        end

        function xpath_descendant_and_attr(tc)
            root = mat2ppt.oxml.OxmlElement("p:sld");
            cSld = mat2ppt.oxml.OxmlElement("p:cSld");
            sp = mat2ppt.oxml.OxmlElement("p:sp");
            sp.set("id", "9");
            cSld.append(sp);
            root.append(cSld);
            r = mat2ppt.oxml.evaluate_xpath(root, ".//p:sp");
            tc.verifyEqual(numel(r), 1);
            r2 = mat2ppt.oxml.evaluate_xpath(sp, "@id");
            tc.verifyEqual(char(string(r2{1})), '9');
        end
    end
end
