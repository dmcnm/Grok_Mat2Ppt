%% demo.m — 14_Dropbox_Ethics__High School NFP presentation
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
lay_Title_and_Content = layouts.get_by_name('Title and Content');
lay_Title_Slide = layouts.get_by_name('Title Slide');
lay_Section_Header = layouts.get_by_name('Section Header');
lay_Blank = layouts.get_by_name('Blank');

%% ===== Slide 1 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Jeff and Erika Cowman'}, struct());
set_shape_box_(sh.item(1), 0.4167, 0.3333, 8.8333, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 5.1667, 2.0, 4.4167, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Met when Jeff was 17 and Erika 18, on Bishop Kelly campus', 0; ...
    'Married at St. John’s Cathedral June 2003', 0; ...
    'Became NFP Teachers 2009', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image2.jpeg', 0.4167, 1.9618, 4.3333, 4.8986);
if ~isempty(p), p.crop_left = 0.14937; end
if ~isempty(p), p.crop_top = 0.10184; end
if ~isempty(p), p.crop_right = 0.08714; end
if ~isempty(p), p.crop_bottom = 0.01556; end

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Children'}, struct());
set_shape_box_(sh.item(1), 0.4167, 0.3333, 9.4167, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 7.0064, 1.734, 3.0671, 5.25);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Mikaela Joan 13', 0; ...
    'Kaleb Alexander 11', 0; ...
    'Baby George in heaven', 0; ...
    'John Paul 7', 0; ...
    'Gilbert Joseph 4', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Mikaela Joan 13';
    apply_run_font_fp_(r, struct("pt", 24, "scheme", 'bg1'));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Kaleb Alexander 11';
    apply_run_font_fp_(r, struct("pt", 24, "scheme", 'bg1'));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Baby George in heaven';
    apply_run_font_fp_(r, struct("pt", 24, "scheme", 'bg1'));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'John Paul 7';
    apply_run_font_fp_(r, struct("pt", 24, "scheme", 'bg1'));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Gilbert Joseph 4';
    apply_run_font_fp_(r, struct("pt", 24, "scheme", 'bg1'));
end
p = add_pic_(sh, assets, 'image1.jpeg', 0.0, 1.5486, 10.0, 5.967);
if ~isempty(p), p.crop_top = 0.17557; end
p = add_pic_(sh, assets, 'image3.jpg', 0.0735, 1.734, 6.8594, 4.8979);
if ~isempty(p), p.crop_left = 0.16245; end
if ~isempty(p), p.crop_top = 0.14241; end
if ~isempty(p), p.crop_bottom = 0.0555; end

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'How we discovered NFP:'}, struct());
set_shape_box_(sh.item(1), 0.5417, 0.0833, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.533, 6.9167, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Grew up on dairy farm', 0; ...
    'Knew about chastity, but not teaching on contraception', 0; ...
    'Overheard parents joking about the Pope not liking vasectomies', 0; ...
    'Vet science class in college—Animal reproduction—fertility is science', 0; ...
    'Audio Talk:  Professor Janet Smith—Contraception:  Why Not?/Cracking the Myths', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.25), In(2.9167), In(2), In(0.9088));
style_textbox_(tb.text_frame(), 'Erika ', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 48, "face", 'Aharoni', "rgb", [255 255 255]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 48, "latin", 'Aharoni', "cs", 'Aharoni', "rgb", [255 255 255])); end

%% ===== Slide 4 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'How we discovered NFP:'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1337, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 48, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.4167, 1.75, 7.5833, 5.75);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Learned about development and testing of the Pill in high school and how women died', 0; ...
    'Men fertile 24/7, Women a few days, seemed unjust to sterilize a women', 0; ...
    'Learned about NFP on a H.S. retreat ', 0; ...
    'Heard talks on Theology of the Body at Seminary and with Erika', 0; ...
    'College- completed a group project for statistics class on contraceptive use; I knew more about women’s cycles than my female classmates', 0; ...
    }, struct("listProps", false, "fontScale", 85000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.25), In(2.9167), In(2), In(1.3127));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Jeff';
apply_run_font_fp_(r, struct("pt", 60, "latin", 'Aharoni', "cs", 'Aharoni', "rgb", [255 255 255]));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("pt", 72, "latin", 'Source Sans Pro', "rgb", [255 255 255]));
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Our purpose here'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.0833, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.8333, 7.25, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Provide information on what NFP is & what it is not', 0; ...
    'Provide facts / dispel myths', 0; ...
    'Benefits of NFP', 0; ...
    'Answer questions', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 6 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Inform…not judge!'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.75, 2.4167, 8.5, 2.7743);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("bold", true, "latin", '+mn-lt', "scheme", 'bg1'));
