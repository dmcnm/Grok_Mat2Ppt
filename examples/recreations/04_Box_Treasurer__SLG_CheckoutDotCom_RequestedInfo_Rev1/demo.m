%% demo.m — 04_Box_Treasurer__SLG_CheckoutDotCom_RequestedInfo_Rev1
% FROM SCRATCH using updated skills (2026-07-18).
% Fingerprints: extracted/full_fingerprints.json (group ABS, lnSpc, runs, hlinks, connectors).
%
% Pipeline (binding):
%   0 source_template  1 extract  2 box  3 text structure  4 font/para per shape
%   5 autofit  6 images+chrome  7 connectors  8 audit
% Skills: mat2ppt-font-paragraph-audit, mat2ppt-slide-templates,
%         mat2ppt-bullet-autofit, mat2ppt-image-place-crop

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
prs = mat2ppt.Presentation(tpl);
layouts = prs.slide_layouts();
layTS = layouts.get_by_name("Title Slide");
layTC = layouts.get_by_name("Title and Content");

%% ===== S1 Title Slide =====
% Title fingerprint (per run): latin +mn-lt, cs Apple Chancery, cap=none;
%   no explicit sz (inherit layout ctrTitle 66pt); bodyPr normAutofit fontScale=90000; ABS box
% Subtitle fingerprint: sz=2400, cs Apple Chancery, cap=none (layout has cap=all — must override);
%   ABS box. Do NOT set latin=Apple Chancery alone without cap=none.
s = prs.slides().add_slide(layTS); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'The Saint Luke Guild', 'Checkout.com ', 'Requested Info'}, ...
    struct("fontScale", 90000));
set_shape_box_(sh.item(1), 2.6471, 0.9711, 9.4314, 2.7793);
apply_title_run_fonts_(sh.item(1).text_frame(), struct( ...
    "latin", "+mn-lt", "cs", "Apple Chancery", "cap", "none"));

sub = sh.item(2);
set_shape_box_(sub, 5.5638, 4.9309, 7.7696, 1.7554);
tf = sub.text_frame(); tf.clear();
ps = tf.paragraphs();
ps{1}.clear_content(); ps{1}.level = 0;
r = ps{1}.add_run(); r.text = 'Douglas Coombs';
apply_run_font_fp_(r, struct("pt", 24, "cs", "Apple Chancery", "cap", "none"));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'July 1, ';
apply_run_font_fp_(r, struct("pt", 24, "cs", "Apple Chancery", "cap", "none"));
r = p.add_run(); r.text = '2022, Rev. 1';
apply_run_font_fp_(r, struct("pt", 24, "cs", "Apple Chancery", "cap", "none"));
% no buNone forced — source inherits (empty pPr); layout subtitle has buNone in lstStyle
apply_norm_autofit_(tf, struct());

%% ===== S2 Transaction Information =====
% Title soft×2 + trailing br (soft=2) + fs=90000
% Body: listProps false; lvl>=1 scheme accent6; URL multi-run + hlink
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Transaction Information', 'Data Request'}, struct("fontScale", 90000));
append_trailing_soft_break_(sh.item(1).text_frame());
body = sh.item(2);
set_shape_box_(body, 0.525, 1.0263, 12.573, 6.2201);
style_body_(body.text_frame(), { ...
    'A payment flow to properly understand what Checkout.com is exactly processing for.', 0, []; ...
    'See the next slide', 1, []; ...
    'Please provide further details on what the merchant will be accepting payments for.', 0, []; ...
    'We are accepting donations to fund', 1, []; ...
    'Art displays at schools', 2, []; ...
    'Projects to help schools in the selection of art (e.g., a timeline/database of art masterpieces)', 2, []; ...
    'Costs to attend educational conferences and educate schools on the value of art reproductions', 2, []; ...
    'Please provide the URL where payments will be accepted. Please also provide demo or Test login details to verify the website', 0, []; ...
    'www.saintlukeguild.com/projects (this will be updated when we begin taking payments)', 1, []; ...
    'Please confirm the annual processing volume', 0, []; ...
    'Maybe $5k-$10k/year to begin.  It is hard to say.  We currently bring in around $20k/year in large checks.  Most larger donors will probably still choose to give via check.', 1, [] ...
    }, struct("listProps", false));
apply_scheme_on_levels_(body.text_frame(), 1, "accent6");
ps = body.text_frame().paragraphs();
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'www.saintlukeguild.com/projects';
    format_one_run_(r, struct("scheme", "accent6"));
    try, r.hyperlink().address = 'http://www.saintlukeguild.com/projects'; catch, end
    r = p.add_run(); r.text = ' (this will be updated when we begin taking payments)';
    format_one_run_(r, struct("scheme", "accent6"));
end

