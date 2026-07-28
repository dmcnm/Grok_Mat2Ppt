%% demo.m — 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2
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
lay_Title_Slide = layouts.get_by_name('Title Slide');
lay_Title_and_Content = layouts.get_by_name('Title and Content');
lay_Two_Content = layouts.get_by_name('Two Content');
lay_Title_Text_and_Content = layouts.get_by_name('Title, Text, and Content');
lay_Title_Only = layouts.get_by_name('Title Only');
lay_Blank = layouts.get_by_name('Blank');

%% ===== Slide 1 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable ', 'Effects ', 'Study Program Review', 'and Cable Modelling Approach'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.1667, 1.7889, 9.4167, 1.7944);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 36, "cs", 'Lucida Sans Unicode', "rgb", [0 112 192]));
set_shape_box_(sh.item(2), 2.5, 3.8333, 5.0, 1.4167);
tf = sh.item(2).text_frame(); tf.clear();
ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Douglas Coombs';
apply_run_font_fp_(r, struct("pt", 28, "scheme", 'tx1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'May 2, 2011';
apply_run_font_fp_(r, struct("pt", 28, "cs", 'Lucida Sans Unicode'));
apply_no_autofit_(tf);
sp = sh.add_shape('rect', In(0.2083), In(1.3333), In(9.5833), In(2.5833));
try, sp.fill().background(); catch, end
apply_line_no_fill_(sp);
p = add_pic_(sh, assets, 'image6.png', 0.5, 5.0833, 2.0393, 1.6667);

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The Cable Effects Study Missions'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.4028, 0.0625, 7.1806, 1.1875);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 28));
body = sh.item(2);
set_shape_box_(body, 0.1667, 1.3073, 6.0833, 5.6094);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Do electrical cable harnesses significantly affect dynamics of precision spacecraft structures?', 0; ...
    'Lightweight and with stringent jitter budgets', 1; ...
    'Cable harnesses are generally not included in spacecraft structural design.  As a consequence:', 0; ...
    'Models and designs are overly conservative', 1; ...
    'Isolation system requirements are too stringent', 1; ...
    'Structural control systems may be adversely affected by plant model errors', 1; ...
    'Motivation: develop techniques and methodologies to incorporate cable dynamics in models thereby reducing conservatism and program risk', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1, set_para_lnspc_pct_(ps{1}, 75000); end
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Do electrical cable harnesses ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'significantly';
    apply_run_font_fp_(r, struct("pt", 24, "rgb", [35 35 220]));
    r = p.add_run(); r.text = ' affect dynamics of precision spacecraft structures?';
    apply_run_font_fp_(r, struct("pt", 24));
    set_para_lnspc_pct_(p, 75000);
end
if numel(ps) >= 2, set_para_lnspc_pct_(ps{2}, 69000); end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Lightweight ';
    r = p.add_run(); r.text = 'and with stringent ';
    r = p.add_run(); r.text = 'jitter budgets';
    set_para_lnspc_pct_(p, 69000);
end
if numel(ps) >= 3, set_para_lnspc_pct_(ps{3}, 75000); end
if numel(ps) >= 4, set_para_lnspc_pct_(ps{4}, 69000); end
if numel(ps) >= 5, set_para_lnspc_pct_(ps{5}, 69000); end
if numel(ps) >= 6, set_para_lnspc_pct_(ps{6}, 69000); end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Structural control systems may be adversely affected ';
    r = p.add_run(); r.text = 'by ';
    r = p.add_run(); r.text = 'plant model errors';
    set_para_lnspc_pct_(p, 69000);
end
if numel(ps) >= 7, set_para_lnspc_pct_(ps{7}, 75000); end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Motivation:';
    apply_run_font_fp_(r, struct("pt", 24, "rgb", [35 35 220]));
    r = p.add_run(); r.text = ' develop techniques and methodologies to incorporate cable dynamics in models thereby reducing conservatism and program ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'risk';
    apply_run_font_fp_(r, struct("pt", 24));
    set_para_lnspc_pct_(p, 75000);
end
tb = sh.add_textbox(In(6.0797), In(5.1667), In(3.9203), In(1.0266));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Cabling makes a significant amount of dry mass';
apply_run_font_fp_(r, struct("pt", 11, "bold", true, "rgb", [0 112 192]));
set_para_align_one_(p, 'ctr');
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("pt", 11, "bold", true, "rgb", [0 112 192]));
set_para_align_one_(p, 'ctr');
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'http://www.dlr.de/rd/en/Portaldata/1/Resources/portal_news/newsarchiv2009_3/Tandem-X_intergration_380.jpg';
apply_run_font_fp_(r, struct("pt", 11, "bold", true, "rgb", [0 112 192]));
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image7.jpeg', 6.0417, 2.25, 3.9583, 2.8542);

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The Why of the', 'Cable Effects Study'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.25, 1.3559, 9.5833, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    ' Cable harnesses are a large part of spacecraft mass and generally considered a non-structural component at low frequencies. ', 0; ...
    'A survey showed that the cable-to-structure mass ratio for DoD and commercial spacecraft can approach 25%.', 1; ...
    'Cables are not modeled in detail because no one cared about the “mid frequency” range until a need for better large precision structure models was identified.  ', 0; ...
    'Mission performance is driven by on-orbit dynamics: better models are required.', 1; ...
    'The program was directed to finding a solution to an Air Force need, not to develop an understanding of the fundamental mechanics of cable behavior.', 0; ...
    'Applied research', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 4 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The Significance of Cable Modelling'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.4167, 1.5833, 6.4167, 5.0243);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Electrical cables mounted on space structures can influence the structural dynamics. ', 0; ...
    'The effects of cables on spacecraft dynamics is not documented in the industry. ', 1; ...
    'Cables not included in models can impact controller performance and robustness, impact isolation system requirements and increase program risk.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Electrical cables mounted on space structures ';
    r = p.add_run(); r.text = 'can';
    r = p.add_run(); r.text = ' influence the structural dynamics. ';
end
tb = sh.add_textbox(In(0.5), In(5.1667), In(6.0833), In(1.7839));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Model errors are determined late in the flight program (i.e., when cables exist). Is ';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 32 96]));
r = p.add_run(); r.text = 'there time ';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 32 96]));
r = p.add_run(); r.text = 'for controller tuning? The worst time to determine that the controller is miss-tuned is when the satellite is on-station.';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 32 96]));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image8.jpeg', 7.0833, 3.3333, 2.7847, 3.1355);

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The What of the', 'Cable Effects Study / Focus Restrictions'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.25, 1.3559, 9.5833, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Only studied small-to-moderate conductor count twisted pair cable bundles.  ', 0; ...
    'Not coaxial, ribbon cables, twisted pair in wire or polymer braided sleeving.', 1; ...
    'Concerned with low-level vibration problem (i.e., when the spacecraft is on-station), not launch vibration or shock conditions.', 0; ...
    'Cables with bends and connectors excluded from study.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Not';
    apply_run_font_fp_(r, struct("rgb", [0 112 192]));
    r = p.add_run(); r.text = ' coaxial, ribbon cables, twisted pair in wire or polymer braided ';
    r = p.add_run(); r.text = 'sleeving';
    r = p.add_run(); r.text = '.';
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Concerned with low-level vibration problem (i.e., when the spacecraft is on-station), ';
    r = p.add_run(); r.text = 'not';
    apply_run_font_fp_(r, struct("rgb", [0 112 192]));
    r = p.add_run(); r.text = ' launch vibration or shock conditions.';