tb = sh.add_textbox(In(9.0833), In(7.0464), In(0.5712), In(0.3702));
p = add_pic_(sh, assets, 'image1.jpeg', 0.0, 1.5833, 10.0, 6.0833);
if ~isempty(p), p.crop_top = 0.17557; end

%% ===== Slide 7 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?  '}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1337, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5, 1.5833, 7.25, 4.9167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Natural Family Planning (NFP) is an old fashioned method of trying to prevent pregnancy (Some call it the Rhythm method or Calendar method)', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Natural Family Planning (NFP) ';
    apply_run_font_fp_(r, struct("pt", 40));
    r = p.add_run(); r.text = 'is an old fashioned method of trying to prevent pregnancy ';
    apply_run_font_fp_(r, struct("pt", 40));
    r = p.add_run(); r.text = '(Some call it the Rhythm method or Calendar method)';
    apply_run_font_fp_(r, struct("pt", 40));
end
p = add_pic_(sh, assets, 'image4.jpeg', 0.0, 3.7106, 2.5, 3.7795);

%% ===== Slide 8 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Myth!'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.0343, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.25, 1.9167, 7.25, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Modern NFP is NOT the old Rhythm method our grandparents and great-grandparents used, but is based on scientifically studied signs of fertility', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Modern NFP is NOT the old Rhythm method our grandparents and great-grandparents used, but is based on ';
    apply_run_font_fp_(r, struct("pt", 36));
    r = p.add_run(); r.text = 'scientifically studied signs of fertility';
    apply_run_font_fp_(r, struct("pt", 36));
end

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'What is NFP?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1918, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 3.25, 1.6121, 6.0625, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Scientific knowledge of    fertility', 0; ...
    'Reading body’s signs of fertility and infertility', 0; ...
    'Natural Family Planning (NFP)', 0; ...
    'Fertility Awareness Method (FAM)', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Reading body’s ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = 'signs of fertility ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = 'and infertility';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
end
tb = sh.add_textbox(In(9.0833), In(7.0464), In(0.5712), In(0.3702));
p = add_pic_(sh, assets, 'image5.png', 0.0, 3.4259, 2.5833, 4.0937);

