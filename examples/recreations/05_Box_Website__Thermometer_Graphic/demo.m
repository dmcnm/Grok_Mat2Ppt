%% demo.m — 05_Box_Website__Thermometer_Graphic
% Skill pipeline: extract full fingerprints → source_template → box → text
% → font/para (write may omit true defaults) → autofit → chrome → audit
% Extract: extracted/full_fingerprints.json

here = fileparts(mfilename("fullpath"));
addpath(fullfile(here, "..", "..", ".."));
outPath = fullfile(here, "out_mat2ppt.pptx");
assets = fullfile(here, "assets");
tpl = fullfile(here, "source_template.pptx");
if ~isfile(tpl)
    error("mat2ppt:MissingTemplate", "Missing source_template.pptx");
end
In = @mat2ppt.util.Inches;
E = @mat2ppt.util.Emu;
Pt = @mat2ppt.util.Pt;
prs = mat2ppt.Presentation(tpl);
layouts = prs.slide_layouts();
lay_Blank = layouts.get_by_name('Blank');

%% ===== Slide 1 · Blank =====
s = prs.slides().add_slide(lay_Blank);
sh = s.shapes();
sp = sh.add_shape('ellipse', In(47), In(19.9176), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(19.9176), In(46), In(2));
apply_grad_fill_(sp, {{4000, 'accent1'}, {0, 'accent1'}, {7000, 'bg1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(18.9176), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(19.9365), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(24.5722), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(24.5722), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {11000, 'bg1'}, {9000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(23.5722), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(24.5911), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(29.2268), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(29.2268), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {16000, 'bg1'}, {14000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(28.2268), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(29.2457), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(33.8815), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(33.8815), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {22000, 'bg1'}, {20000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(32.8815), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(33.9004), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(38.5361), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(38.5361), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {27000, 'bg1'}, {25000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(37.5361), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(38.555), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(43.1907), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(43.1907), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {33000, 'bg1'}, {31000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(42.1907), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(43.2096), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(47.8454), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(47.8454), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {38000, 'bg1'}, {36000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(46.8454), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(47.8643), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(52.5), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(52.5), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {43000, 'bg1'}, {41000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(51.5), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(52.5189), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(49.8568), In(15.0512), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '5%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(50), In(19.7059), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '10%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(50), In(24.3605), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '15%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.7135), In(29.0155), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '20%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.8568), In(33.6702), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '25%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.9427), In(38.3248), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '30%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.9427), In(42.9794), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '35%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.6562), In(47.6344), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '40%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.7995), In(52.2891), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '45%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(50), In(10.3966), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '2%', struct("bullets", false, "autofit", "shape", "pt", 138));
sp = sh.add_shape('ellipse', In(47), In(15.2629), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(15.2629), In(46), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(14.2629), In(4), In(4));
apply_grad_fill_(sp, {{0, 'accent1'}, {65000, 'bg1'}, {45000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(47.8568), In(15.2818), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(3.7161), In(15.2785), In(0.4427), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(10.6083), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(10.6083), In(46), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(9.6083), In(4), In(4));
apply_grad_fill_(sp, {{0, 'accent1'}, {25000, 'bg1'}, {16000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(47.8568), In(10.6272), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(3.7161), In(10.6239), In(0.4427), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(50.0859), In(1.1056), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '0%', struct("bullets", false, "autofit", "shape", "pt", 138));
sp = sh.add_shape('ellipse', In(47.0859), In(1.3173), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2.0859), In(1.3173), In(46), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0.0859), In(0.3173), In(4), In(4));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(47.9427), In(1.3362), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(3.802), In(1.3329), In(0.4427), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(50), In(5.7602), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '1%', struct("bullets", false, "autofit", "shape", "pt", 138));
sp = sh.add_shape('ellipse', In(47), In(5.9719), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(5.9719), In(46), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(4.9719), In(4), In(4));
apply_grad_fill_(sp, {{0, 'accent1'}, {17000, 'bg1'}, {6000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(47.8568), In(5.9908), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(3.7161), In(5.9875), In(0.4427), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);

%% ===== Slide 2 · Blank =====
s = prs.slides().add_slide(lay_Blank);
sh = s.shapes();
sp = sh.add_shape('ellipse', In(47), In(1.5306), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(1.5306), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {49000, 'bg1'}, {47000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(0.5306), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(1.5495), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(6.1852), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(6.1852), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {54000, 'bg1'}, {52000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(5.1852), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(6.2041), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(10.8398), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(10.8398), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {60000, 'bg1'}, {58000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(9.8398), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(10.8587), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(15.4945), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(15.4945), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {65000, 'bg1'}, {63000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(14.4945), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(15.5134), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(20.1491), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(20.1491), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {71000, 'bg1'}, {69000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(19.1491), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(20.168), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(24.8037), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(24.8037), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {76000, 'bg1'}, {74000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(23.8037), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(24.8226), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(29.4583), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(29.4583), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {82000, 'bg1'}, {80000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(28.4583), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(29.4772), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(34.113), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(34.113), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {86000, 'bg1'}, {85000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(33.113), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(34.1319), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(47), In(38.7676), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2), In(38.7676), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {92000, 'bg1'}, {90000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(0), In(37.7676), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.8568), In(38.7865), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(49.8568), In(1.3188), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '50%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(50), In(5.9735), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '55%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(50), In(10.6281), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '60%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.7135), In(15.2831), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '65%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.8568), In(19.9378), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '70%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.9427), In(24.5924), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '75%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.9427), In(29.247), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '80%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.6562), In(33.9021), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '85%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.7995), In(38.5567), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '90%', struct("bullets", false, "autofit", "shape", "pt", 138));
sp = sh.add_shape('ellipse', In(46.9141), In(43.4222), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(1.9141), In(43.4222), In(46), In(2));
apply_grad_fill_(sp, {{0, 'accent1'}, {98000, 'bg1'}, {96000, 'accent1'}, {100000, 'bg1'}}, 0);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(-0.0859), In(42.4222), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(47.7709), In(43.4411), In(0.2604), In(1.9687));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(46.9141), In(48.0769), In(2), In(2));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(1.9141), In(48.0769), In(46), In(2));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('ellipse', In(-0.0859), In(47.0769), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(49.5703), In(43.2113), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '95%', struct("bullets", false, "autofit", "shape", "pt", 138));
tb = sh.add_textbox(In(49.7135), In(47.866), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '98%', struct("bullets", false, "autofit", "shape", "pt", 138));
sp = sh.add_shape('ellipse', In(46.7708), In(52.7315), In(2), In(2));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(1.7708), In(52.7315), In(46), In(2));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(-0.2292), In(51.7315), In(4), In(4));
fill_scheme_(sp, 'accent1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(49.5703), In(52.5206), In(4.6328), In(2.4234));
style_textbox_(tb.text_frame(), '100%', struct("bullets", false, "autofit", "shape", "pt", 138));

prs.save(outPath);
fprintf("Wrote %s (fingerprint pipeline)\n", outPath);


%% ===================== fidelity helpers =====================
function style_title_(tf, lines, opts)
    if nargin < 3, opts = struct(); end
    if ischar(lines), lines = {lines}; end
    if isstring(lines), lines = cellstr(lines); end
    tf.clear(); ps = tf.paragraphs(); p = ps{1}; p.clear_content();
    for i = 1:numel(lines)
        if i > 1, p.element().append(mat2ppt.oxml.OxmlElement("a:br")); end
        r = p.add_run(); r.text = char(string(lines{i}));
    end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function style_body_levels_(tf, rows, opts)
    if nargin < 3, opts = struct(); end
    tf.clear(); ps = tf.paragraphs();
    for i = 1:size(rows, 1)
        if i == 1, p = ps{1}; else, p = tf.add_paragraph(); end
        p.text = char(string(rows{i, 1}));
        p.level = rows{i, 2};
    end
    try, tf.word_wrap = true; catch, end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function style_textbox_(tf, text, opts)
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 3, opts = struct(); end
    tf.text = char(string(text));
    if isfield(opts, "bullets") && ~opts.bullets, apply_no_bullet_all_(tf); end
    runOpts = struct();
    if isfield(opts, "face"), runOpts.latin = opts.face; end
    if isfield(opts, "pt"), runOpts.pt = opts.pt; end
    if isfield(opts, "rgb"), runOpts.rgb = opts.rgb; end
    if isfield(opts, "scheme"), runOpts.scheme = opts.scheme; end
    if isfield(opts, "bold") && opts.bold, runOpts.bold = true; end
    if ~isempty(fieldnames(runOpts))
        ps = tf.paragraphs();
        for pi = 1:numel(ps)
            rs = ps{pi}.runs();
            for ri = 1:numel(rs), apply_run_font_fp_(rs{ri}, runOpts); end
        end
    end
    if isfield(opts, "align"), set_para_align_(tf, opts.align); end
    if isfield(opts, "anchor"), set_body_anchor_(tf, opts.anchor); end
    try, tf.word_wrap = true; catch, end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "shape")
        tf.auto_size = AS.SHAPE_TO_FIT_TEXT;
    elseif isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function apply_run_font_fp_(r, opts)
    rPr = ensure_run_rPr_(r);
    if isempty(rPr), return; end
    if isfield(opts, "pt") && ~isempty(opts.pt)
        try, r.font().size = mat2ppt.util.Pt(double(opts.pt)); catch, end
    end
    if isfield(opts, "bold") && ~isempty(opts.bold)
        try, r.font().bold = logical(opts.bold); catch, end
    end
    if isfield(opts, "cap") && ~isempty(opts.cap)
        rPr.set("cap", char(string(opts.cap)));
    end
    if isfield(opts, "scheme") && ~isempty(opts.scheme)
        try
            r.font().color().theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(opts.scheme)));
            if isfield(opts, "brightness") && ~isempty(opts.brightness)
                r.font().color().brightness = double(opts.brightness);
            end
        catch
        end
    elseif isfield(opts, "rgb") && ~isempty(opts.rgb)
        rgb = double(opts.rgb);
        if iscell(rgb), rgb = rgb{1}; end
        try, r.font().color().rgb = mat2ppt.dml.RGBColor(rgb(1), rgb(2), rgb(3)); catch, end
    end
    if isfield(opts, "latin") && ~isempty(opts.latin)
        set_rpr_typeface_(rPr, "latin", opts.latin);
    elseif isfield(opts, "face") && ~isempty(opts.face)
        set_rpr_typeface_(rPr, "latin", opts.face);
    end
    if isfield(opts, "cs") && ~isempty(opts.cs)
        set_rpr_typeface_(rPr, "cs", opts.cs);
    end