%% ===== S3 Flow chart =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Transaction Flow Chart for Website Donor Funds'});
set_shape_box_(sh.item(1), 0.1212, 0.0505, 13.2121, 0.9588);
body = sh.item(2);
set_shape_box_(body, 0.1212, 5.02, 6.0604, 1.6614);
tf = body.text_frame(); tf.clear();
ps = tf.paragraphs(); p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'General support projects are not '; format_one_run_(r, struct("pt", 28));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = 'specific to any school'; format_one_run_(r, struct("pt", 28));
p2 = tf.add_paragraph(); p2.text = 'Project costs are school specific'; p2.level = 0;
format_para_runs_(p2, struct("pt", 28));
apply_norm_autofit_(tf, struct("fontScale", 92500, "lnSpcReduction", 20000));
try, tf.word_wrap = true; catch, end

% Flow nodes: theme fill + outline via p:style lnRef idx=2 accent1 shade 50000 (not Mat2Ppt default idx=1)
nodeDonors = sh.add_shape('roundRect', In(0.1212), In(2.9664), In(3.2071), In(1.9142));
style_textbox_(nodeDonors.text_frame(), 'Donors give to either a school project (restricted), a general support project, (restricted) or general funds (unrestricted)', ...
    struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(nodeDonors);
nodeProject = sh.add_shape('roundRect', In(9.0394), In(5.1142), In(3.2071), In(1.5672));
style_textbox_(nodeProject.text_frame(), ' Project costs are spent 100% on school art projects for specific schools', ...
    struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(nodeProject);
nodeGeneral = sh.add_shape('roundRect', In(3.9446), In(1.8827), In(3.2071), In(1.5672));
style_textbox_(nodeGeneral.text_frame(), 'General funds are discretionary and can cover either overhead or project costs', ...
    struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(nodeGeneral);
nodeOverhead = sh.add_shape('roundRect', In(9.0394), In(1.2043), In(3.2071), In(1.5672));
style_textbox_(nodeOverhead.text_frame(), 'Overhead costs are things like PO box and website fees', ...
    struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(nodeOverhead);
nodeSupport = sh.add_shape('roundRect', In(9.0394), In(3.1592), In(3.2071), In(1.5672));
style_textbox_(nodeSupport.text_frame(), 'General support project costs are for things like an art timeline database to help schools select art for their hallways', ...
    struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(nodeSupport);

% Connectors — each fingerprint: prst, ends, color, w, tail, adj
cxn = sh.add_connector('bentConnector3', E(6539551), E(2438050), E(8265640), E(5392890), {"adj1","val 39613"});
style_connector_(cxn, struct("w",38100,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeGeneral,3); catch, end
try, cxn.end_connect(nodeProject,1); catch, end
cxn = sh.add_connector('bentConnector3', E(3043451), E(3587655), E(8265640), E(5392890));
style_connector_(cxn, struct("w",38100,"scheme","accent2","brightness",0.4,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeDonors,3); catch, end
try, cxn.end_connect(nodeProject,1); catch, end
cxn = sh.add_connector('bentConnector3', E(3043451), E(3587655), E(3606936), E(2438050));
style_connector_(cxn, struct("w",38100,"scheme","accent2","brightness",0.4,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeDonors,3); catch, end
try, cxn.end_connect(nodeGeneral,1); catch, end
cxn = sh.add_connector('bentConnector3', E(6539551), E(2438050), E(8301485), E(1798030), {"adj1","val 62211"});
style_connector_(cxn, struct("w",38100,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeGeneral,3); catch, end
try, cxn.end_connect(nodeOverhead,1); catch, end
cxn = sh.add_connector('bentConnector3', E(6539551), E(2438050), E(8265640), E(3605285), {"adj1","val 52077"});
style_connector_(cxn, struct("w",38100,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeGeneral,3); catch, end
try, cxn.end_connect(nodeSupport,1); catch, end
cxn = sh.add_connector('straightConnector1', E(3043451), E(3587655), E(8265640), E(3605285));
style_connector_(cxn, struct("w",38100,"scheme","accent2","brightness",0.4,"tail","triangle","tailW","lg","tailLen","lg"));
try, cxn.begin_connect(nodeDonors,3); catch, end
try, cxn.end_connect(nodeSupport,1); catch, end

%% ===== S4 Donor form entry =====
% Form group ABS (not local): panel [6.0925,1.1406], text [6.6947,1.1416]
% Form paras: lnSpc 200000×5 then 250000×3; soft-break checkbox line
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Website Donor Forms', 'Entry Point for Project Funding'}, struct("fontScale", 90000));
set_shape_box_(sh.item(1), 0.1212, 0.0505, 13.2121, 0.9588);
body = sh.item(2);
set_shape_box_(body, 0.2774, 1.0263, 5.3249, 3.9345);
style_body_(body.text_frame(), { ...
    'Simple Donate Button next to each project on website takes donors to a common donation form with a drop down menu to select a project', 0, []; ...
    'The Saint Luke Guild should be able to add projects to the list', 0, []; ...
    'All form information should be communicated to the Saint Luke Guild along with money', 0, [] ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
sp = sh.add_shape('roundRect', In(1.8908), In(5.1749), In(2.098), In(0.7696));
style_textbox_(sp.text_frame(), 'Donate Now', struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(sp);  % outline lnRef idx=2 accent1 shade
formBg = sh.add_shape('roundRect', In(6.0925), In(1.1406), In(6.5294), In(6.0297));
fill_scheme_(formBg, "accent1", 0.8);  % solid fill override; keep style outline (no ln/noFill)
apply_shape_style_office_(formBg);
tb = sh.add_textbox(In(6.6947), In(1.1416), In(5.9271), In(6.0287));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
fl4 = {'First Name: _______________________'; 'Last Name: _______________________'; ...
       'Address: _________________________'; 'City: ____________________________'; ...
       'State:  [Drop Down ]         Zip: ___________'};
for i = 1:numel(fl4)
    if i==1, p=ps{1}; else, p=tf.add_paragraph(); end
    p.text = fl4{i}; p.level = 0; set_para_lnspc_pct_(p, 200000);
end
% Checkbox: a:sym on glyph only — never set latin=Symbol on the label text (looks Greek)
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = char(hex2dec('F085'));
apply_run_symbol_font_(r, "Symbol");
r = p.add_run(); r.text = '  Keep me anonymous to project schools.';  % default latin
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = 'Project: [Drop Down List]';
set_para_lnspc_pct_(p, 250000);
p = tf.add_paragraph(); p.text = 'Pledge Amount: $  ___________'; p.level = 0; set_para_lnspc_pct_(p, 250000);
p = tf.add_paragraph(); p.text = 'Credit Card Info'; p.level = 0; set_para_lnspc_pct_(p, 250000);
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
arr = sh.add_shape('rightArrow', In(4.4706), In(5.2934), In(1.0196), In(0.5328));
fill_scheme_(arr, "accent1", 0.8);
apply_shape_style_office_(arr);

%% ===== S5 Ideal form + progress bars =====
% Form ABS panel [6.4454,1.6896] text [7.0476,1.6906]; lnSpc 200%×7 + 250%×2
% Progress groups at ABS positions (group-transformed)
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Website Donor Forms', 'Ideal Point'}, struct("fontScale", 90000));
set_shape_box_(sh.item(1), 0.1212, 0.0505, 13.2121, 0.9588);
body = sh.item(2);
set_shape_box_(body, 0.2774, 1.0263, 5.3249, 3.9345);
style_body_(body.text_frame(), { ...
    'In an ideal world, we would be able to have bar graphs showing how much money has been donated to a given project', 0, []; ...
    'Similar to Kickstarter', 1, []; ...
    'SLG staff would be able to enter check donations to move the bar', 0, []; ...
    'This would mean each project would have a standalone donor form.', 0, [] ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
sp = sh.add_shape('roundRect', In(1.3137), In(5.77), In(2.098), In(0.7696));
style_textbox_(sp.text_frame(), 'Donate Now', struct("bullets", false, "align", "ctr", "anchor", "ctr", "autofit", "none"));
apply_shape_style_office_(sp);
formBg = sh.add_shape('roundRect', In(6.4454), In(1.6896), In(6.5294), In(5.7267));
fill_scheme_(formBg, "accent1", 0.8);
apply_shape_style_office_(formBg);
tb = sh.add_textbox(In(7.0476), In(1.6906), In(5.3249), In(5.7257));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
fl5 = { ...
    'Project: Holy Child Catholic School', true, 200000; ...
    'First Name: _______________________', false, 200000; ...
    'Last Name: _______________________', false, 200000; ...
    'Address: _________________________', false, 200000; ...
    'City: ____________________________', false, 200000; ...
    'State:  [Drop Down ]         Zip: ___________', false, 200000};
for i = 1:size(fl5,1)
    if i==1, p=ps{1}; else, p=tf.add_paragraph(); end
    p.text = fl5{i,1}; p.level = 0;
    if fl5{i,2}, format_para_runs_(p, struct("bold", true)); end
    set_para_lnspc_pct_(p, fl5{i,3});
end
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = [char(hex2dec('F085')) ' '];
apply_run_symbol_font_(r, "Symbol");
r = p.add_run(); r.text = 'Keep me anonymous to the above school.';
set_para_lnspc_pct_(p, 200000);
p = tf.add_paragraph(); p.text = 'Pledge Amount: $  ___________'; p.level = 0; set_para_lnspc_pct_(p, 250000);
p = tf.add_paragraph(); p.text = 'Credit Card Info'; p.level = 0; set_para_lnspc_pct_(p, 250000);
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
arr = sh.add_shape('rightArrow', In(4.6537), In(5.834), In(1.0196), In(0.5328));
fill_scheme_(arr, "accent1", 0.8);
apply_shape_style_office_(arr);
% Progress group 12 (near donate) ABS
add_progress_bar_abs_(sh, 0.1306, 5.0404, 0.4345, 5.1895, 2.3462, 5.1895, 4.3462, 4.9778);
% Progress group 13 (on form) ABS
add_progress_bar_abs_(sh, 6.6863, 1.0391, 6.9902, 1.1882, 8.9019, 1.1882, 10.9019, 0.9765);

%% ===== S6 Bank =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Bank Account Info'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.1421, 1.0263, 4.8775, 6.2201);
style_body_(body.text_frame(), { ...
    'Routing #: 307083911', 0, []; ...
    'Auto WD and Direct Deposit #: 9225000161', 0, []; ...
    'Account #: 10422500-9001', 0, []; ...
    'Not used for electronic transactions', 1, [] ...
    }, struct("listProps", false, "autofit", "none"));
add_pic_(sh, assets, 'image3.png', 5.208, 1.0132, 7.7775, 6.4489);

%% ===== S7 KYC =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'KYC documentation'}, struct("fontScale", 90000));
append_trailing_soft_break_(sh.item(1).text_frame());
body = sh.item(2);
set_shape_box_(body, 0.525, 1.0263, 11.3591, 0.7384);
style_body_(body.text_frame(), { ...
    'Passport/Driver''s License for Douglas Coombs', 0, [] ...
    }, struct("listProps", false, "autofit", "none"));
p = add_pic_(sh, assets, 'image4.jpg', 0.0733, 1.841, 6.6078, 4.0784);
if ~isempty(p), p.crop_left = 0.06551; p.crop_right = 0.06053; p.crop_bottom = 0.13693; end
p = add_pic_(sh, assets, 'image5.jpg', 6.8025, 1.848, 6.4782, 4.0714);
if ~isempty(p), p.crop_left = 0.1546; p.crop_right = 0.1552; p.crop_bottom = 0.27705; end

%% ===== S8 Legalese multi-run Arial + accent6 + hlinks =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Legalese on Website'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.525, 1.0263, 12.0869, 6.2201);
tf = body.text_frame();
fill_mixed_runs_(tf, { ...
    {0, {'Legal entity name: ', struct('face','Arial','rgb',[34 34 34])}, ...
        {'The Saint Luke Guild', struct('face','Arial','scheme','accent6')}}; ...
    {0, {'Governing jurisdiction: ', struct('face','Arial','rgb',[34 34 34])}, ...
        {'New Mexico', struct('face','Arial','scheme','accent6')}}; ...
    {0, {'Merchant registered business address: ', struct('face','Arial','rgb',[34 34 34])}, ...
        {'2718 University Blvd NE, Albuquerque, NM 87107', struct('face','Arial','scheme','accent6')}}; ...
    {0, {'Privacy Policy', struct('face','Arial','rgb',[34 34 34])}}; ...
    {1, {'See next slide', struct('face','Arial','scheme','accent6')}}; ...
    {0, {'Refund/Cancellation/Return Policy', struct('face','Arial','rgb',[34 34 34])}}; ...
    {1, {'See next slide', struct('face','Arial','scheme','accent6')}}; ...
    {0, {'See ', struct('face','Arial','rgb',[34 34 34])}, ...
        {'www.SaintLukeGuild.com/About-Us', struct('face','Arial','rgb',[34 34 34],'hlink','http://www.saintlukeguild.com/About-Us')}}; ...
    {1, {'To be moved to ', struct('face','Arial','rgb',[34 34 34])}, ...
        {'www.SaintLukeGuild.com/Legalese', struct('face','Arial','rgb',[34 34 34],'hlink','http://www.saintlukeguild.com/Legalese')}, ...
        {' at a future date', struct('face','Arial','rgb',[34 34 34])}} ...
    });
apply_no_autofit_(tf); try, tf.word_wrap = true; catch, end

%% ===== S9 Privacy — per-run hlinks + buNone on headers =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Privacy and Refund Policy'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.3478, 1.0263, 12.4953, 5.6796);
tf = body.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'https://www.saintlukeguild.com/about-us';
try, r.hyperlink().address = 'https://www.saintlukeguild.com/about-us'; catch, end
set_para_bu_none_(p);
p = tf.add_paragraph(); p.text = 'Refund Policy'; p.level = 0; set_para_bu_none_(p);
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = ['The Saint Luke Guild does not deliver products to individuals; therefore cancellations and returns are not applicable.  Also, donor refunds are not generally offered.  Refunds will be considered on a case-by-case basis before money is distributed to the designated project (e.g., if someone accidentally entered the wrong donation amount and contact is made within one business day).  To request a refund, contact us at '];
r = p.add_run(); r.text = 'refunds@saintlukeguild.com';
try, r.hyperlink().address = 'mailto:refunds@saintlukeguild.com'; catch, end
r = p.add_run(); r.text = '.';
p = tf.add_paragraph(); p.text = 'Privacy Policy'; p.level = 0; set_para_bu_none_(p);
p = tf.add_paragraph(); p.text = 'The Saint Luke Guild takes donor information and privacy very seriously.  We will never sell donor information to a third party for any reason.'; p.level = 0;
p = tf.add_paragraph(); p.text = 'Donor information will only be shared with outside businesses as necessary to deliver services (e.g., processing credit card donations, etc.).'; p.level = 0;
p = tf.add_paragraph(); p.text = 'The exception is when donors choose a specific school project to donate to.  When this occurs, donor information will typically be shared with the specified school, so that they can know to whom they should be grateful.  Donors may opt out of information sharing on the donor form.'; p.level = 1;
apply_norm_autofit_(tf, struct("fontScale", 92500, "lnSpcReduction", 20000));
try, tf.word_wrap = true; catch, end

%% ===== S10 Regulatory docs =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Regulatory Documents'});
body = sh.item(2);
style_body_(body.text_frame(), { ...
    'License required to operate the business', 0, []; ...
    'NM_SoS_InitialReport_2016917025-502856.pdf', 1, []; ...
    'NM_ArticlesOfIncorporation_AoI_Approved.pdf', 1, []; ...
    'Licenses for all jurisdictions in which you intend to provide your services.', 0, []; ...
    'Starting in NM.  Other locations unknown, so far.', 1, []; ...
    'Copy of AML/KYC policy and procedures', 0, []; ...
    'Not sure what this would look like.  Are there examples?', 1, []; ...
    'Completed AML Questionnaire', 0, []; ...
    'Has this been done?', 1, [] ...
    }, struct("listProps", false, "autofit", "none"));
apply_scheme_on_levels_(body.text_frame(), 1, "accent6");

%% ===== S11 Corporate docs =====
s = prs.slides().add_slide(layTC); sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Corporate Documents'});
body = sh.item(2);
style_body_(body.text_frame(), { ...
    'Please provide 501c3 document to confirm tax exempt status', 0, []; ...
    'The following are attached', 0, []; ...
    'IRS_f1023ez_SaintLukeGuild_20210711_AsSubmitted.pdf', 1, []; ...
    'IRS_fSS4_EIN_Letter_CP575Notice_1622224687610.pdf', 1, [] ...
    }, struct("listProps", false, "autofit", "none"));
ps = body.text_frame().paragraphs();
for i = 2:numel(ps)
    format_para_runs_(ps{i}, struct("scheme", "accent6"));
end

prs.save(outPath);
fprintf("Wrote %s (from-scratch fingerprint pipeline)\n", outPath);

%% ===================== helpers =====================

function style_title_(tf, lines, opts)
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    if isstring(lines), lines = cellstr(lines); end
    if ischar(lines), lines = {lines}; end
    rows = cell(numel(lines), 2);
    for i = 1:numel(lines)
        rows{i,1} = lines{i}; rows{i,2} = [];
        if isfield(opts,"pt") && ~isempty(opts.pt), rows{i,2} = opts.pt; end
    end
    set_mixed_title_(tf, rows);
    if isfield(opts,"align") && ~isempty(opts.align), set_para_align_(tf, opts.align); end
    if isfield(opts,"autofit") && strcmpi(string(opts.autofit),"none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function style_body_(tf, rows, opts)
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    fill_bullets_(tf, rows);
    if isfield(opts,"listProps") && opts.listProps, apply_list_para_props_(tf, true); end
    if isfield(opts,"face") && ~isempty(opts.face), format_all_runs_(tf, struct("face", opts.face)); end
    if isfield(opts,"pt") && ~isempty(opts.pt), format_all_runs_(tf, struct("pt", opts.pt)); end
    try, tf.word_wrap = true; catch, end
    if isfield(opts,"autofit") && strcmpi(string(opts.autofit),"none")
        apply_no_autofit_(tf);
    elseif isfield(opts,"autofit") && strcmpi(string(opts.autofit),"shape")
        tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
    else
        apply_norm_autofit_(tf, opts);
    end
end

function style_textbox_(tf, text, opts)
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    if iscell(text)
        tf.clear(); ps = tf.paragraphs();
        for i = 1:numel(text)
            if i==1, p=ps{1}; else, p=tf.add_paragraph(); end
            p.text = char(string(text{i})); p.level = 0;
        end
    else
        tf.text = char(string(text));
    end
    if isfield(opts,"bullets") && ~isempty(opts.bullets) && ~opts.bullets
        apply_no_bullet_all_(tf);
    end
    runOpts = struct();
    if isfield(opts,"face"), runOpts.face = opts.face; end
    if isfield(opts,"pt"), runOpts.pt = opts.pt; end
    if isfield(opts,"rgb"), runOpts.rgb = opts.rgb; end
    if isfield(opts,"scheme"), runOpts.scheme = opts.scheme; end
    if isfield(opts,"bold") && opts.bold, runOpts.bold = true; end
    format_all_runs_(tf, runOpts);
    if isfield(opts,"align") && ~isempty(opts.align), set_para_align_(tf, opts.align); end
    if isfield(opts,"anchor") && ~isempty(opts.anchor), set_body_anchor_(tf, opts.anchor); end
    try, tf.word_wrap = true; catch, end
    if isfield(opts,"autofit") && strcmpi(string(opts.autofit),"shape")
        tf.auto_size = AS.SHAPE_TO_FIT_TEXT;
    elseif isfield(opts,"autofit") && strcmpi(string(opts.autofit),"none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function set_mixed_title_(tf, rows)
    tf.clear(); ps = tf.paragraphs(); p = ps{1}; p.clear_content();
    for i = 1:size(rows,1)
        if i > 1, p.element().append(mat2ppt.oxml.OxmlElement("a:br")); end
        r = p.add_run(); r.text = char(string(rows{i,1}));
        opts = struct(); if ~isempty(rows{i,2}), opts.pt = rows{i,2}; end
        format_one_run_(r, opts);
    end
end

function append_trailing_soft_break_(tf)
    ps = tf.paragraphs(); if isempty(ps), return; end
    ps{1}.element().append(mat2ppt.oxml.OxmlElement("a:br"));
end

function fill_bullets_(tf, rows)
    tf.clear(); ps = tf.paragraphs();
    for i = 1:size(rows,1)
        txt = rows{i,1}; lvl = rows{i,2}; pt = rows{i,3};
        if i==1, p=ps{1}; else, p=tf.add_paragraph(); end
        p.text = char(string(txt)); p.level = lvl;
        if ~isempty(pt), format_para_runs_(p, struct("pt", pt)); end
    end
end

function fill_mixed_runs_(tf, paraSpecs)
    tf.clear(); ps = tf.paragraphs();
    for i = 1:numel(paraSpecs)
        spec = paraSpecs{i}; lvl = spec{1};
        if i==1, p=ps{1}; else, p=tf.add_paragraph(); end
        p.clear_content(); p.level = lvl;
        for j = 2:numel(spec)
            pair = spec{j};
            r = p.add_run(); r.text = char(string(pair{1}));
            format_one_run_(r, pair{2});
            if isfield(pair{2},"hlink") && ~isempty(pair{2}.hlink)
                try, r.hyperlink().address = char(string(pair{2}.hlink)); catch, end
            end
        end
    end
end

function apply_scheme_on_levels_(tf, minLevel, schemeName)
    ps = tf.paragraphs();
    for i = 1:numel(ps)
        if double(ps{i}.level) >= minLevel
            format_para_runs_(ps{i}, struct("scheme", schemeName));
        end
    end
end

function format_all_runs_(tf, opts)
    opts = normalize_fmt_opts_(opts); ps = tf.paragraphs();
    for pi = 1:numel(ps), format_para_runs_(ps{pi}, opts); end
end

function format_para_runs_(p, opts)
    opts = normalize_fmt_opts_(opts); rs = p.runs();
    for ri = 1:numel(rs), format_one_run_(rs{ri}, opts); end
end

function format_one_run_(r, opts)
    opts = normalize_fmt_opts_(opts);
    Pt = @mat2ppt.util.Pt; f = r.font();
    if isfield(opts,"pt") && ~isempty(opts.pt), f.size = Pt(double(opts.pt)); end
    if isfield(opts,"bold") && ~isempty(opts.bold)
        try, f.bold = logical(opts.bold); catch, end
    end
    if isfield(opts,"scheme") && ~isempty(opts.scheme)
        try
            f.color().theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(opts.scheme)));
            if isfield(opts,"brightness") && ~isempty(opts.brightness)
                f.color().brightness = double(opts.brightness);
            end
        catch
        end
    elseif isfield(opts,"rgb") && ~isempty(opts.rgb)
        rgb = double(opts.rgb);
        f.color().rgb = mat2ppt.dml.RGBColor(rgb(1), rgb(2), rgb(3));
    end
    if isfield(opts,"face") && ~isempty(opts.face)
        try, f.name = string(opts.face); catch, end
    end
end

function opts = normalize_fmt_opts_(opts)
    if isempty(opts), opts = struct(); return; end
    if numel(opts) > 1
        base = opts(1);
        if isfield(base,"rgb"), rgb = [opts.rgb]; base.rgb = rgb(:).'; end
        opts = base;
    end
    if isfield(opts,"rgb") && iscell(opts.rgb), opts.rgb = opts.rgb{1}; end
    if isfield(opts,"face") && iscell(opts.face), opts.face = opts.face{1}; end
    if isfield(opts,"scheme") && iscell(opts.scheme), opts.scheme = opts.scheme{1}; end
    if isfield(opts,"pt") && iscell(opts.pt), opts.pt = opts.pt{1}; end
end

function set_para_align_(tf, algn)
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        p = ps{pi};
        try
            if strcmpi(algn,"ctr"), p.alignment = mat2ppt.enum.PP_ALIGN.CENTER; continue; end
        catch
        end
        pPr = ensure_pPr_(p); pPr.set("algn", char(string(algn)));
    end
end

function set_body_anchor_(tf, anchor)
    bodyPr = find_or_make_body_pr_(tf.element());
    bodyPr.set("anchor", char(string(anchor)));
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

function apply_norm_autofit_(tf, opts)
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 2, opts = struct(); end
    tf.auto_size = AS.TEXT_TO_FIT_SHAPE;
    hasScale = isfield(opts,"fontScale") && ~isempty(opts.fontScale);
    hasLn = isfield(opts,"lnSpcReduction") && ~isempty(opts.lnSpcReduction);
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

function apply_list_para_props_(tf, withBullets)
    if nargin < 2, withBullets = true; end
    marL = [228600, 685800, 1143000, 1600200, 2057400, 2514600, 2971800, 3429000, 3886200];
    ps = tf.paragraphs();
    for i = 1:numel(ps)
        p = ps{i}; pPr = ensure_pPr_(p);
        lvl = double(p.level); if lvl < 0, lvl = 0; end; if lvl > 8, lvl = 8; end
        pPr.set("marL", char(string(marL(lvl+1)))); pPr.set("indent", "-228600"); pPr.set("algn","l");
        kids = pPr.getchildren();
        for k = numel(kids):-1:1
            ln = char(kids{k}.localName());
            if any(strcmp(ln,{"lnSpc","spcBef","spcAft"})) || startsWith(string(ln),"bu")
                pPr.remove(kids{k});
            end
        end
        lnSpc = mat2ppt.oxml.OxmlElement("a:lnSpc"); spcPct = mat2ppt.oxml.OxmlElement("a:spcPct");
        spcPct.set("val","90000"); lnSpc.append(spcPct); pPr.append(lnSpc);
        spcBef = mat2ppt.oxml.OxmlElement("a:spcBef"); spcPts = mat2ppt.oxml.OxmlElement("a:spcPts");
        if lvl >= 1, spcPts.set("val","500"); else, spcPts.set("val","1000"); end
        spcBef.append(spcPts); pPr.append(spcBef);
        if withBullets
            buFont = mat2ppt.oxml.OxmlElement("a:buFont"); buFont.set("typeface","Arial"); pPr.append(buFont);
            buChar = mat2ppt.oxml.OxmlElement("a:buChar"); buChar.set("char", char(8226)); pPr.append(buChar);
        else
            pPr.append(mat2ppt.oxml.OxmlElement("a:buNone"));
        end
    end
end

function apply_no_bullet_all_(tf)
    ps = tf.paragraphs();
    for i = 1:numel(ps), set_para_bu_none_(ps{i}); end
end

function style_connector_(cxn, opts)
    if nargin < 2, opts = struct(); end
    try
        if isfield(opts,"w") && ~isempty(opts.w)
            cxn.line.width = mat2ppt.util.Emu(double(opts.w));
        end
    catch
    end
    if isfield(opts,"scheme") && ~isempty(opts.scheme)
        try
            cxn.line.color.theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(opts.scheme)));
            if isfield(opts,"brightness") && ~isempty(opts.brightness)
                cxn.line.color.brightness = double(opts.brightness);
            end
        catch
        end
    end
    if isfield(opts,"tail") && ~isempty(opts.tail)
        try, cxn.set_tail_end(char(string(opts.tail))); catch, end
        set_line_end_attrs_(cxn, "tailEnd", opts);
    end
end

function set_line_end_attrs_(cxn, tag, opts)
    try, ln = cxn.get_or_add_ln(); catch, return; end
    el = []; kids = ln.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), tag), el = kids{i}; break; end
    end
    if isempty(el), return; end
    if isfield(opts,"tailW") && ~isempty(opts.tailW) && strcmp(tag,"tailEnd"), el.set("w", char(string(opts.tailW))); end
    if isfield(opts,"tailLen") && ~isempty(opts.tailLen) && strcmp(tag,"tailEnd"), el.set("len", char(string(opts.tailLen))); end
end

function fill_scheme_(shapeObj, schemeName, brightness)
    % Solid fill only — do NOT force ln/noFill here (that kills theme outline).
    try
        shapeObj.fill().solid();
        shapeObj.fill().fore_color().theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(schemeName)));
        if nargin >= 3 && ~isempty(brightness)
            shapeObj.fill().fore_color().brightness = double(brightness);
        end
    catch
    end
end

function apply_shape_style_office_(shapeObj)
    % Match Office autoshape style used in source:
    %   lnRef idx=2 scheme accent1 shade 50000  (outline)
    %   fillRef idx=1 accent1
    %   effectRef idx=0 accent1
    %   fontRef minor lt1
    % Mat2Ppt new_sp defaults to lnRef idx=1 without shade — wrong outline weight/color.
    try
        sp = shapeObj.shape_element();
    catch
        return
    end
    style = sp.find("p:style");
    if isempty(style)
        kids = sp.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "style"), style = kids{i}; break; end
        end
    end
    if isempty(style)
        style = mat2ppt.oxml.OxmlElement("p:style");
        sp.append(style);
    else
        ck = style.getchildren();
        for i = numel(ck):-1:1, style.remove(ck{i}); end
    end
    lnRef = mat2ppt.oxml.OxmlElement("a:lnRef");
    lnRef.set("idx", "2");
    sch = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sch.set("val", "accent1");
    shd = mat2ppt.oxml.OxmlElement("a:shade");
    shd.set("val", "50000");
    sch.append(shd);
    lnRef.append(sch);
    style.append(lnRef);
    fillRef = mat2ppt.oxml.OxmlElement("a:fillRef");
    fillRef.set("idx", "1");
    sch2 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sch2.set("val", "accent1");
    fillRef.append(sch2);
    style.append(fillRef);
    effectRef = mat2ppt.oxml.OxmlElement("a:effectRef");
    effectRef.set("idx", "0");
    sch3 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sch3.set("val", "accent1");
    effectRef.append(sch3);
    style.append(effectRef);
    fontRef = mat2ppt.oxml.OxmlElement("a:fontRef");
    fontRef.set("idx", "minor");
    sch4 = mat2ppt.oxml.OxmlElement("a:schemeClr");
    sch4.set("val", "lt1");
    fontRef.append(sch4);
    style.append(fontRef);
end

function apply_line_no_fill_(shapeObj)
    % Source progress chrome uses a:ln/a:noFill (no outline stroke)
    try
        shapeObj.line.fill().background();
    catch
    end
end

function apply_run_symbol_font_(r, typeface)
    % a:sym (not a:latin) — only the run's character uses Symbol; do not
    % set latin typeface=Symbol or Latin letters render as Greek/symbols.
    rPr = ensure_run_rPr_(r);
    if isempty(rPr), return; end
    kids = rPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"latin", "sym", "ea", "cs"}))
            rPr.remove(kids{i});
        end
    end
    sym = mat2ppt.oxml.OxmlElement("a:sym");
    sym.set("typeface", char(string(typeface)));
    rPr.append(sym);
end

function apply_title_run_fonts_(tf, opts)
    % Apply same font fingerprint to every run (and soft-break rPr if any)
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        rs = ps{pi}.runs();
        for ri = 1:numel(rs)
            apply_run_font_fp_(rs{ri}, opts);
        end
        % soft-break rPr children on the paragraph element
        try
            el = ps{pi}.element();
            kids = el.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "br")
                    br = kids{i};
                    brKids = br.getchildren();
                    brPr = [];
                    for j = 1:numel(brKids)
                        if strcmp(char(brKids{j}.localName()), "rPr"), brPr = brKids{j}; break; end
                    end
                    if isempty(brPr)
                        brPr = mat2ppt.oxml.OxmlElement("a:rPr");
                        br.append(brPr);
                    end
                    write_rpr_font_fp_(brPr, opts);
                end
            end
        catch
        end
    end
end

function apply_run_font_fp_(r, opts)
    % Fingerprint-driven rPr: pt, latin, cs, cap (none/all/small)
    rPr = ensure_run_rPr_(r);
    if isempty(rPr), return; end
    write_rpr_font_fp_(rPr, opts);
    if isfield(opts, "pt") && ~isempty(opts.pt)
        try
            r.font().size = mat2ppt.util.Pt(double(opts.pt));
        catch
        end
    end
end

function write_rpr_font_fp_(rPr, opts)
    if isfield(opts, "cap") && ~isempty(opts.cap)
        rPr.set("cap", char(string(opts.cap)));
    end
    % remove existing latin/cs we will replace
    if (isfield(opts, "latin") && ~isempty(opts.latin)) || (isfield(opts, "cs") && ~isempty(opts.cs))
        kids = rPr.getchildren();
        for i = numel(kids):-1:1
            ln = char(kids{i}.localName());
            if any(strcmp(ln, {"latin", "cs", "ea"}))
                if isfield(opts, "latin") && ~isempty(opts.latin) && strcmp(ln, "latin")
                    rPr.remove(kids{i});
                elseif isfield(opts, "cs") && ~isempty(opts.cs) && strcmp(ln, "cs")
                    rPr.remove(kids{i});
                elseif strcmp(ln, "ea")
                    % leave ea unless we manage it
                end
            end
        end
    end
    if isfield(opts, "latin") && ~isempty(opts.latin)
        lat = mat2ppt.oxml.OxmlElement("a:latin");
        lat.set("typeface", char(string(opts.latin)));
        rPr.append(lat);
    end
    if isfield(opts, "cs") && ~isempty(opts.cs)
        cs = mat2ppt.oxml.OxmlElement("a:cs");
        cs.set("typeface", char(string(opts.cs)));
        rPr.append(cs);
    end
end

function rPr = ensure_run_rPr_(r)
    rPr = [];
    try
        f = r.font(); %#ok<NASGU>
    catch
    end
    try
        el = r.element();
    catch
        return
    end
    rPr = el.find("a:rPr");
    if ~isempty(rPr), return; end
    kids = el.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "rPr"), rPr = kids{i}; return; end
    end
end

function add_progress_bar_abs_(sh, ox, oy, rx, ry, gx, gy, tx, ty)
    In = @mat2ppt.util.Inches;
    % Source: solidFill + ln/noFill + style lnRef still present
    sp = sh.add_shape('ellipse', In(ox), In(oy), In(0.65), In(0.65));
    fill_scheme_(sp, "accent1", 0.8); apply_shape_style_office_(sp); apply_line_no_fill_(sp);
    sp = sh.add_shape('rect', In(rx), In(ry), In(2.0588), In(0.3517));
    fill_scheme_(sp, "accent1", 0.8); apply_shape_style_office_(sp); apply_line_no_fill_(sp);
    sp = sh.add_shape('rect', In(gx), In(gy), In(2.0), In(0.3517));
    fill_scheme_(sp, "bg1", []); apply_shape_style_office_(sp); apply_line_no_fill_(sp);
    tb = sh.add_textbox(In(tx), In(ty), In(2.0673), In(0.7068));
    style_textbox_(tb.text_frame(), '$15,250 of $30,000 Raised ', ...
        struct("bullets", false, "bold", true, "face", "Times New Roman", "autofit", "shape"));
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