%% ===== Slide 10 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Hormones in men'}, struct());
set_shape_box_(sh.item(1), 0.4167, 0.0833, 9.25, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
sp = sh.add_shape('rect', In(4.2778), In(2.3594), In(1.4444), In(0.3472));
fill_scheme_(sp, 'bg1', []);
tb = sh.add_textbox(In(4.375), In(2.3038), In(1.25), In(0.3698));
style_textbox_(tb.text_frame(), 'Men', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Stencil'));
tb = sh.add_textbox(In(9.0833), In(7.0464), In(0.5712), In(0.3702));
p = add_pic_(sh, assets, 'image1.jpeg', 0.0, 1.5833, 10.0, 6.0833);
if ~isempty(p), p.crop_top = 0.17557; end
p = add_pic_(sh, assets, 'image6.jpeg', 1.1771, 2.2205, 7.6458, 1.8152);
if ~isempty(p), p.crop_bottom = 0.59924; end

%% ===== Slide 11 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Hormones in women'}, struct());
set_shape_box_(sh.item(1), 0.4167, 0.0833, 9.25, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
sp = sh.add_shape('rect', In(4.2778), In(2.3594), In(1.4444), In(0.3472));
fill_scheme_(sp, 'bg1', []);
tb = sh.add_textbox(In(4.375), In(2.3038), In(1.25), In(0.3698));
style_textbox_(tb.text_frame(), 'Men', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Stencil'));
sp = sh.add_shape('rect', In(4.2639), In(4.1302), In(1.4444), In(0.3472));
fill_scheme_(sp, 'bg1', []);
tb = sh.add_textbox(In(4.2431), In(4.0382), In(1.5417), In(0.5));
style_textbox_(tb.text_frame(), 'Women', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Monotype Corsiva'));
tb = sh.add_textbox(In(9.0833), In(7.0464), In(0.5712), In(0.3702));
p = add_pic_(sh, assets, 'image1.jpeg', 0.0, 1.5833, 10.0, 6.0833);
if ~isempty(p), p.crop_top = 0.17557; end
p = add_pic_(sh, assets, 'image6.jpeg', 1.1771, 2.2205, 7.6458, 4.5295);

%% ===== Slide 12 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Putting it all together'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1605, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
tb = sh.add_textbox(In(0.0833), In(5.142), In(2.4008), In(2.2551));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'This image is freely available at ';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
r = p.add_run(); r.text = 'commons.wikimedia.org/wiki/ File:MenstrualCycle.png';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
try, r.hyperlink().address = 'http://commons.wikimedia.org/wiki/File:MenstrualCycle.png'; catch, end
r = p.add_run(); r.text = ' under a ';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
r = p.add_run(); r.text = 'creative commons cc-by-';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
try, r.hyperlink().address = 'http://creativecommons.org/licenses/by-sa/3.0/'; catch, end
r = p.add_run(); r.text = 'sa';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
try, r.hyperlink().address = 'http://creativecommons.org/licenses/by-sa/3.0/'; catch, end
r = p.add_run(); r.text = ' 3.0';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
try, r.hyperlink().address = 'http://creativecommons.org/licenses/by-sa/3.0/'; catch, end
r = p.add_run(); r.text = ' license';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.25), In(2.1667), In(2.2341), In(2.4571));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'I trust God’s design; He makes no mistakes; all of nature is cyclical';
apply_run_font_fp_(r, struct("pt", 20, "bold", true, "scheme", 'bg1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Fertility=Health';
apply_run_font_fp_(r, struct("pt", 20, "bold", true, "scheme", 'bg1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image7.png', 2.9167, 1.6102, 5.6667, 5.787);

%% ===== Slide 13 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'How NFP Works'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1918, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 2.0833, 6.9167, 4.9167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Measures changes in signs of fertility', 0; ...
    'Recorded on chart to define fertility and infertility ', 0; ...
    'Abstain or have relations based on absence or presence of fertile signs ', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Measures changes in signs ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = 'of fertility';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
end

%% ===== Slide 14 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Sample CCL Chart'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.2176, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
tb = sh.add_textbox(In(0.4011), In(1.75), In(1.8333), In(1.1781));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Sympto';
apply_run_font_fp_(r, struct("pt", 32, "bold", true, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
r = p.add_run(); r.text = '- thermal';
apply_run_font_fp_(r, struct("pt", 32, "bold", true, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
sp = sh.add_shape('roundRect', In(3.25), In(1.8333), In(6.1873), In(5.3333));
fill_scheme_(sp, 'bg1', []);
tb = sh.add_textbox(In(0.25), In(3.5833), In(2.1667), In(0.5049));
style_textbox_(tb.text_frame(), 'How we chart', struct("bullets", false, "autofit", "shape", "pt", 24, "bold", true, "scheme", 'bg1'));
p = add_pic_(sh, assets, 'image8.png', 3.3333, 2.4592, 6.0, 4.6571);
p = add_pic_(sh, assets, 'image9.png', 3.3472, 1.9802, 5.9861, 0.5619);
if ~isempty(p), p.crop_left = 0.00287; end
if ~isempty(p), p.crop_right = 0.00575; end

%% ===== Slide 15 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'“There’s an app for that”'}, struct());
set_shape_box_(sh.item(1), 0.8097, 0.1707, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 3.1972, 1.936, 5.5, 5.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Fertility monitors', 0; ...
    'Software', 0; ...
    'Mobile apps', 0; ...
    'Apps = virtual reality training', 0; ...
    'Classes = real life trial and error application and instruction', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
tb = sh.add_textbox(In(3), In(3.4161), In(6.25), In(1.3127));
style_textbox_(tb.text_frame(), '“User Beware”', struct("bullets", false, "autofit", "shape", "pt", 72, "rgb", [192 0 0]));
p = add_pic_(sh, assets, 'image10.jpeg', 0.4479, 3.9926, 1.5874, 1.0534);
if ~isempty(p), p.crop_left = 0.03189; end
if ~isempty(p), p.crop_top = 0.03711; end
if ~isempty(p), p.crop_right = 0.03415; end
if ~isempty(p), p.crop_bottom = 0.05392; end
p = add_pic_(sh, assets, 'image11.jpeg', 0.3999, 5.6772, 0.8981, 1.0429);
p = add_pic_(sh, assets, 'image12.jpeg', 1.3028, 5.6667, 0.7805, 1.0429);
p = add_pic_(sh, assets, 'image13.png', 0.4458, 2.1667, 1.5916, 1.2053);

%% ===== Slide 16 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1085, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.9167, 6.4531, 4.75);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Couples who use NFP have sex as often as couples who use contraception – they just time it differently.', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 17 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact!'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.0343, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.9167, 7.1667, 5.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'REALITY: If couples who practice NFP were to engage in intercourse on all the days when abstinence is not required for spacing births, they would be doing so at a rate almost twice the national average! NFP couples can make love no less frequently in each cycle than other couples.', 0; ...
    'Abstinence is a part of marriage', 0; ...
    'illness', 1; ...
    'Work travel', 1; ...
    'Military deployment', 1; ...
    'Birth', 1; ...
    'No one has died from NOT having sex', 1; ...
    }, struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 10000));
ps = tf.paragraphs();

%% ===== Slide 18 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'NFP Benefit #1'}, struct());
set_shape_box_(sh.item(1), 1.0, 1.25, 8.625, 3.1198);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 60, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 0.6667, 5.0, 9.2083, 1.6406);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Authentic Love…selfless, not selfish ', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Authentic';
    apply_run_font_fp_(r, struct("pt", 44, "scheme", 'tx1'));
    r = p.add_run(); r.text = ' Love…';
    apply_run_font_fp_(r, struct("pt", 44, "scheme", 'tx1'));
    r = p.add_run(); r.text = 'selfless';
    apply_run_font_fp_(r, struct("pt", 44, "scheme", 'tx1'));
    r = p.add_run(); r.text = ', not selfish ';
    apply_run_font_fp_(r, struct("pt", 44, "scheme", 'tx1'));
end

%% ===== Slide 19 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Marital love is a self-gift'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.0755, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6324, 1.75, 7.3333, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    '100%-100%, Not 50/50', 0; ...
    'Free, total, faithful, fruitful', 0; ...
    'Commitment at altar', 0; ...
    '“Have you come here freely to give yourselves to each other without reservation?”', 1; ...
    '“Do you promise to be faithful until death?”', 1; ...
    '“Do you promise to receive children lovingly from God?”', 1; ...
    }, struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image14.png', -0.0099, 2.75, 2.4699, 3.8333);

%% ===== Slide 20 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Every Sacrament—form & matter'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.4167, 0.0833, 9.25, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.25, 1.75, 7.75, 5.6667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Baptism=', 0; ...
    'form: baptize you in the name of the Father,…..', 1; ...
    'matter: water ', 1; ...
    'Eucharist=', 0; ...
    'Form: words of the last supper', 1; ...
    'Matter: bread and wine', 1; ...
    'Marriage=', 0; ...
    'Form:  vows made by the couple', 1; ...
    'Matter: consummation of the marriage (to complete a marriage by the first act of sexual intercourse)', 1; ...
    '	', 0; ...
    }, struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 10000));
