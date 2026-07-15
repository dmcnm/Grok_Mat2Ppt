classdef Test_bootstrap < matlab.unittest.TestCase
    % Phase 0 smoke tests for Mat2Ppt bootstrap artifacts.

    methods (Test)
        function versionIsNonempty(testCase)
            v = mat2ppt.version();
            testCase.verifyTrue(strlength(v) > 0);
        end

        function defaultTemplateExists(testCase)
            p = mat2ppt.template_path("default.pptx");
            testCase.verifyTrue(isfile(p));
            info = dir(p);
            testCase.verifyGreaterThan(info.bytes, 0);
        end

        function unknownTemplateErrors(testCase)
            testCase.verifyError( ...
                @() mat2ppt.template_path("no-such-file.pptx"), ...
                "mat2ppt:TemplateNotFound");
        end
    end
end
