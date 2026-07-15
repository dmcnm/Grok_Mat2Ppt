classdef Test_oxml_ser_parse < matlab.unittest.TestCase
    % P1-W4/W5: serialize + parse basic round-trip vs python-pptx oracle bytes

    methods (Test)
        function serializeMatchesLxmlSimple(testCase)
            % Build a:t with text hi — compare to python serialize_part_xml
            e = mat2ppt.oxml.OxmlElement("a:t");
            e.text = "hi";
            got = mat2ppt.oxml.serialize_part_xml(e);
            % Oracle from python (lxml single-quoted decl)
            want = uint8(unicode2native( ...
                [char("<?xml version='1.0' encoding='UTF-8' standalone='yes'?>"), newline, ...
                 '<a:t xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">hi</a:t>'], ...
                "UTF-8"));
            testCase.verifyEqual(got(:)', want(:)');
        end

        function parseThenSerializeSimple(testCase)
            xml = '<a:t xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">hi</a:t>';
            root = mat2ppt.oxml.parse_xml(xml);
            testCase.verifyEqual(root.localName(), "t");
            testCase.verifyEqual(string(root.text), "hi");
            got = mat2ppt.oxml.serialize_part_xml(root);
            want = mat2ppt.oxml.serialize_part_xml(mat2ppt.oxml.OxmlElement("a:t"));
            % rebuild expected
            e = mat2ppt.oxml.OxmlElement("a:t");
            e.text = "hi";
            want = mat2ppt.oxml.serialize_part_xml(e);
            testCase.verifyEqual(got(:)', want(:)');
        end

        function emptyElementSelfClose(testCase)
            e = mat2ppt.oxml.OxmlElement("a:off");
            e.set("x", "1");
            s = native2unicode(mat2ppt.oxml.serialize_part_xml(e), "UTF-8");
            testCase.verifyTrue(contains(s, 'x="1"'));
            testCase.verifyTrue(contains(s, "/>") || contains(s, "></"));
        end
    end
end
