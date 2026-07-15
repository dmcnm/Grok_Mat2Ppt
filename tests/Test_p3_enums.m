classdef Test_p3_enums < matlab.unittest.TestCase
    % Phase 3: enum base + domain enums G3-API probes

    methods (Test)
        function textEnumsXml(testCase)
            a = mat2ppt.enum.PP_ALIGN.CENTER;
            testCase.verifyEqual(string(a.xml_value), "ctr");
            m = mat2ppt.enum.PP_PARAGRAPH_ALIGNMENT.from_xml("r");
            testCase.verifyEqual(m.name, "RIGHT");
            u = mat2ppt.enum.MSO_UNDERLINE.SINGLE_LINE;
            testCase.verifyEqual(string(mat2ppt.enum.MSO_UNDERLINE.to_xml(u)), "sng");
        end

        function shapeEnum(testCase)
            s = mat2ppt.enum.MSO_SHAPE.RECTANGLE;
            testCase.verifyTrue(isa(s, "mat2ppt.enum.BaseXmlEnum"));
            testCase.verifyGreaterThan(s.value, 0);
        end

        function dmlAndAction(testCase)
            t = mat2ppt.enum.MSO_FILL.SOLID;
            testCase.verifyEqual(t.value, mat2ppt.enum.MSO_FILL_TYPE.SOLID.value);
            testCase.verifyTrue(isa(mat2ppt.enum.PP_ACTION.HYPERLINK, "mat2ppt.enum.BaseEnum"));
        end

        function chartAndLang(testCase)
            c = mat2ppt.enum.XL_CHART_TYPE.BAR_CLUSTERED;
            testCase.verifyTrue(isa(c, "mat2ppt.enum.BaseEnum"));
            lang = mat2ppt.enum.MSO_LANGUAGE_ID.ENGLISH_US;
            testCase.verifyTrue(isa(lang, "mat2ppt.enum.BaseXmlEnum"));
        end

        function simpletypesMore(testCase)
            s = mat2ppt.oxml.simpletypes.ST_ContentType.to_xml("application/xml");
            testCase.verifyEqual(string(s), "application/xml");
            e = mat2ppt.oxml.simpletypes.ST_Extension.from_xml(".rels");
            testCase.verifyEqual(string(e), "rels");
        end
    end
end