ps = tf.paragraphs();

%% ===== Slide 21 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Sexual Intercourse=', 'Renewing Wedding Vows'}, struct("fontScale", 90000));
set_shape_box_(sh.item(1), 0.5833, 0.0833, 8.9167, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.25, 1.75, 7.5833, 5.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Now chastity made sense—we can’t renew vows we haven’t made', 0; ...
    'In our vows we promise to love: Freely, Totally, Faithfully, Fruitfully', 0; ...
    'With NFP we are free to give our complete selves the way God made us, just as we are, without altering ourselves—fertility is not an illness', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Now';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
    r = p.add_run(); r.text = ' chastity made sense—we can’t ';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
    r = p.add_run(); r.text = 'renew vows ';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
    r = p.add_run(); r.text = 'we haven’t made';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'With NFP we are free to give our ';
    apply_run_font_fp_(r, struct("pt", 39, "bold", true));
    r = p.add_run(); r.text = 'complete';
    apply_run_font_fp_(r, struct("pt", 39, "bold", true));
    r = p.add_run(); r.text = ' selves the way God made us, just as we are, without altering ourselves—';
    apply_run_font_fp_(r, struct("pt", 39, "bold", true));
    r = p.add_run(); r.text = 'fertility is not an illness';
    apply_run_font_fp_(r, struct("pt", 39, "bold", true));
end
p = add_pic_(sh, assets, 'image15.png', 0.0343, -0.1667, 1.799, 1.8091);

%% ===== Slide 22 · Blank =====
s = prs.slides().add_slide(lay_Blank);
sh = s.shapes();
tb = sh.add_textbox(In(0.8333), In(-0.5), In(9.1422), In(3.6015));
style_textbox_(tb.text_frame(), '© Couple to Couple League International', struct("bullets", false, "autofit", "shape", "pt", 12, "face", 'ArialMT', "rgb", [136 156 154]));
p = add_pic_(sh, assets, 'image16.emf', 2.371, -0.0002, 5.129, 7.4953);
p = add_pic_(sh, assets, 'image17.emf', 7.3367, 6.8333, 2.3573, 0.2027);

%% ===== Slide 23 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.9965, 6.6458, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Couples who practice NFP have a less than 5% divorce rate. ', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Couples who practice NFP have a less than 5% divorce rate. ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true, "cs", 'Aharoni'));
end

%% ===== Slide 24 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact!'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.25, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.9965, 6.7292, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Studies of shown that couples who practice Natural Family Planning have a divorce rate between 1-5%', 0; ...
    'Couples who pray together daily (not meal prayer) have a divorce rate of .01%', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 25 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'NFP Benefit #2 '}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0, 1.8846, 8.625, 3.1198);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 60, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 0.3333, 5.0191, 9.5, 1.6406);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Stronger Marriage & ', 0; ...
    'Greater Intimacy', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Stronger Marriage & ';
    apply_run_font_fp_(r, struct("pt", 44, "bold", true, "latin", 'Calibri', "cs", 'Calibri'));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Greater Intimacy';
    apply_run_font_fp_(r, struct("pt", 44, "bold", true, "latin", 'Calibri', "cs", 'Calibri'));