end
p = add_pic_(sh, assets, 'image9.jpeg', 6.5, 5.2499, 3.0, 1.95);
if ~isempty(p), p.crop_left = 0.07692; end
p = add_pic_(sh, assets, 'image10.gif', 3.3421, 5.2499, 2.8199, 2.0);
p = add_pic_(sh, assets, 'image11.jpeg', 0.3333, 5.2085, 2.6708, 2.0);
p = add_pic_(sh, assets, 'image12.gif', 1.2229, 5.7992, 1.3471, 1.347);
p = add_pic_(sh, assets, 'image12.gif', 3.3932, 5.7992, 1.3471, 1.347);
p = add_pic_(sh, assets, 'image12.gif', 6.7608, 5.7992, 1.3471, 1.347);
p = add_pic_(sh, assets, 'image13.jpeg', 2.25, 4.4167, 5.25, 1.0);
if ~isempty(p), p.crop_left = -1e-05; end
if ~isempty(p), p.crop_top = 0.07692; end
if ~isempty(p), p.crop_right = -0.03279; end
p = add_pic_(sh, assets, 'image14.wmf', 7.0, 4.3333, 1.0833, 0.997);

%% ===== Slide 6 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The How of the Cable Effects Study'}, struct("autofit", "none"));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Cable models are implemented using Nastran standard elements. ', 0; ...
    'Well integrated with standard analysis tools', 1; ...
    'Linear beam elements are appropriate, using composite properties and general formulation.', 0; ...
    'Measurements showed that cable models must include shear: a Bernoulli-Euler beam formulation cannot predict cable dynamics', 1; ...
    'Equivalent cable properties in the Nastran deck are obtained through experiment and parameter estimation', 1; ...
    'The cable-to-structure model uses linear spring elements (PBUSH)', 1; ...
    'Spring properties were identified through experiment ', 2; ...
    'Validation experiments used throughout the program for cable parameter estimation and modeling techniques', 0; ...
    'Demonstration experiment to verify methods', 0; ...
    'Validation and verification – it was a research program', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 7 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Research Topics not Included', 'in the Cable Effects Study'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.5903, 1.8333, 9.0278, 5.191);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Bundles of twisted pair conductors exceeding 30 pairs and 20 AWG', 0; ...
    'Limited design space to maintain focus', 1; ...
    'Nonlinear cable models', 0; ...
    'Parameter extraction was based on the assumption of linear behavior', 1; ...
    'Detailed cable mechanics', 0; ...
    'Model-based cable bulk property derivation', 1; ...
    'Cable loss mechanism models', 1; ...
    'Inter-strand in a conductor, loss due to strain energy in the conductor shields or conductor-to-conductor loss', 2; ...
    'Localized cable tie-down behavior', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 8 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable Construction and Effects on Dynamics'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.0, 1.3333, 6.6667, 2.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Bundles of twisted pair single-conductor wires stitched and wrapped with Kapton® tape', 0; ...
    'Consistent with spacecraft power and signal cable fabrication', 1; ...
    'Cables add damping and can shift modal frequencies', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Bundles of twisted pair single-conductor wires stitched and wrapped with Kapton';
    apply_run_font_fp_(r, struct("pt", 20));
    r = p.add_run(); r.text = '®';
    apply_run_font_fp_(r, struct("pt", 20));
    r = p.add_run(); r.text = ' tape';
    apply_run_font_fp_(r, struct("pt", 20));
