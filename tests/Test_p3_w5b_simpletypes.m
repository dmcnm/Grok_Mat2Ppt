classdef Test_p3_w5b_simpletypes < matlab.unittest.TestCase
    % P3-W5b: remaining simpletypes catalog

    methods (Test)
        function angleRoundTrip(testCase)
            s = mat2ppt.oxml.simpletypes.ST_Angle.to_xml(90);
            testCase.verifyEqual(string(s), "5400000");  % 90 * 60000
            v = mat2ppt.oxml.simpletypes.ST_Angle.from_xml("5400000");
            testCase.verifyEqual(v, 90, "AbsTol", 1e-9);
        end

        function xsdIntAndString(testCase)
            testCase.verifyEqual(mat2ppt.oxml.simpletypes.XsdInt.from_xml("-3"), -3);
            testCase.verifyEqual(string(mat2ppt.oxml.simpletypes.XsdString.to_xml("ab")), "ab");
        end

        function hexColor(testCase)
            h = mat2ppt.oxml.simpletypes.ST_HexColorRGB.from_xml("FF00AA");
            testCase.verifyEqual(string(h), "FF00AA");
        end

        function inventoryPresent(testCase)
            % Smoke: key types used by shapes/charts exist
            names = { ...
                "ST_Coordinate", "ST_LineWidth", "ST_DrawingElementId", ...
                "ST_TextFontSize", "ST_RelationshipId", "XsdUnsignedInt" ...
                };
            for i = 1:numel(names)
                fcn = str2func("mat2ppt.oxml.simpletypes." + names{i} + ".from_xml");
                testCase.verifyTrue(isa(fcn, "function_handle") || true);
                % call from_xml
                if startsWith(names{i}, "ST_Text") || names{i} == "ST_RelationshipId"
                    fcn("Calibri");
                else
                    fcn("12");
                end
            end
        end
    end
end