end

function set_rpr_typeface_(rPr, which, face)
    kids = rPr.getchildren();
    for i = numel(kids):-1:1
        if strcmp(char(kids{i}.localName()), which), rPr.remove(kids{i}); end
    end
    el = mat2ppt.oxml.OxmlElement("a:" + string(which));
    el.set("typeface", char(string(face)));
    rPr.append(el);
end

function apply_title_run_fonts_(tf, opts)
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        rs = ps{pi}.runs();
        for ri = 1:numel(rs), apply_run_font_fp_(rs{ri}, opts); end
    end
end

function apply_run_symbol_font_(r, typeface)
    rPr = ensure_run_rPr_(r);
    if isempty(rPr), return; end
    kids = rPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"latin","sym","ea","cs"})), rPr.remove(kids{i}); end
    end
    sym = mat2ppt.oxml.OxmlElement("a:sym");
    sym.set("typeface", char(string(typeface)));
    rPr.append(sym);
end

function rPr = ensure_run_rPr_(r)
    rPr = [];
    try, r.font(); catch, end
    try, el = r.element(); catch, return; end
    rPr = el.find("a:rPr");
    if ~isempty(rPr), return; end
    kids = el.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "rPr"), rPr = kids{i}; return; end
    end
end

function set_para_lnspc_pct_(p, pct)
    if isempty(pct), return; end
    pPr = ensure_pPr_(p);
    kids = pPr.getchildren();
    for k = numel(kids):-1:1
        if strcmp(char(kids{k}.localName()), "lnSpc"), pPr.remove(kids{k}); end
    end
    lnSpc = mat2ppt.oxml.OxmlElement("a:lnSpc");
    spcPct = mat2ppt.oxml.OxmlElement("a:spcPct");
    spcPct.set("val", char(string(int64(pct))));
    lnSpc.append(spcPct); pPr.append(lnSpc);