end

%% ===== Slide 26 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Why increased intimacy?'}, struct());
set_shape_box_(sh.item(1), 0.1667, 0.02, 9.6667, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.25, 1.4696, 7.5833, 6.0104);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Stronger relationships may be more likely to practice NFP', 0; ...
    'Couples who reject NFP as “too much trouble” or “too restrictive” all too often turn out to be the same couples who ultimately find the demands of marriage itself to be too much to handle ~Jason Evert', 1; ...
    'NFP takes virtue—so does marriage', 0; ...
    'commitment, communication, consideration, patience, sacrifice and self-control;  These are what makes marriage work.', 1; ...
    'NFP requires communication', 0; ...
    'Shared responsibility; chart together', 1; ...
    'Keeps spouses from taking each other for granted and relying on physical intimacy', 0; ...
    'Many women on contraception complain of feeling used. Contraception can lead the husband to assume that she was always sexually available. With NFP, Spouses are not constantly sexually available to the other ', 1; ...
    'Couples we know personally report that their physical life is better', 1; ...
    '              ', 1; ...
    }, struct("listProps", false, "fontScale", 47500, "lnSpcReduction", 20000));
ps = tf.paragraphs();

%% ===== Slide 27 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Chastity Tests Love'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 48, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.75, 7.0, 5.3368);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Immature views of love and relationship will rise to the surface when chastity is required', 0; ...
    'Abstinence is a built in a time when they can “court”; every kiss does not need to lead to the bedroom', 0; ...
    'Helps us focus on intellectual, emotional, spiritual intimacy', 0; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();

%% ===== Slide 28 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 3.0, 1.9965, 6.3125, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'The Catholic Church calls married couples to have as many children as possible.', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 29 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Myth!'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 3.0, 1.9965, 6.3125, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'REALITY:  The Catholic Church encourages people to be both generous and responsible stewards over their fertility.', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 30 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'NFP Benefit #3'}, struct());
set_shape_box_(sh.item(1), 1.25, 1.4167, 8.625, 3.1198);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 60, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.75, 5.0191, 6.5573, 1.6406);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Countercultural—Children viewed as a gift, not a burden', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Countercultural—Children viewed as a gift, not a burden';
    apply_run_font_fp_(r, struct("pt", 44, "bold", true, "scheme", 'tx1'));
end

%% ===== Slide 31 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Marital Embrace'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.9167, 1.9167, 6.5833, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Babies & Bonding', 0; ...
    '“So they are no longer two, but one flesh. Therefore what God has joined together, let no one separate.”  ', 0; ...
    '~Matthew 19:6', 8; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image18.jpeg', 0.0, 1.8983, 2.4995, 1.9167);
if ~isempty(p), p.crop_left = 0.03882; end
if ~isempty(p), p.crop_right = 0.09177; end

%% ===== Slide 32 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'But what about those huge families?'}, struct());
set_shape_box_(sh.item(1), 0.3333, 0.0885, 8.9792, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 36, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5, 1.75, 7.25, 4.75);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'All Christians are called to generosity', 0; ...
    'Nowhere in the Bible are children a curse or burden; they are ALWAYS a blessing; ', 0; ...
    'Couples who reject contraception are less likely to see children as a burden. Because of their generous spirit, they tend to have larger families, and divorce rates are highest where children are fewest.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Couples who reject contraception are less likely to see children as a burden. Because of their generous spirit, they tend to have larger families, and divorce rates are ';
    apply_run_font_fp_(r, struct("pt", 32));
    r = p.add_run(); r.text = 'highest';
    apply_run_font_fp_(r, struct("pt", 32));
    r = p.add_run(); r.text = ' where children are ';
    apply_run_font_fp_(r, struct("pt", 32));
    r = p.add_run(); r.text = 'fewest';
    apply_run_font_fp_(r, struct("pt", 32));
    r = p.add_run(); r.text = '.';
    apply_run_font_fp_(r, struct("pt", 32));
end
p = add_pic_(sh, assets, 'image19.png', 0.0, 2.526, 2.5, 2.0235);

%% ===== Slide 33 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Inviting God Into the Marriage'}, struct());
set_shape_box_(sh.item(1), 1.0833, 0.02, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.5833, 1.9965, 6.7292, 5.3368);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Monthly discernment of what God is calling that family to be', 0; ...
    'How’s our marriage?', 1; ...
    'How is our family doing?', 1; ...
    'Are we being generous? Prudent?', 1; ...
    'Lord help us overcome…', 1; ...
    'Lord, help us to trust…', 1; ...
    'Not telling God our plan, but asking Him', 0; ...
    'Wedding invitation analogy (from Christopher West)', 0; ...
    }, struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Not ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = 'telling';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = ' God our plan, but ';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = 'asking';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
    r = p.add_run(); r.text = ' Him';
    apply_run_font_fp_(r, struct("pt", 36, "bold", true));
