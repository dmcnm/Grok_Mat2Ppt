classdef Test_oxml_entities < matlab.unittest.TestCase
    %TEST_OXML_ENTITIES  Parse/serialize must not double-escape text or attrs.

    methods (Test)
        function text_ampersand_roundtrip(tc)
            xml = ['<a:t xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">' ...
                'Q &amp; A</a:t>'];
            root = mat2ppt.oxml.parse_xml(xml);
            tc.verifyEqual(char(string(root.text)), 'Q & A');
            out = native2unicode(mat2ppt.oxml.serialize_part_xml(root), "UTF-8");
            tc.verifyTrue(contains(out, 'Q &amp; A'));
            tc.verifyFalse(contains(out, '&amp;amp;'));
        end

        function attr_numeric_newline_roundtrip(tc)
            xml = ['<p:cNvPr xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" ' ...
                'id="3" name="Picture 3" descr="line1&#xA;&#xA;line2"/>'];
            root = mat2ppt.oxml.parse_xml(xml);
            d = root.get("descr");
            tc.verifyTrue(contains(char(string(d)), char(10)));
            tc.verifyFalse(contains(char(string(d)), '&#xA;'));
            out = native2unicode(mat2ppt.oxml.serialize_part_xml(root), "UTF-8");
            % Serialized form may use raw newline or entity; must not double-escape
            tc.verifyFalse(contains(out, '&amp;#xA;'));
            tc.verifyFalse(contains(out, '&amp;amp;'));
        end

        function unescape_hex_and_named(tc)
            s = mat2ppt.oxml.unescape_xml_('a&lt;b&gt;c&amp;d&#x41;&#65;');
            tc.verifyEqual(char(string(s)), 'a<b>c&dAA');
        end
    end
end