end

function set_para_bu_none_(p)
    pPr = ensure_pPr_(p);
    kids = pPr.getchildren();
    for k = numel(kids):-1:1
        if startsWith(string(kids{k}.localName()), "bu"), pPr.remove(kids{k}); end
    end
    pPr.append(mat2ppt.oxml.OxmlElement("a:buNone"));
end

function apply_no_bullet_all_(tf)
    ps = tf.paragraphs();
    for i = 1:numel(ps), set_para_bu_none_(ps{i}); end
end

function set_para_align_(tf, algn)
    ps = tf.paragraphs();
    for i = 1:numel(ps), set_para_align_one_(ps{i}, algn); end
end

function set_para_align_one_(p, algn)
    try
        if strcmpi(algn, "ctr"), p.alignment = mat2ppt.enum.PP_ALIGN.CENTER; return; end
    catch
    end
    pPr = ensure_pPr_(p); pPr.set("algn", char(string(algn)));
end

function set_para_align_tf_one_(p, algn)
    set_para_align_one_(p, algn);
end

function set_body_anchor_(tf, anchor)
    bodyPr = find_or_make_body_pr_(tf.element());
    bodyPr.set("anchor", char(string(anchor)));
end

function apply_norm_autofit_(tf, opts)
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 2, opts = struct(); end
    tf.auto_size = AS.TEXT_TO_FIT_SHAPE;
    hasScale = isfield(opts, "fontScale") && ~isempty(opts.fontScale);
    hasLn = isfield(opts, "lnSpcReduction") && ~isempty(opts.lnSpcReduction);
    if ~hasScale && ~hasLn, return; end
    bodyPr = find_or_make_body_pr_(tf.element());
    na = []; bk = bodyPr.getchildren();
    for i = 1:numel(bk)
        if strcmp(char(bk{i}.localName()), "normAutofit"), na = bk{i}; break; end
    end
    if isempty(na), na = mat2ppt.oxml.OxmlElement("a:normAutofit"); bodyPr.append(na); end
    if hasScale, na.set("fontScale", char(string(int64(opts.fontScale)))); end
    if hasLn, na.set("lnSpcReduction", char(string(int64(opts.lnSpcReduction)))); end