end

%% ===== Slide 34 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 3.3333, 1.9965, 6.0833, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Only women with regular cycles can use NFP.', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 35 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Myth!'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.0343, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.8333, 1.9965, 6.4792, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Reality: NFP can be used by women with irregular cycles, and can even help detect, diagnose and treat health problems, including infertility. ', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 36 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'NFP Benefit #4'}, struct());
set_shape_box_(sh.item(1), 1.0833, 1.3333, 8.625, 3.1198);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 60, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 0.4167, 5.0191, 9.2917, 1.6406);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Safe, Healthy, and a Diagnostic Tool', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Safe, Healthy, and a Diagnostic Tool';
    apply_run_font_fp_(r, struct("pt", 44, "bold", true, "scheme", 'tx1'));
end

%% ===== Slide 37 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'If Sex is natural, ', 'why do we make it artificial?'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.25, 0.02, 9.5, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image20.png', 2.4167, 1.25, 5.25, 6.2531);
if ~isempty(p), p.crop_bottom = 0.15789; end

%% ===== Slide 38 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'How the pill and IUD work'}, struct());
set_shape_box_(sh.item(1), 0.9942, 0.0755, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.8194, 7.2917, 4.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Progestin convinces woman’s body she’s pregnant', 0; ...
    'Suppress ovulation', 1; ...
    'Back-up method thin uterine lining to prevent implantation (abortifacient)', 1; ...
    'Breakthrough ovulation common', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.0417), In(3.0833), In(2.4167), In(0.4376));
style_textbox_(tb.text_frame(), 'Combined pill', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 20, "face", 'Calibri', "rgb", [255 255 153]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 20, "latin", 'Calibri', "cs", 'Calibri', "rgb", [255 255 153])); end
tb = sh.add_textbox(In(0.9942), In(1.6233), In(0.7244), In(0.46));
style_textbox_(tb.text_frame(), '28%', struct("bullets", false, "autofit", "shape", "pt", 32, "face", 'Calibri', "scheme", 'bg1'));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 32, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1')); end
tb = sh.add_textbox(In(0.0417), In(5.0858), In(2.4167), In(0.4376));
style_textbox_(tb.text_frame(), 'Progestin-only', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 20, "face", 'Calibri', "rgb", [255 255 153]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 20, "latin", 'Calibri', "cs", 'Calibri', "rgb", [255 255 153])); end
tb = sh.add_textbox(In(0.7961), In(3.7973), In(1.1206), In(0.46));
style_textbox_(tb.text_frame(), '33-65%', struct("bullets", false, "autofit", "shape", "pt", 32, "face", 'Calibri', "scheme", 'bg1'));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 32, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1')); end
tb = sh.add_textbox(In(0.0417), In(6.9791), In(2.4167), In(0.4376));
style_textbox_(tb.text_frame(), 'Mirena', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 20, "face", 'Calibri', "rgb", [255 255 153]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 20, "latin", 'Calibri', "cs", 'Calibri', "rgb", [255 255 153])); end
tb = sh.add_textbox(In(0.9942), In(5.7067), In(0.7244), In(0.46));
style_textbox_(tb.text_frame(), '75%', struct("bullets", false, "autofit", "shape", "pt", 32, "face", 'Calibri', "scheme", 'bg1'));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 32, "latin", 'Calibri', "cs", 'Calibri', "scheme", 'bg1')); end
tb = sh.add_textbox(In(2.25), In(6.6105), In(7.381), In(0.6395));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Larimore W, Stanford J, ';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = 'Postfertilization';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = ' Effects of Oral Contraceptives and Their Relationship to Informed Consent, ';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = 'Arch ';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = 'Fam';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = ' M';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
r = p.add_run(); r.text = 'ed (2000);9:126-133.';
apply_run_font_fp_(r, struct("pt", 16, "latin", 'Calibri', "cs", 'Calibri'));
set_para_align_one_(p, 'r');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end

%% ===== Slide 39 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Adverse Effects'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.02, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 0.6875, 1.9965, 8.625, 5.3368);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Increased Risk of Breast Cancer (and other cancers)', 0; ...
    'Post contraceptive infertility', 0; ...
    'Decrease libido (artificial hormones increase Sex Hormone Binding Globulin, decrease testosterone levels, sometimes permanent damage)', 0; ...
    'Decreased bone density', 0; ...
    'Increased depression', 0; ...
    'Depo Provers (the shot): CA administers it to sex offenders; veterinarians won’t give it to dogs', 0; ...
    'If mom conceives on the Pill, sons are more likely to develop prostate cancer', 0; ...
    'Speaking of Pure water…Damage to the environment', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 40 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'“Gallup poll”'}, struct());
