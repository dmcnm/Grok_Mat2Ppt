classdef Test_p6_w2_slides < matlab.unittest.TestCase
    % P6-W2: Slide / Slides / masters / layouts access (1-based)

    methods (Test)
        function defaultMastersAndLayouts(testCase)
            prs = mat2ppt.Presentation();
            testCase.verifyEqual(prs.slides().length, 0);
            testCase.verifyEqual(prs.slide_masters().length, 1);
            layouts = prs.slide_layouts();
            testCase.verifyEqual(layouts.length, 11);
            testCase.verifyEqual(string(layouts.item(1).name), "Title Slide");
            title = layouts.get_by_name("Title Slide");
            testCase.verifyFalse(isempty(title));
            testCase.verifyEqual(string(title.name), "Title Slide");
            blank = layouts.get_by_name("Blank");
            testCase.verifyEqual(string(blank.name), "Blank");
            testCase.verifyGreaterThan(title.shapes().length, 0);
        end

        function oneBasedIndexErrors(testCase)
            prs = mat2ppt.Presentation();
            layouts = prs.slide_layouts();
            testCase.verifyError(@() layouts.item(0), "mat2ppt:IndexOutOfRange");
            testCase.verifyError(@() layouts.item(12), "mat2ppt:IndexOutOfRange");
        end

        function relatedPartnameResolves(testCase)
            prs = mat2ppt.Presentation();
            pkg = prs.package();
            pn = mat2ppt.opc.related_partname(pkg, "/ppt/presentation.xml", "rId1");
            testCase.verifyEqual(string(pn), "/ppt/slideMasters/slideMaster1.xml");
            master = prs.slide_master();
            testCase.verifyEqual(string(master.partname()), "/ppt/slideMasters/slideMaster1.xml");
        end
    end
end