end
sp = sh.add_shape('rect', In(7.3458), In(4.7789), In(0.4185), In(0.3505));
try, sp.fill().background(); catch, end
sp = sh.add_shape('line', In(7.7711), In(4.6646), In(0.5371), In(0.2956));
try, sp.fill().background(); catch, end
sp = sh.add_shape('line', In(4.9028), In(1.7595), In(0.553), In(0));
try, sp.fill().background(); catch, end
sp = sh.add_shape('line', In(5.4558), In(1.7595), In(0.553), In(0));
try, sp.fill().background(); catch, end
sp = sh.add_shape('line', In(5.4558), In(1.7595), In(0), In(0.335));
try, sp.fill().background(); catch, end
sp = sh.add_shape('line', In(5.4558), In(1.7595), In(0), In(0.335));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(0), In(4.3333), In(1.6667), In(0.7742));
style_textbox_(tb.text_frame(), 'Cable not resonant', struct("bullets", false, "autofit", "shape", "bold", true, "rgb", [0 112 192]));
tb = sh.add_textbox(In(0), In(6.25), In(1.6667), In(0.7742));
style_textbox_(tb.text_frame(), 'Cable resonant', struct("bullets", false, "autofit", "shape", "bold", true, "rgb", [0 176 80]));
p = add_pic_(sh, assets, 'image15.png', 6.9126, 1.25, 2.5874, 3.0833);
p = add_pic_(sh, assets, 'image16.jpeg', 8.0163, 4.5012, 1.1655, 2.8321);
if ~isempty(p), p.crop_left = 0.24374; end
if ~isempty(p), p.crop_right = 0.2175; end
p = add_pic_(sh, assets, 'image17.jpeg', 7.25, 4.547, 0.666, 2.7728);
if ~isempty(p), p.crop_left = 0.35167; end
if ~isempty(p), p.crop_right = 0.355; end
if ~isempty(p), p.crop_bottom = 0.0675; end
p = add_pic_(sh, assets, 'image18.jpeg', 3.5, 3.75, 1.1979, 0.7292);
if ~isempty(p), p.crop_left = 0.10272; end
if ~isempty(p), p.crop_top = 0.18466; end
if ~isempty(p), p.crop_right = 0.16386; end
if ~isempty(p), p.crop_bottom = 0.15674; end
p = add_pic_(sh, assets, 'image19.png', 1.5, 3.5833, 4.6667, 3.7155);
if ~isempty(p), p.crop_left = 0.01887; end
if ~isempty(p), p.crop_top = 0.02516; end
if ~isempty(p), p.crop_right = 0.0754; end
if ~isempty(p), p.crop_bottom = 0.02847; end
cxn = sh.add_connector('straightConnector1', E(1752600), E(4343400), E(3048000), E(4344988));
style_connector_(cxn, struct("w", 31750, "tail", 'arrow'));
cxn = sh.add_connector('straightConnector1', E(3124200), E(6172200), E(5867400), E(6173788));
style_connector_(cxn, struct("w", 38100, "tail", 'arrow'));

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Attachment to Host Structure:', 'Cable-Structure Interaction'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0842, 0.1927, 7.8316, 0.8906);
tb = sh.add_textbox(In(5.25), In(1.4167), In(4.3333), In(2.0833));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'TC-105 mounting';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "latin", '+mn-lt', "cs", '+mn-cs', "cap", 'none', "rgb", [0 0 0]));
r = p.add_run(); r.text = ' tabs ';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "latin", '+mn-lt', "cs", '+mn-cs', "cap", 'none', "rgb", [0 0 0]));
r = p.add_run(); r.text = 'bonded to host structure';
apply_run_font_fp_(r, struct("pt", 16, "bold", true, "latin", '+mn-lt', "rgb", [0 0 0]));
set_para_lnspc_pct_(p, 90000);
set_para_align_one_(p, 'l');
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Allow controllable';
apply_run_font_fp_(r, struct("pt", 16, "bold", true, "latin", '+mn-lt', "cs", '+mn-cs', "cap", 'none', "rgb", [0 0 0]));
r = p.add_run(); r.text = ' cable attachment using zip-ties and installation tool (zip-tie gun)';
apply_run_font_fp_(r, struct("pt", 16, "bold", true, "latin", '+mn-lt', "cs", '+mn-cs', "cap", 'none', "rgb", [0 0 0]));
set_para_lnspc_pct_(p, 90000);
set_para_align_one_(p, 'l');
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Lacing cord used as an alternative';
apply_run_font_fp_(r, struct("pt", 16, "bold", true, "latin", '+mn-lt', "cs", '+mn-cs', "cap", 'none', "rgb", [0 0 0]));
r = p.add_run(); r.text = ' to zip-ties';
apply_run_font_fp_(r, struct("pt", 16, "bold", true, "latin", '+mn-lt', "rgb", [0 0 0]));
set_para_lnspc_pct_(p, 90000);
set_para_align_one_(p, 'l');
apply_no_bullet_all_(tf);
apply_no_autofit_(tf);
set_body_anchor_(tf, 't');
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.3642), In(2.8114), In(1.1292), In(0.4083));
style_textbox_(tb.text_frame(), 'TC-105', struct("bullets", false, "autofit", "shape", "pt", 16, "scheme", 'accent6'));
tb = sh.add_textbox(In(3.2785), In(3.1048), In(1.0548), In(0.7055));
style_textbox_(tb.text_frame(), 'Lacing cord', struct("bullets", false, "autofit", "shape", "pt", 16, "scheme", 'accent6'));
tb = sh.add_textbox(In(0.4657), In(4.6673), In(0.9696), In(0.4103));
style_textbox_(tb.text_frame(), 'Cable', struct("bullets", false, "autofit", "shape", "pt", 16, "scheme", 'accent6'));
tb = sh.add_textbox(In(0.25), In(5.392), In(1.2922), In(0.7074));
style_textbox_(tb.text_frame(), 'Base Structure', struct("bullets", false, "autofit", "shape", "pt", 16, "scheme", 'accent6'));
tb = sh.add_textbox(In(1), In(1.5), In(2.9167), In(0.7742));
style_textbox_(tb.text_frame(), 'Cable attachment to host structure', struct("bullets", false, "align", 'ctr', "autofit", "shape", "bold", true, "rgb", [0 5 192]));
tb = sh.add_textbox(In(4.5833), In(4.1667), In(4), In(0.4376));
style_textbox_(tb.text_frame(), 'Cable-structure interaction', struct("bullets", false, "align", 'ctr', "autofit", "shape", "bold", true, "rgb", [0 5 192]));
p = add_pic_(sh, assets, 'image20.jpeg', 4.4167, 4.5833, 5.5833, 2.3352);
p = add_pic_(sh, assets, 'image16.jpeg', 1.6194, 2.5833, 1.486, 3.75);
if ~isempty(p), p.crop_left = 0.24374; end
if ~isempty(p), p.crop_right = 0.2175; end
p = add_pic_(sh, assets, 'image21.jpeg', 0.4167, 3.3854, 1.1979, 0.7292);
if ~isempty(p), p.crop_left = 0.10269; end
if ~isempty(p), p.crop_top = 0.18469; end
if ~isempty(p), p.crop_right = 0.1638; end
if ~isempty(p), p.crop_bottom = 0.15672; end
cxn = sh.add_connector('straightConnector1', E(6025569), E(2692712), E(7131113), E(2688881));
style_connector_(cxn, struct("w", 12700, "tail", 'arrow', "tailW", 'med', "tailLen", 'med'));
cxn = sh.add_connector('straightConnector1', E(7342268), E(2821498), E(7974695), E(3164988));
style_connector_(cxn, struct("w", 12700, "tail", 'arrow', "tailW", 'med', "tailLen", 'med'));
cxn = sh.add_connector('straightConnector1', E(5961708), E(4679948), E(7324255), E(4474678));
style_connector_(cxn, struct("w", 12700, "tail", 'arrow', "tailW", 'med', "tailLen", 'med'));
cxn = sh.add_connector('straightConnector1', E(6077407), E(5615218), E(6871433), E(5342827));
style_connector_(cxn, struct("w", 12700, "tail", 'arrow', "tailW", 'med', "tailLen", 'med'));
cxn = sh.add_connector('straightConnector1', E(964669), E(2980198), E(813262), E(3059643));
style_connector_(cxn, struct("w", 12700, "tail", 'arrow', "tailW", 'med', "tailLen", 'med'));