set_shape_box_(sh.item(1), 0.6875, -0.0429, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.75, 7.0833, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Of the women in the US who discontinued hormonal contraceptives, how many did so because of side effects?', 0; ...
    '33%', 1; ...
    '43%', 1; ...
    '53%', 1; ...
    '64%', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Of the women in the US ';
    r = p.add_run(); r.text = 'who discontinued hormonal contraceptives, how many ';
    r = p.add_run(); r.text = 'did so because of side effects?';
end
sp = sh.add_shape('rect', In(3.3993), In(5.4905), In(1.2361), In(0.3681));
fill_rgb_(sp, [255 255 255]);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(3.1771), In(4.064), In(2.9167), In(0.5833));
style_textbox_(tb.text_frame(), '64%', struct("bullets", false, "anchor", 't', "autofit", "none", "rgb", [88 176 0]));
tb = sh.add_textbox(In(2.5), In(4.456), In(7.0833), In(0.7742));
style_textbox_(tb.text_frame(), 'National Survey of Family Growth 2010, CDC, Series 23, Number 29, 69.', struct("bullets", false, "align", 'r', "autofit", "shape", "pt", 20, "face", 'Calibri'));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 20, "latin", 'Calibri', "cs", 'Calibri')); end
p = add_pic_(sh, assets, 'image21.jpeg', 0.0, 3.2886, 2.5, 3.7739);
if ~isempty(p), p.crop_top = 0.02579; end

%% ===== Slide 41 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Diagnostic Tool'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 40, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.511, 1.5918, 7.489, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Charting fertility signs can help discover or diagnose health issues such as:', 0; ...
    'Low thyroid', 2; ...
    'Low progesterone', 2; ...
    'Repeated miscarriage', 2; ...
    'Infertility', 2; ...
    'Depression', 2; ...
    'Polycystic Ovarian Syndrome', 2; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();

%% ===== Slide 42 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact or Myth?'}, struct());
set_shape_box_(sh.item(1), 0.6875, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.9965, 6.6458, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Natural Family Planning is just as effective at limiting births as artificial means.', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();

%% ===== Slide 43 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Fact!'}, struct());
set_shape_box_(sh.item(1), 0.7267, 0.1667, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 48, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.6667, 1.9965, 6.6458, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Modern scientific NFP is 99% effective at limiting birth when couples are motivated to follow the rules (80-90% effective when they don’t even follow the rules)', 0; ...
    '3 Xs more successful than modern technology in helping couples of limited fertility achieve pregnancy', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = '3 ';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
    r = p.add_run(); r.text = 'Xs';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
    r = p.add_run(); r.text = ' more successful than modern technology in helping couples of limited fertility achieve pregnancy';
    apply_run_font_fp_(r, struct("pt", 32, "bold", true));
end

%% ===== Slide 44 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'   NFP Benefit #5'}, struct());
set_shape_box_(sh.item(1), 0.7166, 0.8403, 8.625, 3.1198);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 60, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Effective', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Effective';
    apply_run_font_fp_(r, struct("pt", 44, "scheme", 'tx1'));
end

%% ===== Slide 45 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image22.png', 0.0, 0.72, 10.0, 6.06);