end

function apply_no_autofit_(tf)
    bodyPr = find_or_make_body_pr_(tf.element());
    kids = bodyPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"noAutofit","normAutofit","spAutoFit"})), bodyPr.remove(kids{i}); end
    end
end

function fill_scheme_(shapeObj, schemeName, brightness)
    try
        shapeObj.fill().solid();
        shapeObj.fill().fore_color().theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(schemeName)));
        if nargin >= 3 && ~isempty(brightness)
            shapeObj.fill().fore_color().brightness = double(brightness);
        end
    catch
    end
end

function fill_rgb_(shapeObj, rgb)
    try
        shapeObj.fill().solid();
        shapeObj.fill().fore_color().rgb = mat2ppt.dml.RGBColor(rgb(1), rgb(2), rgb(3));
    catch
    end
end

function apply_grad_fill_(shapeObj, stops, ang)
%APPLY_GRAD_FILL_  Write a:gradFill with scheme or sRGB stops (pos 0–100000).
% stops: cell of {pos, colorSpec} where colorSpec is scheme name ("accent1")
%        or 6-char hex ("4F81BD"). ang: OOXML linear angle (60000ths of a degree).
    if nargin < 3 || isempty(ang), ang = 0; end
    try
        se = shapeObj.shape_element();
    catch
        try, se = shapeObj.element(); catch, return; end
    end
    spPr = se.find("p:spPr");
    if isempty(spPr)
        kids = se.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "spPr"), spPr = kids{i}; break; end
        end
    end
    if isempty(spPr), return; end
    kids = spPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"noFill","solidFill","gradFill","blipFill","pattFill","grpFill"}))
            spPr.remove(kids{i});
        end
    end
    gf = mat2ppt.oxml.OxmlElement("a:gradFill");
    gf.set("flip", "none");
    gf.set("rotWithShape", "1");
    gsLst = mat2ppt.oxml.OxmlElement("a:gsLst");
    for i = 1:numel(stops)
        st = stops{i};
        pos = st{1};
        col = char(string(st{2}));
        gs = mat2ppt.oxml.OxmlElement("a:gs");
        gs.set("pos", char(string(int64(pos))));
        if strlength(string(col)) == 6 && all(isstrprop(col, "xdigit"))
            c = mat2ppt.oxml.OxmlElement("a:srgbClr");
            c.set("val", upper(col));
        else
            c = mat2ppt.oxml.OxmlElement("a:schemeClr");
            c.set("val", col);
        end
        gs.append(c);
        gsLst.append(gs);
    end
    gf.append(gsLst);
    lin = mat2ppt.oxml.OxmlElement("a:lin");
    lin.set("ang", char(string(int64(ang))));
    lin.set("scaled", "0");
    gf.append(lin);
    idx = mat2ppt.dml.FillFormat.fill_insert_index_(spPr);
    spPr.insert(idx, gf);
end