%% ===== Slide 10 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable Modeling Approach Overview'}, struct("autofit", "none"));
p = add_pic_(sh, assets, 'image22.png', 0.9167, 1.5, 7.9327, 5.4929);

%% ===== Slide 11 · Title, Text, and Content =====
s = prs.slides().add_slide(lay_Title_Text_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The Cable Parameter', '', 'Extraction ', 'Mission and Approach'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.1667, 7.8333, 1.0);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 28));
body = sh.item(2);
set_shape_box_(body, 0.1667, 1.3333, 6.3333, 5.6701);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Test-derived cable properties are needed', 0; ...
    'What is the appropriate model for a cable?', 1; ...
    'Inputs for linear finite element models', 1; ...
    'Extensional modulus derived through test', 0; ...
    'Shear modulus based on lateral driving point mobility FRFs', 0; ...
    '“Easy” to measure', 1; ...
    'Challenges', 1; ...
    'Account for vibrometer time delay ', 2; ...
    'Cancel driving point fixture mass loading effect', 2; ...
    'Repeated roots', 2; ...
    'Lightly damped fixture modes', 2; ...
    'Parameter estimation algorithm ', 0; ...
    'Based on a beam model including shear', 1; ...
    'Specimen cross sectional area and extensional modulus from tensile tests', 1; ...
    'Determine area moment of inertia and k’G', 1; ...
    'Validated through experiment', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1, set_para_lnspc_pct_(ps{1}, 75000); end
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Test-derived ';
    apply_run_font_fp_(r, struct("pt", 21));
    r = p.add_run(); r.text = 'cable properties are needed';
    apply_run_font_fp_(r, struct("pt", 21));
    set_para_lnspc_pct_(p, 75000);
end
if numel(ps) >= 2, set_para_lnspc_pct_(ps{2}, 75000); end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'What is the appropriate model for a cable?';
    apply_run_font_fp_(r, struct("pt", 16, "rgb", [0 71 255]));
    set_para_lnspc_pct_(p, 75000);
end
if numel(ps) >= 3, set_para_lnspc_pct_(ps{3}, 75000); end
if numel(ps) >= 4, set_para_lnspc_pct_(ps{4}, 75000); end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Shear modulus based ';
    apply_run_font_fp_(r, struct("pt", 21));
    r = p.add_run(); r.text = 'on ';
    apply_run_font_fp_(r, struct("pt", 21));
    r = p.add_run(); r.text = 'lateral driving ';
    apply_run_font_fp_(r, struct("pt", 21));
    r = p.add_run(); r.text = 'point mobility ';
    apply_run_font_fp_(r, struct("pt", 21));
    r = p.add_run(); r.text = 'FRFs';
    apply_run_font_fp_(r, struct("pt", 21));
end
if numel(ps) >= 7, set_para_lnspc_pct_(ps{7}, 75000); end
if numel(ps) >= 8, set_para_lnspc_pct_(ps{8}, 75000); end
if numel(ps) >= 9, set_para_lnspc_pct_(ps{9}, 75000); end
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 2;
    r = p.add_run(); r.text = 'Cancel driving point fixture mass loading ';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'effect';
    apply_run_font_fp_(r, struct("pt", 14));
    set_para_lnspc_pct_(p, 75000);
end
if numel(ps) >= 10, set_para_lnspc_pct_(ps{10}, 75000); end
if numel(ps) >= 11, set_para_lnspc_pct_(ps{11}, 75000); end
if numel(ps) >= 12, set_para_lnspc_pct_(ps{12}, 75000); end
if numel(ps) >= 13, set_para_lnspc_pct_(ps{13}, 75000); end
if numel(ps) >= 14, set_para_lnspc_pct_(ps{14}, 75000); end
if numel(ps) >= 15, set_para_lnspc_pct_(ps{15}, 75000); end
if numel(ps) >= 15
    p = ps{15}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Determine area moment of inertia and ';
    apply_run_font_fp_(r, struct("pt", 17));
    r = p.add_run(); r.text = 'k’G';
    apply_run_font_fp_(r, struct("pt", 17));
    set_para_lnspc_pct_(p, 75000);
end
if numel(ps) >= 16, set_para_lnspc_pct_(ps{16}, 75000); end
p = add_pic_(sh, assets, 'image23.jpeg', 6.0612, 1.5833, 3.8555, 4.3333);
p = add_pic_(sh, assets, 'image24.jpeg', 6.0, 1.6667, 3.8333, 4.2847);
if ~isempty(p), p.crop_left = -0.26751; end

%% ===== Slide 12 · Title Only =====
s = prs.slides().add_slide(lay_Title_Only);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable Natural Frequency Progression:', 'The Beam Model Indicator'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
sp = sh.add_shape('upArrow', In(2.3507), In(3.2095), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('upArrow', In(2.9513), In(2.8993), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('upArrow', In(3.3333), In(2.8333), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('upArrow', In(3.6122), In(2.948), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('upArrow', In(3.8333), In(3.1262), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('upArrow', In(4.0405), In(3.3276), In(0.0833), In(0.5));
fill_rgb_(sp, [255 255 153]);
sp = sh.add_shape('ellipse', In(2.1667), In(2.5), In(2.0833), In(1.75));
try, sp.fill().background(); catch, end
tb = sh.add_textbox(In(4.8333), In(1.5286), In(5), In(2.3047));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'The natural frequency-to-mode number progression of a cable follows a quadratic relationship ';
apply_run_font_fp_(r, struct("pt", 22, "bold", true, "cs", 'Arial Unicode MS', "rgb", [0 0 0]));
set_para_lnspc_pct_(p, 84000);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'This is how an beam behaves';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "cs", 'Arial Unicode MS', "rgb", [64 64 255]));
set_para_lnspc_pct_(p, 84000);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Diverges from elementary beam theory: shear must be included';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "cs", 'Arial Unicode MS', "rgb", [64 64 255]));
set_para_lnspc_pct_(p, 84000);
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
sp = sh.add_shape('upArrow', In(5.0264), In(3.5888), In(0.3333), In(2.2448));
fill_rgb_(sp, [255 255 153]);
p = add_pic_(sh, assets, 'image25.png', 5.4167, 4.0833, 4.0833, 3.0625);
p = add_pic_(sh, assets, 'image26.png', 0.0833, 1.25, 4.9997, 3.7498);

%% ===== Slide 13 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Bare Cable Lateral Test: ', 'Parameter Estimation Approach'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.2951, 7.8299, 0.7882);
body = sh.item(2);
set_shape_box_(body, 3.1667, 1.4167, 6.6667, 5.6667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Measurements are cleaned up ', 0; ...
    'Modal parameter estimation step', 0; ...
    ' (        ) and k´G determined from modal frequencies', 0; ...
    'Estimate I and effective diameter', 0; ...
    'Damping averaged over all modes', 0; ...
    'Estimated parameters benchmarked by comparing shear model frequencies and measurement', 0; ...
    'Parameters estimated for different spans of each cable specimen and multiple specimens of each cable construction', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Measurements are ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'cleaned up ';
    apply_run_font_fp_(r, struct("pt", 24));
end
if numel(ps) >= 3, set_para_lnspc_pct_(ps{3}, 150000); end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = '';
    apply_run_font_fp_(r, struct("pt", 24, "latin", 'Symbol'));
    r = p.add_run(); r.text = ' (        ) and ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'k';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = '´G';
    apply_run_font_fp_(r, struct("pt", 24, "cs", 'Arial'));
    r = p.add_run(); r.text = ' determined from modal ';
    apply_run_font_fp_(r, struct("pt", 24, "cs", 'Arial'));
    r = p.add_run(); r.text = 'frequencies';
    apply_run_font_fp_(r, struct("pt", 24, "cs", 'Arial'));
    set_para_lnspc_pct_(p, 150000);
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Estimate I and ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'effective diameter';
    apply_run_font_fp_(r, struct("pt", 24));
end
p = add_pic_(sh, assets, 'image28.png', 0.25, 1.3333, 2.4286, 5.6368);

%% ===== Slide 14 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Parameter Estimation: Tie down stiffness'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.0, 1.3333, 6.8333, 2.6667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Rod-on-beam eliminates cable property uncertainty ', 0; ...
    'Tune attachment stiffness to correlate test and model FRFs', 1; ...
    'Direct measurement tests an alternative means to estimate ', 0; ...
    'Assumes cable is infinitely stiff over frequency range of estimate', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1, set_para_lnspc_pct_(ps{1}, 100000); end
if numel(ps) >= 2, set_para_lnspc_pct_(ps{2}, 100000); end
if numel(ps) >= 3, set_para_lnspc_pct_(ps{3}, 80000); end
if numel(ps) >= 4, set_para_lnspc_pct_(ps{4}, 80000); end
tb = sh.add_textbox(In(7.8333), In(1.3333), In(1.6667), In(0.3726));
style_textbox_(tb.text_frame(), 'Copper Rod', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 16, "rgb", [64 64 255]));
p = add_pic_(sh, assets, 'image29.jpeg', 7.4167, 1.5833, 1.9463, 2.5955);
p = add_pic_(sh, assets, 'image30.emf', 0.1667, 4.75, 5.6667, 2.6002);
p = add_pic_(sh, assets, 'image31.emf', 5.9823, 4.75, 4.0177, 2.501);

%% ===== Slide 15 · Blank =====
s = prs.slides().add_slide(lay_Blank);
sh = s.shapes();
tb = sh.add_textbox(In(1.0833), In(0.2951), In(7.8333), In(0.8924));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Model ';
apply_run_font_fp_(r, struct("pt", 27, "bold", true, "rgb", [0 0 0]));
r = p.add_run(); r.text = 'Validation: Tie ';
apply_run_font_fp_(r, struct("pt", 27, "bold", true, "rgb", [0 0 0]));
r = p.add_run(); r.text = 'downs';
apply_run_font_fp_(r, struct("pt", 27, "bold", true, "rgb", [0 0 0]));
set_para_lnspc_pct_(p, 90000);
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
apply_no_autofit_(tf);
set_body_anchor_(tf, 'ctr');
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0), In(1.25), In(5.1667), In(4.4167));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Tie-down parameters play an important role in cable/structure interactions';
apply_run_font_fp_(r, struct("pt", 24, "bold", true, "scheme", 'accent4'));
set_para_lnspc_pct_(p, 80000);
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Offset more important for stiff cables than for compliant ones';
apply_run_font_fp_(r, struct("pt", 24, "bold", true, "scheme", 'accent4'));
set_para_lnspc_pct_(p, 80000);
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Rod-on-beam based attachment stiffness values used in cable-on-beam models';
apply_run_font_fp_(r, struct("pt", 24, "bold", true, "scheme", 'accent4'));
set_para_lnspc_pct_(p, 80000);
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Stiffnesses';
apply_run_font_fp_(r, struct("pt", 24, "bold", true, "scheme", 'accent4'));
r = p.add_run(); r.text = ' from “direct measurement” tests did not perform as well';
apply_run_font_fp_(r, struct("pt", 24, "bold", true, "scheme", 'accent4'));
set_para_lnspc_pct_(p, 80000);
apply_no_bullet_all_(tf);
apply_no_autofit_(tf);
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.1667), In(6), In(4.75), In(1.1107));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'From rod-on-beam correlation: ';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
set_para_align_one_(p, 'ctr');
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'K';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '1';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '=K';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '2';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '=K';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '3';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = ' = 3x10';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '4';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = ' lbf/inch';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
set_para_align_one_(p, 'ctr');
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'K';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '5';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = ' =K';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = '6';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = ' = 100 inch-lbf/';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
r = p.add_run(); r.text = 'rad';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image32.emf', 4.8333, 1.3333, 5.0, 2.8473);
p = add_pic_(sh, assets, 'image33.emf', 5.3333, 4.1667, 4.4455, 3.3333);

