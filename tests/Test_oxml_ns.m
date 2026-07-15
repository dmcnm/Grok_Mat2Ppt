classdef Test_oxml_ns < matlab.unittest.TestCase
    % P1-W2: oxml namespace helpers
    % Source: tests/oxml/test_ns.py

    properties (Constant)
        URI_A = "http://schemas.openxmlformats.org/drawingml/2006/main"
        URI_P = "http://schemas.openxmlformats.org/presentationml/2006/main"
    end

    methods (Test)
        function namespacePrefixedTagAsString(testCase)
            t = mat2ppt.oxml.NamespacePrefixedTag("a:foobar");
            s = sprintf("- %s -", t);
            testCase.verifyEqual(s, "- a:foobar -");
        end

        function clarkName(testCase)
            t = mat2ppt.oxml.NamespacePrefixedTag("a:foobar");
            want = sprintf("{%s}foobar", testCase.URI_A);
            testCase.verifyEqual(string(t.clark_name), string(want));
        end

        function localPartAndPrefixAndUri(testCase)
            t = mat2ppt.oxml.NamespacePrefixedTag("a:foobar");
            testCase.verifyEqual(t.local_part, "foobar");
            testCase.verifyEqual(t.nspfx, "a");
            testCase.verifyEqual(string(t.nsuri), testCase.URI_A);
        end

        function singleEntryNsmap(testCase)
            t = mat2ppt.oxml.NamespacePrefixedTag("a:foobar");
            m = t.nsmap;
            testCase.verifyEqual(m("a"), char(testCase.URI_A));
            testCase.verifyEqual(double(m.Count), 1);
        end

        function fromClarkName(testCase)
            clark = sprintf("{%s}foobar", testCase.URI_A);
            t = mat2ppt.oxml.NamespacePrefixedTag.from_clark_name(clark);
            testCase.verifyEqual(t.tag, "a:foobar");
        end

        function namespacesSubset(testCase)
            m = mat2ppt.oxml.namespaces("a", "p");
            testCase.verifyEqual(m("a"), char(testCase.URI_A));
            testCase.verifyEqual(m("p"), char(testCase.URI_P));
            testCase.verifyEqual(double(m.Count), 2);
            m2 = mat2ppt.oxml.nsmap("a", "p");
            testCase.verifyEqual(m2("a"), m("a"));
        end

        function nsdeclsFormat(testCase)
            s = mat2ppt.oxml.nsdecls("a", "p");
            want = sprintf('xmlns:a="%s" xmlns:p="%s"', testCase.URI_A, testCase.URI_P);
            testCase.verifyEqual(string(s), string(want));
        end

        function nsuriLookup(testCase)
            testCase.verifyEqual(string(mat2ppt.oxml.nsuri("a")), testCase.URI_A);
            testCase.verifyEqual(string(mat2ppt.oxml.nsuri("p")), testCase.URI_P);
        end

        function qnClark(testCase)
            got = mat2ppt.oxml.qn("a:foobar");
            want = sprintf("{%s}foobar", testCase.URI_A);
            testCase.verifyEqual(string(got), string(want));
            % p: prefix maps to presentationml (not the mistaken drawingml in Python docstring)
            gotp = mat2ppt.oxml.qn("p:cSld");
            wantp = sprintf("{%s}cSld", testCase.URI_P);
            testCase.verifyEqual(string(gotp), string(wantp));
        end
    end
end
