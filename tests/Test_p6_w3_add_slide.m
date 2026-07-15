classdef Test_p6_w3_add_slide < matlab.unittest.TestCase
    % P6-W3: add_slide package/rels wiring + placeholder clone

    methods (Test)
        function addTitleSlide(testCase)
            prs = mat2ppt.Presentation();
            testCase.verifyEqual(prs.slides().length, 0);
            layout = prs.slide_layouts().get_by_name("Title Slide");
            testCase.verifyFalse(isempty(layout));
            s = prs.slides().add_slide(layout);
            testCase.verifyEqual(prs.slides().length, 1);
            testCase.verifyEqual(string(s.partname()), "/ppt/slides/slide1.xml");
            % title slide clones ctrTitle + subTitle (not latent)
            testCase.verifyGreaterThanOrEqual(s.shapes().length, 2);
            % save and reopen
            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(outPath));
            prs.save(outPath);
            prs2 = mat2ppt.Presentation(outPath);
            testCase.verifyEqual(prs2.slides().length, 1);
            testCase.verifyEqual(string(prs2.slides().item(1).partname()), ...
                "/ppt/slides/slide1.xml");
            testCase.verifyGreaterThanOrEqual(prs2.slides().item(1).shapes().length, 2);
        end

        function addTwoSlides(testCase)
            prs = mat2ppt.Presentation();
            layouts = prs.slide_layouts();
            prs.slides().add_slide(layouts.get_by_name("Title Slide"));
            prs.slides().add_slide(layouts.get_by_name("Blank"));
            testCase.verifyEqual(prs.slides().length, 2);
            testCase.verifyEqual(string(prs.slides().item(2).partname()), ...
                "/ppt/slides/slide2.xml");
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