%% ===== Slide 16 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable-on-Beam Results'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.0, 2.0, 4.5833, 5.0);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Cable effects differ over two distinct frequency ranges', 0; ...
    'Mass and stiffness effects below cable resonance', 1; ...
    'Increased damping above cable resonance', 1; ...
    'Good agreement between measured and modeled dynamics', 0; ...
    'Build-to-build variability is evident in predictions using “coupon” or “family” cable properties', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
tb = sh.add_textbox(In(5.5833), In(1.4167), In(1.6667), In(0.7742));
style_textbox_(tb.text_frame(), 'Cable not resonant', struct("bullets", false, "autofit", "shape", "bold", true, "rgb", [0 112 192]));
tb = sh.add_textbox(In(8), In(5.8333), In(1.6667), In(0.7742));
style_textbox_(tb.text_frame(), 'Cable resonant', struct("bullets", false, "autofit", "shape", "bold", true, "rgb", [0 176 80]));
p = add_pic_(sh, assets, 'image18.jpeg', 7.1667, 2.3333, 1.1979, 0.7292);
if ~isempty(p), p.crop_left = 0.10272; end
if ~isempty(p), p.crop_top = 0.18466; end
if ~isempty(p), p.crop_right = 0.16386; end
if ~isempty(p), p.crop_bottom = 0.15674; end
p = add_pic_(sh, assets, 'image19.png', 5.1667, 2.1667, 4.6667, 3.7155);
if ~isempty(p), p.crop_left = 0.01887; end
if ~isempty(p), p.crop_top = 0.02516; end
if ~isempty(p), p.crop_right = 0.0754; end
if ~isempty(p), p.crop_bottom = 0.02847; end
p = add_pic_(sh, assets, 'image34.emf', 8.9167, 2.476, 5.5, 4.024);
if ~isempty(p), p.crop_left = 0.03757; end
if ~isempty(p), p.crop_top = 0.27324; end
if ~isempty(p), p.crop_right = 0.05833; end
p = add_pic_(sh, assets, 'image34.emf', 9.5768, 1.4167, 4.6903, 1.0833);
if ~isempty(p), p.crop_left = 0.03757; end
if ~isempty(p), p.crop_top = 0.97811; end
if ~isempty(p), p.crop_right = 0.19143; end
cxn = sh.add_connector('straightConnector1', E(1752600), E(4343400), E(3048000), E(4344988));
style_connector_(cxn, struct("w", 31750, "tail", 'arrow'));
cxn = sh.add_connector('straightConnector1', E(3124200), E(6172200), E(5867400), E(6173788));
style_connector_(cxn, struct("w", 38100, "tail", 'arrow'));

