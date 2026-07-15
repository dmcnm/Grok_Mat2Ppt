classdef Test_p6_w1_textframe < matlab.unittest.TestCase
    % P6-W1: TextFrame / Paragraph / Run

    methods (Test)
        function shapeTextFrameRoundTrip(testCase)
            sp = mat2ppt.oxml.shapes.new_sp(1, "Box", ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(1), "rect");
            sh = mat2ppt.shapes.Shape(sp, struct("part", "stub"));
            tf = sh.text_frame();
            tf.text = "Hello" + newline + "World";
            testCase.verifyEqual(string(tf.text), "Hello" + newline + "World");
            ps = tf.paragraphs();
            testCase.verifyEqual(numel(ps), 2);
            testCase.verifyEqual(string(ps{1}.text), "Hello");
            testCase.verifyEqual(string(ps{2}.text), "World");
        end

        function addRunAndClear(testCase)
            tb = mat2ppt.oxml.text.CT_TextBody.new();
            tf = mat2ppt.text.TextFrame(tb, struct("part", "p"));
            tf.clear();
            p = tf.paragraphs();
            p = p{1};
            r = p.add_run();
            r.text = "RunA";
            testCase.verifyEqual(numel(p.runs()), 1);
            testCase.verifyEqual(string(p.text), "RunA");
            p.clear_content();
            testCase.verifyEqual(numel(p.runs()), 0);
        end

        function wordWrap(testCase)
            tb = mat2ppt.oxml.text.CT_TextBody.new();
            tf = mat2ppt.text.TextFrame(tb, struct("part", "p"));
            tf.word_wrap = false;
            testCase.verifyFalse(tf.word_wrap);
            tf.word_wrap = true;
            testCase.verifyTrue(tf.word_wrap);
        end
    end
end