%% ===== Slide 46 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'NFP to achieve a pregnancy'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.4167, 0.0833, 9.5833, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 5.2475, 1.6225, 4.5025, 5.0441);
tf = body.text_frame();
style_body_levels_(tf, { ...
    '10-15% of couples suffer from infertility (more than 1 year of trying to conceive', 0; ...
    'Fertility awareness can help couples conceive in half the time or less', 0; ...
    'Knowing how to identify the fertile window is key', 0; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Fertility awareness can help couples ';
    apply_run_font_fp_(r, struct("pt", 28));
    r = p.add_run(); r.text = 'conceive ';
    apply_run_font_fp_(r, struct("pt", 28));
    r = p.add_run(); r.text = 'in half the time or less';
    apply_run_font_fp_(r, struct("pt", 28, "rgb", [88 176 0]));
end
p = add_pic_(sh, assets, 'image1.jpeg', 0.0, 1.5833, 5.0, 5.9323);
if ~isempty(p), p.crop_top = 0.17557; end
p = add_pic_(sh, assets, 'image23.jpeg', 0.0, 2.0, 4.7865, 3.5139);

%% ===== Slide 47 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'WebMD'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 2.8333, 1.75, 7.1667, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    '“A relatively high failure rate has been reported.” ', 0; ...
    'The “failure rate” WebMD cites combined data from modern NFP methods with data from calendar methods artificially lowering the effectiveness of NFP', 1; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'The “failure rate” WebMD ';
    apply_run_font_fp_(r, struct("pt", 32, "rgb", [88 176 0]));
    r = p.add_run(); r.text = 'cites combined data from modern NFP methods with ';
    apply_run_font_fp_(r, struct("pt", 32, "rgb", [88 176 0]));
    r = p.add_run(); r.text = 'data from calendar methods artificially lowering the effectiveness of NFP';
    apply_run_font_fp_(r, struct("pt", 32, "rgb", [88 176 0]));
end

%% ===== Slide 48 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'But isn’t it too complicated and unrealistic?'}, struct());
set_shape_box_(sh.item(1), 0.3333, 0.0343, 9.25, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 44, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 0.6875, 1.5833, 8.625, 5.9167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'In a World Health Organization (WHO) study, 725 couples from five countries – El Salvador, India, New Zealand, Ireland, and the Philippines – were taught the ovulation method of NFP over the course of three months. After a year the couples were evaluated, and the method effectiveness rate was 97.2%. Note: half of the Salvadorean couples were illiterate, proving that an advanced education is unnecessary for learning NFP effectively', 0; ...
    'British medical journal report: study of 19,000 women in India (52% Hindu, 27% Muslim, and 21% Christian)—failure rate of almost 0% ( 0.2 pregnancies/100 women).  Thanks to Mother Teresa, couples avoided government mandated sterilization in the 70s; today India still has sterilization quotas, leading to many deaths from botched operations ', 0; ...
    'From a publication of the Missionaries of Charity “Many people wonder how poor couples can exercise self-control for more than one week. Yes, they do it; it is possible. It is, after all, their own choice. Some abstain for twenty days a month; others for one, two, and even three months. From our experience we find that it is more difficult for an educated couple to abstain than for a poor and illiterate couple. Why? Perhaps because the wealthy and educated couples have more comforts, and are more inclined to enjoy the good things of life.”', 1; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'In a World Health Organization (WHO) study, 725 couples from five countries – El Salvador, India, New Zealand, Ireland, and the Philippines – were taught the ovulation method of NFP over the course of three months. After a year the couples were evaluated, and the method effectiveness rate was 97.2%. Note: half of the ';
    r = p.add_run(); r.text = 'Salvadorean';
    r = p.add_run(); r.text = ' couples were illiterate, proving that an advanced education is unnecessary for learning NFP effectively';
end

%% ===== Slide 49 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Isn’t NFP just “natural” birth control'}, struct());
set_shape_box_(sh.item(1), 0.7022, 0.2156, 8.625, 1.4497);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 32, "bold", true, "latin", 'Aharoni', "cs", 'Aharoni', "scheme", 'bg1'));
body = sh.item(2);
set_shape_box_(body, 2.8333, 1.8009, 6.4792, 4.7587);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'NFP is birth control; it is not contra-ception (against life).', 0; ...
    'Yes, a couple using NFP could be closed to God’s will; they could use it selfishly—but rare', 0; ...
    'One is a lack of generosity; the other is using the body and making a loving act intentionally sterile, potentially aborting a new life, and separating what God designed', 0; ...
    'Two women wishing to stay slim analogy', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'NFP is birth control; it is not contra-';
    apply_run_font_fp_(r, struct("pt", 28, "bold", true));
    r = p.add_run(); r.text = 'ception';
    apply_run_font_fp_(r, struct("pt", 28, "bold", true));
    r = p.add_run(); r.text = ' (against life).';
    apply_run_font_fp_(r, struct("pt", 28, "bold", true));
end

%% ===== Slide 50 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Resources'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 2.5, 1.6667, 6.75, 4.5);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Web resources', 0; ...
    'fertilitycare.org', 1; ...
    'Chastity.com', 1; ...
    'popepaulvi.com', 1; ...
    'ccli.org', 1; ...
    'boma-usa.org', 1; ...
    'nfp.marquette.edu', 1; ...
    'nfpandmore.org', 1; ...
    'onemoresoul.com', 1; ...
    'nwfs.org', 1; ...
    'http://nfpsst.org/fact-or-fiction/', 1; ...
    'usccb.org/issues-and-action/marriage-and-family/', 1; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 12
    p = ps{12}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'usccb.org/issues-and-action/';
    apply_run_font_fp_(r, struct("pt", 22));
    r = p.add_run(); r.text = 'marriage-and-family/';
    apply_run_font_fp_(r, struct("pt", 22));
end
p = add_pic_(sh, assets, 'image24.jpeg', 0.0, 4.6299, 2.5, 2.8743);
if ~isempty(p), p.crop_bottom = 0.17963; end

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