%% ===== Slide 17 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Model Validation Effort –', 'A Panel Structure'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.25, 7.8316, 0.8906);
body = sh.item(2);
set_shape_box_(body, 0.1667, 1.3559, 5.75, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Mission: A test case to prove the applicability of the cable test, parameter estimation and modelling methods to a spacecraft-like panel', 0; ...
    'Ground rules: Conduct experiments to quantify dynamics. Modelling effort uses estimated cable properties, but cannot include model tuning.', 0; ...
    'Test case', 0; ...
    'Aluminum panel 2’ x 2’ x 3/16”', 1; ...
    'Three cast aluminum electronics boxes', 1; ...
    'Cable mass ratios ~ 3% or 6%', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Mission';
    apply_run_font_fp_(r, struct("pt", 24, "rgb", [0 112 192]));
    r = p.add_run(); r.text = ': A test case to prove the applicability of the cable test, parameter estimation and ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'modelling';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = ' methods to a ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'spacecraft-like';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = ' panel';
    apply_run_font_fp_(r, struct("pt", 24));
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Ground rules';
    apply_run_font_fp_(r, struct("pt", 24, "rgb", [0 112 192]));
    r = p.add_run(); r.text = ': Conduct experiments to quantify dynamics. ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'Modelling';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = ' effort uses estimated cable properties, but cannot include model tuning.';
    apply_run_font_fp_(r, struct("pt", 24));
end
p = add_pic_(sh, assets, 'image35.jpeg', 6.5833, 1.5833, 3.1434, 4.7111);

%% ===== Slide 18 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Measured Driving Point FRFs'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.1667, 1.3559, 4.8333, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Little influence in panel dynamics below cable resonance', 0; ...
    'Various cable spans become resonant between ~75 and ~175 Hz', 0; ...
    'Determined by cable type and open span dimensions', 1; ...
    'Low cable-to-panel mass ratio limits the cable influence on the coupled dynamics', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image36.emf', 4.8333, 2.3333, 5.1667, 3.5384);
if ~isempty(p), p.crop_left = 0.03333; end
if ~isempty(p), p.crop_right = 0.06667; end
if ~isempty(p), p.crop_bottom = 0.37362; end
p = add_pic_(sh, assets, 'image36.emf', 5.7901, 5.8717, 3.4445, 0.2949);
if ~isempty(p), p.crop_left = 0.2; end
if ~isempty(p), p.crop_top = 0.92217; end
if ~isempty(p), p.crop_right = 0.2; end
if ~isempty(p), p.crop_bottom = 0.02563; end

%% ===== Slide 19 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Panel Model Validation'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.0, 1.25, 5.25, 5.7743);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Compared traditional modelling approach (i.e., nonstructural mass) with dynamic cable models', 0; ...
    'Running RMS metric is driven by modal damping', 0; ...
    'Lumped mass approach does not account for coupling and over estimates response', 1; ...
    'Nonstructural mass approach may be adequate for low frequencies and low cable/structure mass ratios', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Compared traditional ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'modelling';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = ' approach (i.e., nonstructural mass) with dynamic cable models';
    apply_run_font_fp_(r, struct("pt", 24));
end
tb = sh.add_textbox(In(6.0574), In(6.2595), In(3.5), In(0.7405));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Running RMS error, zeroed at 90 and 200 Hz';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "rgb", [0 112 192]));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(5.0833), In(5.7499), In(4.9167), In(1.0098));
style_textbox_(tb.text_frame(), 'Least benefit from dynamic cable models with low mass ratio and/or large magnitude non-interacting modes', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 18, "bold", true, "rgb", [0 112 192]));
p = add_pic_(sh, assets, 'image38.emf', 5.1498, 2.0833, 4.8502, 4.3333);
p = add_pic_(sh, assets, 'image39.emf', 5.224, 2.0095, 4.776, 4.2674);
p = add_pic_(sh, assets, 'image40.emf', 5.1667, 2.25, 4.8333, 4.8333);
if ~isempty(p), p.crop_left = 0.03334; end
if ~isempty(p), p.crop_right = 0.04754; end
if ~isempty(p), p.crop_bottom = -0.17419; end
p = add_pic_(sh, assets, 'image41.emf', 5.1139, 1.8333, 4.8861, 5.3333);
if ~isempty(p), p.crop_bottom = -0.3617; end

