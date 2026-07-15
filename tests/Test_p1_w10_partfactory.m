classdef Test_p1_w10_partfactory < matlab.unittest.TestCase
    % P1-W10: PartFactory exact map

    methods (Test)
        function presentationMainMaps(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            cls = mat2ppt.opc.PartFactory.part_class_for(CT.PML_PRESENTATION_MAIN);
            testCase.verifyEqual(string(cls), "mat2ppt.parts.PresentationPart");
        end

        function corePropsMaps(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            cls = mat2ppt.opc.PartFactory.part_class_for(CT.OPC_CORE_PROPERTIES);
            testCase.verifyEqual(string(cls), "mat2ppt.parts.CorePropertiesPart");
        end

        function jpegIsImagePart(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            cls = mat2ppt.opc.PartFactory.part_class_for(CT.JPEG);
            testCase.verifyEqual(string(cls), "mat2ppt.parts.ImagePart");
        end

        function unknownIsOpaquePart(testCase)
            cls = mat2ppt.opc.PartFactory.part_class_for("application/octet-stream");
            testCase.verifyEqual(string(cls), "mat2ppt.opc.Part");
        end

        function loadXmlPart(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            xml = uint8(unicode2native( ...
                "<?xml version='1.0'?><p:presentation xmlns:p=""http://schemas.openxmlformats.org/presentationml/2006/main""/>", ...
                "UTF-8"));
            part = mat2ppt.opc.PartFactory.load( ...
                "/ppt/presentation.xml", CT.PML_PRESENTATION_MAIN, [], xml);
            testCase.verifyTrue(isa(part, "mat2ppt.parts.PresentationPart"));
            b = part.blob();
            testCase.verifyTrue(numel(b) > 20);
        end
    end
end
