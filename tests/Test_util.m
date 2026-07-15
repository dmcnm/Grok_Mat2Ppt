classdef Test_util < matlab.unittest.TestCase
    % P1-W1: Length family, isAbsent, lazy_get idiom
    % Source: tests/test_util.py + design §7.8

    methods (Test)
        function constructFromConvenientUnits(testCase)
            % Mirror DescribeLength.it_can_construct_from_convenient_units
            import mat2ppt.util.*
            cases = {
                @Length, 914400, int64(914400)
                @Inches, 1.1, int64(1005840)
                @Centipoints, 12.5, int64(1587)
                @Cm, 2.53, int64(910799)
                @Emu, 9144.9, int64(9144)
                @Mm, 13.8, int64(496800)
                @Pt, 24.5, int64(311150)
                };
            for i = 1:size(cases, 1)
                ctor = cases{i, 1};
                arg = cases{i, 2};
                want = cases{i, 3};
                L = ctor(arg);
                testCase.verifyTrue(isa(L, "mat2ppt.util.Length"));
                testCase.verifyEqual(L.emu, want);
                testCase.verifyTrue(L == want);
            end
        end

        function selfConvertToConvenientUnits(testCase)
            import mat2ppt.util.*
            L = Length(914400);
            testCase.verifyEqual(L.inches, 1.0);
            testCase.verifyEqual(L.centipoints, int64(7200));
            testCase.verifyEqual(L.cm, 2.54);
            testCase.verifyEqual(L.emu, int64(914400));
            testCase.verifyEqual(L.mm, 25.4);
            testCase.verifyEqual(L.pt, 72.0);
        end

        function inchesRoundTripProps(testCase)
            L = mat2ppt.util.Inches(1.1);
            testCase.verifyEqual(L.inches, 1.1, "AbsTol", 1e-12);
            testCase.verifyEqual(L.emu, int64(1005840));
        end

        function isAbsentNoneLike(testCase)
            testCase.verifyTrue(mat2ppt.isAbsent([]));
            testCase.verifyTrue(mat2ppt.isAbsent(missing));
            testCase.verifyFalse(mat2ppt.isAbsent(""));
            testCase.verifyFalse(mat2ppt.isAbsent(''));
            testCase.verifyFalse(mat2ppt.isAbsent(0));
            testCase.verifyFalse(mat2ppt.isAbsent(false));
            testCase.verifyFalse(mat2ppt.isAbsent("x"));
        end

        function lazyGetCachesOnHandle(testCase)
            h = LocalLazyHost();
            a = h.foo;
            b = h.foo;
            testCase.verifyEqual(a, 42);
            testCase.verifyEqual(b, 42);
            testCase.verifyEqual(h.computeCount, 1);
        end
    end
end