%% ===== Slide 20 · Two Content =====
s = prs.slides().add_slide(lay_Two_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Shear Modulus Choice'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.0833, 2.1667, 4.7708, 4.8576);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Use of “family” or “coupon” shear modulus values does not have large impact on model accuracy for cables tested', 0; ...
    'Different conclusion than for cable-on-beam test', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image42.emf', 4.75, 1.5833, 5.25, 5.5);

%% ===== Slide 21 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Major Findings'}, struct("autofit", "none"));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'A shear beam model predicts cable dynamics', 0; ...
    'Coupon tests may be justified for critical applications', 0; ...
    'Variability in cable properties can be traced to', 0; ...
    'Cable construction due to hand fabrication ', 1; ...
    'Differences in wire structural properties can vary between lots', 1; ...
    'Running stitch tension', 1; ...
    'There is evidence of cable property dependence on span', 0; ...
    'Measurement of cable extensional modulus requires a low load capacity tensile test machine and a custom extensometer witness fixture', 0; ...
    'Rod-on-beam validation experiments were instrumental in refining connection stiffness value estimates', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 22 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Summary'}, struct("autofit", "none"));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Innovative test, analysis and modelling approaches were developed to ', 0; ...
    'Increase accuracy of models to include the influence of power and signal cables', 1; ...
    'Used standard linear finite element model methods', 1; ...
    'Cables can have a significant impact on coupled structure dynamics', 0; ...
    'Mass loading on the cable stiffness line', 1; ...
    'Increased damping above first cable resonance', 1; ...
    'Large reductions in resonant response when cable and host structure natural frequencies are close to one another', 1; ...
    'The traditional nonstructural mass approach cannot predict the cable interaction, leading to overestimates of resonant response', 2; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Innovative test, analysis and ';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = 'modelling';
    apply_run_font_fp_(r, struct("pt", 24));
    r = p.add_run(); r.text = ' approaches were developed to ';
    apply_run_font_fp_(r, struct("pt", 24));
end
if numel(ps) >= 8
    p = ps{8}; p.clear_content(); p.level = 2;
    r = p.add_run(); r.text = 'The traditional nonstructural mass approach cannot predict the cable interaction, leading to overestimates of resonant response';
    apply_run_font_fp_(r, struct("rgb", [0 112 192]));
end

%% ===== Slide 23 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Open Research Topics'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.25, 1.3559, 9.5833, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Develop cable fabrication techniques to increase cable predictability for structural dynamics', 0; ...
    'Extend efforts to include other cable construction methods', 0; ...
    'Considerable interest in the space community', 1; ...
    'Extend efforts to more massive cables and those with bends and connectors', 0; ...
    'Cable service loop modelling ', 0; ...
    'Study behavior of cables under launch vibration and mechanical shock conditions', 0; ...
    'Workmanship under high loading conditions', 1; ...
    'Mounting bracket strength ', 1; ...
    'Concerns in the space industry and DoD ', 1; ...
    'Detailed cable mechanics', 0; ...
    'Reduce dependence on empirically derived properties', 1; ...
    'Accelerate modelling and analysis programs', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Cable service loop ';
    r = p.add_run(); r.text = 'modelling';
    r = p.add_run(); r.text = ' ';
end
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Concerns in the space industry and ';
    r = p.add_run(); r.text = 'DoD';
    r = p.add_run(); r.text = ' ';
end
if numel(ps) >= 12
    p = ps{12}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Accelerate ';
    r = p.add_run(); r.text = 'modelling';
    r = p.add_run(); r.text = ' and analysis programs';
end

%% ===== Slide 24 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Questions'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.75, 1.4167, 8.5, 1.6076);

%% ===== Slide 25 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Acknowledgments'}, struct("autofit", "none"));
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Thanks to the Air Force Research Laboratory and the Air Force Office for Scientific Research for funding.', 0; ...
    'Thanks to the following project collaborators without whom this work would not have been possible.  ', 0; ...
    'Dr. Vit Babuška - Sandia National Laboratories', 1; ...
    'Dr. Emil Ardelean - Schafer Corporation', 1; ...
    'James Goodding - CSA Engineering', 1; ...
    'Cody Griffee - CSA Engineering', 1; ...
    'Greg Mehle - CSA Engineering', 1; ...
    'Dr. Lawrence “Robbie” Robertson AFRL, SV*', 1; ...
    'Dr. Steve Lane - AFRL, SV*', 1; ...
    'Brea Ingram- AFRL, SV*', 1; ...
    '*AFRL, SV = Air Force Research Laboratory, Space Vehicles Directorate', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1, set_para_lnspc_pct_(ps{1}, 100000); end
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Thanks to the Air Force Research Laboratory and the Air Force Office for Scientific Research for funding.';
    apply_run_font_fp_(r, struct("pt", 24, "cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 2, set_para_lnspc_pct_(ps{2}, 100000); end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Thanks to the following project collaborators without whom this work would not have been possible.  ';
    apply_run_font_fp_(r, struct("pt", 24, "cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 3, set_para_lnspc_pct_(ps{3}, 100000); end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Dr. ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Vit';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Babu';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'š';
    apply_run_font_fp_(r, struct("cs", 'Arial'));
    r = p.add_run(); r.text = 'ka';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Sandia National Laboratories';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 4, set_para_lnspc_pct_(ps{4}, 100000); end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Dr. Emil ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Ardelean';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Schafer Corporation';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 5, set_para_lnspc_pct_(ps{5}, 100000); end
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'James ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Goodding';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'CSA Engineering';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 6, set_para_lnspc_pct_(ps{6}, 100000); end
if numel(ps) >= 6
    p = ps{6}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Cody ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Griffee';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'CSA Engineering';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 7, set_para_lnspc_pct_(ps{7}, 100000); end
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Greg ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'Mehle';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = ' - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'CSA Engineering';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 8, set_para_lnspc_pct_(ps{8}, 100000); end
if numel(ps) >= 8
    p = ps{8}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Dr. Lawrence “Robbie” Robertson ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'AFRL, SV*';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 9, set_para_lnspc_pct_(ps{9}, 100000); end
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Dr. Steve Lane - ';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    r = p.add_run(); r.text = 'AFRL, SV*';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 10, set_para_lnspc_pct_(ps{10}, 100000); end
if numel(ps) >= 10
    p = ps{10}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Brea Ingram- ';
    r = p.add_run(); r.text = 'AFRL, SV*';
    apply_run_font_fp_(r, struct("cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end
if numel(ps) >= 11, set_para_lnspc_pct_(ps{11}, 100000); end
if numel(ps) >= 11
    p = ps{11}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = '*AFRL, SV = Air Force Research Laboratory, Space Vehicles Directorate';
    apply_run_font_fp_(r, struct("pt", 16, "cs", 'Lucida Sans Unicode'));
    set_para_lnspc_pct_(p, 100000);
end

%% ===== Slide 26 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Cable Tie Down Details'}, struct("autofit", "none"));
p = add_pic_(sh, assets, 'image43.png', 2.0, 2.1667, 5.7526, 3.4167);
if ~isempty(p), p.crop_left = 0.35504; end
if ~isempty(p), p.crop_bottom = 0.20659; end

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

