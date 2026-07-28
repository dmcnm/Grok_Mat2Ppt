%% demo.m — 08_Dropbox_a_Holy_Child__Experiment_14_Atoms_and_Molecules
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
lay_Title_Only = layouts.get_by_name('Title Only');
lay_Title_Slide = layouts.get_by_name('Title Slide');
lay_Title_and_Content = layouts.get_by_name('Title and Content');

%% ===== Slide 1 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Nucleation and Growth of Crystalline Structures On A Treated Substrate From A Supersaturated Solution Of C12H22O11'}, struct());
set_shape_box_(sh.item(1), 0.4167, 0.3003, 9.0729, 5.783);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("bold", true, "latin", 'Comic Sans MS'));
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 2 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Nucleation and Growth of Crystalline Structures On A Treated Substrate From A Supersaturated Solution Of C12H22O11'}, struct());
set_shape_box_(sh.item(1), 0.4583, 0.3003, 9.0729, 5.783);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("bold", true, "latin", 'Comic Sans MS'));
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('ellipse', In(2.1354), In(0.4167), In(6.1354), In(6.1354));
fill_rgb_(sp, [255 0 0]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.5625), In(0.8229), In(5.3542), In(5.3542));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('rect', In(2.4375), In(3.1771), In(5.5938), In(0.3958));
fill_rgb_(sp, [255 0 0]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(0.1667), In(6.25), In(4.1562), In(0.5049));
style_textbox_(tb.text_frame(), 'No!!!  Too Complicated!', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 24, "bold", true, "face", 'Comic Sans MS', "rgb", [255 0 0]));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 3 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Better Title:', 'Making Rock Candy!'}, struct());
set_shape_box_(sh.item(1), 0.5, 0.3003, 9.0, 1.7413);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 48, "latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(2.3333), In(6.1794), In(5.3333), In(0.7068));
style_textbox_(tb.text_frame(), 'And Other Crystals', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 36, "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image1.jpeg', 3.1771, 2.1771, 3.6458, 3.6458);

%% ===== Slide 4 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
set_shape_box_(sh.item(2), 0.4167, 0.4167, 9.0833, 0.9167);
tf = sh.item(2).text_frame(); tf.clear();
ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Funny Election Sign';
apply_run_font_fp_(r, struct("pt", 44, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
apply_norm_autofit_(tf, struct());
sp = sh.add_shape('rect', In(1.25), In(6.5), In(7.5833), In(0.3333));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image2.jpeg', 1.25, 1.75, 7.5833, 5.0505);

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Lab Safety Today'}, struct());
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS', "rgb", [255 0 0]));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 4.1667, 4.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'We will be using a hot stove to make our rock candy solution. Let the adults do the cooking!', 0; ...
    'Be careful with          your glass jars', 0; ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'We will be using ';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = 'a hot stove ';
    apply_run_font_fp_(r, struct("bold", true, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
    r = p.add_run(); r.text = 'to make our rock candy solution. Let the adults do the cooking!';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS'));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Be careful with          your glass jars';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS'));
end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image3.jpeg', 5.7222, 1.7552, 3.2292, 1.6979);
p = add_pic_(sh, assets, 'image4.jpeg', 4.5398, 3.8333, 2.9602, 3.0);

%% ===== Slide 6 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Experiment 1: Growing Rock Candy Crystals That You Can Eat'}, struct("fontScale", 90000));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
sp = sh.add_shape('can', In(5), In(2.9583), In(2.0541), In(3.7708));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.0104), In(3.7188), In(2.0417), In(3.0625));
fill_scheme_(sp, 'bg2', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.0417), In(3.0833), In(0.0729), In(2.6562));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.1068), In(3.3281), In(0.0573), In(0.026));
sp = sh.add_shape('rect', In(5.8385), In(3.4688), In(0.0755), In(0.0026));
sp = sh.add_shape('rect', In(5.3594), In(3.4193), In(0.1797), In(0.0182));
sp = sh.add_shape('rect', In(5.9974), In(4.5443), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.9583), In(5.3672), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.9896), In(4.8776), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.1146), In(4.7083), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.0781), In(5.2318), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.0755), In(5.0078), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.9948), In(5.1276), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.0807), In(5.3932), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(6.0859), In(4.4401), In(0.0651), In(0.0677));
fill_scheme_(sp, 'bg1', []);
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(5.8828), In(2.9549), In(0.1328), In(0.0061));
sp = sh.add_shape('rect', In(6.3724), In(2.9688), In(0.112), In(0.0078));
sp = sh.add_shape('rect', In(6.7552), In(3.0365), In(0.0547), In(0.013));
tb = sh.add_textbox(In(7.1042), In(6.0521), In(1.8646), In(0.7068));
style_textbox_(tb.text_frame(), 'Pint jar with lid', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
tb = sh.add_textbox(In(6.9687), In(2.4792), In(1.4375), In(0.4039));
style_textbox_(tb.text_frame(), 'Clothespin', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
tb = sh.add_textbox(In(7.6667), In(3.3333), In(1.3333), In(0.7068));
style_textbox_(tb.text_frame(), 'Piece of string', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
tb = sh.add_textbox(In(3.5417), In(5.2708), In(1.3333), In(1.0098));
style_textbox_(tb.text_frame(), 'Hot sugar solution', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
tb = sh.add_textbox(In(7.1771), In(4.6146), In(1.3333), In(0.7068));
style_textbox_(tb.text_frame(), 'Sugar crystals', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
sp = sh.add_shape('rect', In(6.2188), In(4.5885), In(1.2083), In(0.2344));
sp = sh.add_shape('rect', In(6.1771), In(3.5625), In(1.4896), In(0.4583));
tb = sh.add_textbox(In(7.3437), In(5.4375), In(1.3333), In(0.4039));
style_textbox_(tb.text_frame(), 'Paper clip', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS', "rgb", [102 0 255]));
sp = sh.add_shape('rect', In(6.3333), In(5.5399), In(0.9062), In(0.3351));
tb = sh.add_textbox(In(0.5), In(2.0833), In(3.0392), In(4.9497));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Materials:';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "scheme", 'tx1'));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Kettle or pot';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Distilled water';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Sugar';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Wooden spoon';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Ladle';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Pint jar with lid';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'String';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Paper clip';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Clothespin';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Flavorings';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Food';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
r = p.add_run(); r.text = ' coloring';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Wax paper';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
apply_no_bullet_all_(tf);
apply_norm_autofit_(tf, struct("fontScale", 92500, "lnSpcReduction", 20000));
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image5.png', 5.6771, 2.1582, 0.4619, 2.1058);
if ~isempty(p), p.crop_left = 0.44278; end
if ~isempty(p), p.crop_top = 0.03522; end
if ~isempty(p), p.crop_right = 0.44389; end
if ~isempty(p), p.crop_bottom = 0.04216; end
p = add_pic_(sh, assets, 'image6.png', 5.875, 5.5486, 0.4355, 1.1493);
if ~isempty(p), p.crop_left = 0.30859; end
if ~isempty(p), p.crop_right = 0.3125; end
cxn = sh.add_connector('line', E(4572000), E(3224213), E(4572001), E(3457575));
style_connector_(cxn, struct("w", 19050, "scheme", 'tx1'));
cxn = sh.add_connector('line', E(4572001), E(3088481), E(4569619), E(3138488));
style_connector_(cxn, struct("w", 19050, "scheme", 'tx1'));
cxn = sh.add_connector('straightConnector1', E(4400550), E(5257800), E(4848225), E(5200650));
style_connector_(cxn, struct("w", 12700, "scheme", 'tx1', "tail", 'triangle', "tailW", 'med', "tailLen", 'med'));

%% ===== Slide 7 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Now Let’s Go To The Kitchen'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.5, 1.7378, 9.0, 3.0955);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 72, "latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 8 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Procedure for Experiment 1'}, struct());
set_shape_box_(sh.item(1), 0.5, 0.6337, 9.0, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
body = sh.item(2);
set_shape_box_(body, 0.5, 2.0833, 9.0, 4.8333);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'This makes enough solution for 16 pint jars.', 0; ...
    'In large kettles, boil 16 cups (4 quarts) of distilled water.', 0; ...
    'We will need 40 cups of sugar.', 0; ...
    'Slowly add 10 cups of sugar to each quart of boiling water, stirring until the sugar dissolves.', 0; ...
    'Allow the solution to cool for 20 minutes.', 0; ...
    'Fill each jar full of the solution using the ladle.', 0; ...
    'Add food coloring and flavoring to your jar!', 0; ...
    }, struct("listProps", false, "fontScale", 85000, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'This makes enough solution for 16 pint jars.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'In large kettles, boil 16 cups (4 quarts) of distilled water.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'We will need 40 cups of sugar.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Slowly add 10 cups of sugar to each quart of boiling water, stirring until the sugar dissolves.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Allow the solution to cool for 20 minutes.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Fill each jar full of the solution using the ladle.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Add food coloring and flavoring to your jar!';
    apply_run_font_fp_(r, struct("bold", true, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Finishing Experiment 1'}, struct());
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.5208, 9.0833, 5.25);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Tie one end of a 6-inch piece of string to the center of a clothespin and the other end to the end of a paper clip.', 0; ...
    'Dip your string into the sugar solution.', 0; ...
    'Roll your string in some sugar.', 0; ...
    'Let the string cool down.', 0; ...
    'Very Important: Shake off any extra sugar.', 0; ...
    'Lower the string into the jar of hot sugar solution, resting the clothespin on the jar lid.', 0; ...
    'Keep the bottom end of the paper clip a half inch or so above the bottom of the jar.', 0; ...
    'Put jar in a safe, warm place and wait one week.', 0; ...
    'Do not disturb the jar while you are waiting for the crystals to form.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Tie one end of a 6-inch piece of string to the center of a clothespin and the other end to the end of a paper clip.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Dip your string into the sugar solution.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Roll your string in some sugar.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Let the string cool down.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Very Important: ';
    apply_run_font_fp_(r, struct("pt", 22, "bold", true, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
    r = p.add_run(); r.text = 'Shake off any extra sugar.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Lower the string into the jar of hot sugar solution, resting the clothespin on the jar lid.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Keep the bottom end of the paper clip a half inch or so above the bottom of the jar.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 8
    p = ps{8}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Put jar in a safe, warm place and wait one week.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Do not disturb the jar while you are waiting for the crystals to form.';
    apply_run_font_fp_(r, struct("pt", 22, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 10 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Back To The Classroom'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.5, 1.6337, 9.0, 2.6892);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 72, "latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 11 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Some Beautiful Crystals'}, struct("autofit", "none"));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(2.6458), In(5.0104), In(2.3021), In(1.3127));
style_textbox_(tb.text_frame(), 'Geode with crystals inside', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 24, "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image7.jpeg', 0.8229, 1.7812, 3.4701, 2.1146);
p = add_pic_(sh, assets, 'image8.png', 4.5035, 1.5382, 5.0, 2.6562);
p = add_pic_(sh, assets, 'image9.jpeg', 5.2743, 4.217, 2.6944, 2.7447);

%% ===== Slide 12 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'More Crystals!'}, struct("autofit", "none"));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(1.3333), In(3.8333), In(1.75), In(0.4039));
style_textbox_(tb.text_frame(), 'Quartz', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(6.0833), In(4.6667), In(1.75), In(0.7068));
style_textbox_(tb.text_frame(), 'Cinnabar (mercury)', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(3.25), In(5.4167), In(1.75), In(0.7068));
style_textbox_(tb.text_frame(), 'Pyrite (fool’s gold)', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image10.jpeg', 0.8958, 1.6667, 2.6042, 2.0833);
p = add_pic_(sh, assets, 'image11.jpeg', 5.25, 2.0833, 3.3223, 2.5);
p = add_pic_(sh, assets, 'image12.jpeg', 0.9167, 4.5, 2.2917, 2.0417);

%% ===== Slide 13 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cave of Crystals, Mexico (Gypsum)'}, struct("fontScale", 90000));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image13.jpeg', 0.9804, 1.6667, 8.0196, 5.3333);

%% ===== Slide 14 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'So, What are Crystals?'}, struct("autofit", "none"));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Crystals are solids.', 0; ...
    'They have regular geometric shapes.', 0; ...
    'They have faces, or facets that meet at sharp angles.', 0; ...
    'They are mostly found in rocks (although there are ice crystals too).', 0; ...
    'They are orderly arrangements of a single kind of atom or molecule.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Crystals are solids.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'They have regular geometric shapes.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'They have faces, or ';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
    r = p.add_run(); r.text = 'facets';
    apply_run_font_fp_(r, struct("bold", true, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
    r = p.add_run(); r.text = ' that meet at sharp angles.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'They are mostly found in rocks (although there are ice crystals too).';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'They are ';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
    r = p.add_run(); r.text = 'orderly arrangements';
    apply_run_font_fp_(r, struct("bold", true, "latin", 'Comic Sans MS', "rgb", [255 0 0]));
    r = p.add_run(); r.text = ' of a single kind of atom or molecule.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 15 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'What Do I Mean by “Orderly”?'}, struct("fontScale", 90000));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
sp = sh.add_shape('ellipse', In(1.3333), In(5.1249), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.5), In(5.0833), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.5833), In(4.7179), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.75), In(4.6763), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2), In(5.0416), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.1667), In(5), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.25), In(4.7083), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.4167), In(4.6667), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2), In(4.6577), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.1667), In(4.6161), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.8333), In(5.2916), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2), In(5.25), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.1562), In(4.6575), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.3229), In(4.6159), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.9167), In(4.2916), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(2.0834), In(4.25), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.3333), In(4.2083), In(0.1667), In(0.1667));
fill_rgb_(sp, [102 0 255]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
sp = sh.add_shape('ellipse', In(1.5), In(4.1667), In(0.25), In(0.25));
fill_rgb_(sp, [0 176 80]);
apply_shape_style_office_(sp);
apply_line_no_fill_(sp);
tb = sh.add_textbox(In(1.5833), In(4), In(1.75), In(0.4167));
style_textbox_(tb.text_frame(), 'Orderly', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(1.6667), In(6.5833), In(1.75), In(0.4167));
style_textbox_(tb.text_frame(), 'Disorderly', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
sp = sh.add_shape('rect', In(3.6471), In(2.4788), In(1.6275), In(0.8644));
tb = sh.add_textbox(In(6.3333), In(5.1667), In(1.75), In(0.4167));
style_textbox_(tb.text_frame(), 'Halite (salt)', struct("bullets", false, "align", 'ctr', "autofit", "shape", "face", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image14.png', 1.4167, 1.8333, 2.1097, 2.0);
p = add_pic_(sh, assets, 'image15.jpeg', 5.4167, 1.8333, 3.5584, 3.25);

%% ===== Slide 16 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Experiment 2: Growing Needle-Shaped Crystals'}, struct("fontScale", 90000));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
tb = sh.add_textbox(In(0.5), In(2.0833), In(3.0392), In(4.9497));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Materials:';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "scheme", 'tx1'));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Plastic plate';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Plastic bowl';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Sheet of black construction paper';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Baby food jar with lid';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Tablespoon';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Scissors';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "cs", '+mn-cs', "cap", 'none', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Epsom salt';
apply_run_font_fp_(r, struct("pt", 24, "latin", 'Comic Sans MS', "rgb", [102 0 255]));
set_para_lnspc_pct_(p, 100000);
set_para_align_one_(p, 'l');
set_para_bu_none_(p);
apply_no_bullet_all_(tf);
apply_norm_autofit_(tf, struct("lnSpcReduction", 10000));
try, tf.word_wrap = true; catch, end
sp = sh.add_shape('rect', In(7.25), In(1.9167), In(1.75), In(1.25));
fill_scheme_(sp, 'tx1', []);
apply_shape_style_office_(sp);
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image16.jpeg', 4.3333, 2.0, 2.0, 2.0);
p = add_pic_(sh, assets, 'image17.jpeg', 3.6667, 3.9167, 2.0833, 2.2409);
p = add_pic_(sh, assets, 'image18.jpeg', 6.4167, 3.5, 1.3618, 1.6021);
p = add_pic_(sh, assets, 'image19.jpeg', 7.5685, 4.0148, 2.3233, 0.9603);
p = add_pic_(sh, assets, 'image20.gif', 6.25, 5.1667, 1.8229, 1.8229);

%% ===== Slide 17 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Procedure for Experiment 2'}, struct());
set_shape_box_(sh.item(1), 0.5, 0.6337, 9.0, 1.25);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
body = sh.item(2);
set_shape_box_(body, 0.5, 2.0833, 9.0, 4.8333);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Turn your bowl upside down on the construction paper and trace it.', 0; ...
    'Cut the circle out and fit it inside the plastic plate.', 0; ...
    'Fill the baby food jar half full of warm water, then add 2 Tablespoons of epsom salt.', 0; ...
    'Put the lid on and shake 60 times.', 0; ...
    'Let the contents of the jar settle for a couple of minutes.', 0; ...
    'Pour the liquid onto the black paper. Don’t pour any undissolved epsom salt onto the paper.', 0; ...
    'Wait a few days, then look at the crystals. What do they look like?', 0; ...
    }, struct("listProps", false, "fontScale", 77500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Turn your bowl upside down on the construction paper and trace it.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Cut the circle out and fit it inside the plastic plate.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Fill the baby food jar half full of warm water, then add 2 Tablespoons of epsom salt.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Put the lid on and shake 60 times.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Let the contents of the jar settle for a couple of minutes.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Pour the liquid onto the black paper. Don’t pour any undissolved epsom salt onto the paper.';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Wait a few days, then look at the crystals. What do they look like?';
    apply_run_font_fp_(r, struct("latin", 'Comic Sans MS', "rgb", [102 0 255]));
end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));

%% ===== Slide 18 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Science Vocabulary for This Week'}, struct("fontScale", 90000));
apply_title_run_fonts_(sh.item(1).text_frame(), struct("latin", 'Comic Sans MS'));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.3646, 4.0625, 5.7708);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Crystal – a large, orderly arrangement of atoms or molecules in neat rows.', 0; ...
    'Solvent – a liquid (like water) that you dissolve stuff in.', 0; ...
    'Solute – a solid (like sugar) that you dissolve in the solvent.', 0; ...
    'Solution – the mixture of solvent and solute (like sugar water).', 0; ...
    'Saturated solution – a solution (like sugar in water) that can’t hold any more solute.', 0; ...
    'Supersaturated solution – a solution that has been heated and holds more solute (like sugar) than it can at room temperature.', 0; ...
    'Nucleation – the process in which a sugar molecule (solute) comes out of the sugar water solution and sticks to the sugar crystals on the string.', 0; ...
    }, struct("listProps", false, "fontScale", 77500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Crystal';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = ' – a large, orderly arrangement of atoms or molecules in neat rows.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Solvent ';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = '– a liquid (like water) that you dissolve stuff in.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Solute ';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = '– a solid (like sugar) that you dissolve in the solvent.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Solution';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = ' – the mixture of solvent and solute (like sugar water).';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Saturated solution';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = ' – a solution (like sugar in water) that can’t hold any more solute.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Supersaturated solution';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = ' – a solution that has been heated and holds more solute (like sugar) than it can at room temperature.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Nucleation';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
    r = p.add_run(); r.text = ' – the process in which a sugar molecule (solute) comes out of the sugar water solution and sticks to the sugar crystals on the string.';
    apply_run_font_fp_(r, struct("pt", 20, "latin", 'Comic Sans MS'));
end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
sp = sh.add_shape('rect', In(0.1701), In(-0.158), In(0.3333), In(0.3333));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0.5), In(6.9), In(12.3), In(0.4));
style_textbox_(tb.text_frame(), 'Atoms and Molecules Session 14', struct("bullets", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image21.jpeg', 5.0868, 1.5938, 4.3542, 2.4062);
p = add_pic_(sh, assets, 'image7.jpeg', 5.5833, 4.1667, 3.4701, 2.1146);

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