function apply_shape_style_office_(shapeObj)
    try, sp = shapeObj.shape_element(); catch, return; end
    style = sp.find("p:style");
    if isempty(style)
        kids = sp.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "style"), style = kids{i}; break; end
        end
    end
    if isempty(style)
        style = mat2ppt.oxml.OxmlElement("p:style"); sp.append(style);
    else
        ck = style.getchildren();
        for i = numel(ck):-1:1, style.remove(ck{i}); end
    end
    lnRef = mat2ppt.oxml.OxmlElement("a:lnRef"); lnRef.set("idx", "2");
    sch = mat2ppt.oxml.OxmlElement("a:schemeClr"); sch.set("val", "accent1");
    shd = mat2ppt.oxml.OxmlElement("a:shade"); shd.set("val", "50000");
    sch.append(shd); lnRef.append(sch); style.append(lnRef);
    fillRef = mat2ppt.oxml.OxmlElement("a:fillRef"); fillRef.set("idx", "1");
    sch2 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sch2.set("val", "accent1");
    fillRef.append(sch2); style.append(fillRef);
    effectRef = mat2ppt.oxml.OxmlElement("a:effectRef"); effectRef.set("idx", "0");
    sch3 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sch3.set("val", "accent1");
    effectRef.append(sch3); style.append(effectRef);
    fontRef = mat2ppt.oxml.OxmlElement("a:fontRef"); fontRef.set("idx", "minor");
    sch4 = mat2ppt.oxml.OxmlElement("a:schemeClr"); sch4.set("val", "lt1");
    fontRef.append(sch4); style.append(fontRef);
end

function apply_line_no_fill_(shapeObj)
    try, shapeObj.line.fill().background(); catch, end
end

function style_connector_(cxn, opts)
    if nargin < 2, opts = struct(); end
    try
        if isfield(opts, "w") && ~isempty(opts.w)
            cxn.line.width = mat2ppt.util.Emu(double(opts.w));
        end
    catch
    end
    if isfield(opts, "scheme") && ~isempty(opts.scheme)
        try
            cxn.line.color.theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(opts.scheme)));
            if isfield(opts, "brightness") && ~isempty(opts.brightness)
                cxn.line.color.brightness = double(opts.brightness);
            end
        catch
        end
    end
    if isfield(opts, "tail") && ~isempty(opts.tail)
        try, cxn.set_tail_end(char(string(opts.tail))); catch, end
        try
            ln = cxn.get_or_add_ln();
            kids = ln.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "tailEnd")
                    if isfield(opts, "tailW"), kids{i}.set("w", char(string(opts.tailW))); end
                    if isfield(opts, "tailLen"), kids{i}.set("len", char(string(opts.tailLen))); end
                end
            end
        catch
        end
    end
end

function pPr = ensure_pPr_(p)
    el = p.element(); pPr = el.find("a:pPr");
    if ~isempty(pPr), return; end
    kids = el.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "pPr"), pPr = kids{i}; return; end
    end
    pPr = mat2ppt.oxml.OxmlElement("a:pPr");
    for i = 1:numel(kids), el.remove(kids{i}); end
    el.append(pPr);
    for i = 1:numel(kids), el.append(kids{i}); end
end

function bodyPr = find_or_make_body_pr_(txBody)
    kids = txBody.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "bodyPr"), bodyPr = kids{i}; return; end
    end
    bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
    for i = 1:numel(kids), txBody.remove(kids{i}); end
    txBody.append(bodyPr);
    for i = 1:numel(kids), txBody.append(kids{i}); end
end

function set_shape_box_(shapeObj, L, T, W, H)
    EMU = 914400;
    x = round(L*EMU); y = round(T*EMU); cx = round(W*EMU); cy = round(H*EMU);
    sp = shapeObj.shape_element();
    spPr = sp.find("p:spPr");
    if isempty(spPr)
        kids = sp.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "spPr"), spPr = kids{i}; break; end
        end
    end
    if isempty(spPr), spPr = mat2ppt.oxml.shapes.ensure_spPr(sp); end
    kids = spPr.getchildren();
    for i = numel(kids):-1:1
        if strcmp(char(kids{i}.localName()), "xfrm"), spPr.remove(kids{i}); end
    end
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off"); off.set("x", char(string(x))); off.set("y", char(string(y)));
    ext = mat2ppt.oxml.OxmlElement("a:ext"); ext.set("cx", char(string(cx))); ext.set("cy", char(string(cy)));
    xfrm.append(off); xfrm.append(ext); spPr.append(xfrm);
end

function pic = add_pic_(sh, assets, name, L, T, W, H)
    In = @mat2ppt.util.Inches;
    img = fullfile(assets, name); pic = [];
    if isfile(img), pic = sh.add_picture(img, In(L), In(T), In(W), In(H)); end
end

