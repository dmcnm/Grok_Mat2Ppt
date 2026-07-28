%% demo.m — 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea
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

%% ===== Slide 1 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Incontrovertible Proof that Moving to Town is a Step Up in the World for the Coombs Family'}, struct("fontScale", 90000));
tf = sh.item(2).text_frame(); tf.clear();
ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'December 31, 2014 @1454';
apply_no_autofit_(tf);

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Only Warm Bedroom in House'}, struct());
body = sh.item(2);
set_shape_box_(body, 0.25, 1.3333, 9.0833, 1.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'There is the one and only warm room in the house', 0; ...
    'Polyisocyanurate insulation covers outside wall including single pane windows and single pane sliding glass doors', 0; ...
    'Has a massive gap at joint between stationary and moving parts which covered with duct tape to prevent wind from blowing in (see picture on right).', 1; ...
    'For most of winter, I’ve slept on the floor, my daughter on the top bunk and my 3 boys on the bottom bunk.', 0; ...
    'When my dad visited for Christmas, he slept on the floor of the unheated living room in a 20 degree sleeping bag', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Polyisocyanurate';
    apply_run_font_fp_(r, struct("pt", 12));
    r = p.add_run(); r.text = ' insulation covers outside wall including single pane windows and single pane sliding glass doors';
    apply_run_font_fp_(r, struct("pt", 12));
end
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'H';
    apply_run_font_fp_(r, struct("pt", 10.5));
    r = p.add_run(); r.text = 'as a massive gap at joint between stationary and moving parts which covered with duct tape to prevent wind from blowing in (see picture on right).';
    apply_run_font_fp_(r, struct("pt", 10.5));
end
p = add_pic_(sh, assets, 'image1.jpeg', 0.75, 3.1667, 3.8889, 2.9167);
p = add_pic_(sh, assets, 'image2.jpeg', 5.5, 3.5, 3.8889, 2.9167);

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Usable Bathroom'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.5, 9.0, 1.25);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Old heater in bathroom removed because 1” gaps “protecting” exposed heater wire were extreme danger to small kids, such as I have.', 0; ...
    'Bathroom unheated, but usable.  Old asbestos tile remediated and shower/toilet/sink work.', 0; ...
    'Lighting still an issue and ceiling unfinished.', 0; ...
    }, struct("listProps", false, "fontScale", 77500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image3.jpeg', 2.0365, 3.6719, 4.0417, 3.0312);
p = add_pic_(sh, assets, 'image4.jpeg', 5.6667, 3.25, 3.8889, 2.9167);

%% ===== Slide 4 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Kitchen'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.0, 1.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Wife removed cupboard doors and have had trouble finding them.', 0; ...
    'Note exposed wiring and 50 year old fluorescent lights that sometimes don’t work when it gets cold.', 0; ...
    }, struct("listProps", false, "fontScale", 70000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image5.jpeg', 2.5, 3.1667, 5.0, 3.75);

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of living room (1/3)'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.5, 0.0833, 9.0, 1.0);
body = sh.item(2);
set_shape_box_(body, 0.5, 1.0833, 9.0833, 1.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'One of the 4’x6’ single pane window replaced with used double pane off craig’s list. It has not been trimmed out.', 0; ...
    'Three other single pane windows remain plus single pane sliding glass door.', 0; ...
    ' One window has broken frame and one can see through to the outside', 0; ...
    }, struct("listProps", false, "fontScale", 47500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'One of the 4’x6’ single pane window replaced with used double pane off ';
    r = p.add_run(); r.text = 'craig’s';
    r = p.add_run(); r.text = ' list. It has not been trimmed out.';
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'T';
    r = p.add_run(); r.text = 'hree other single pane windows remain plus single pane sliding glass door.';
end
sp = sh.add_shape('rect', In(2.6494), In(4.0922), In(1), In(0.8333));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
p = add_pic_(sh, assets, 'image6.jpeg', 5.7982, 4.6667, 3.4037, 2.5528);
p = add_pic_(sh, assets, 'image7.jpeg', 0.4167, 3.3252, 5.0, 3.75);
p = add_pic_(sh, assets, 'image8.jpeg', 5.8506, 2.6926, 2.2327, 1.6745);
cxn = sh.add_connector('line', E(3336984), E(4503888), E(5334000), E(3993312));
style_connector_(cxn, struct("w", 38100));
cxn = sh.add_connector('line', E(3336984), E(3733800), E(5334000), E(2462122));
style_connector_(cxn, struct("w", 38100));

%% ===== Slide 6 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of living room (2/3)'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.25, 1.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Note single pane sliding glass door with unsealed gap between sliding and stationary parts.', 0; ...
    }, struct("listProps", false, "fontScale", 92500));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image9.jpeg', 0.75, 3.2917, 5.0, 3.75);
p = add_pic_(sh, assets, 'image10.jpeg', 6.0417, 3.8333, 3.6667, 2.75);

%% ===== Slide 7 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of living room (3/3)'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.4167, 9.3333, 1.8333);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Picture on left from earlier in Dec. 2014 shows old propane heater.', 0; ...
    'Picture on right shows this week’s installation of electric wall furnace.', 0; ...
    '30,000 BTU, 40+ amps.  Can only afford to run for a few hours a day.  Full time would cost $400+/month and only heat one room.  Can’t afford $10-20k to outfit entire house with efficient heat pumps.  Got quote earlier this  month for 12 amp heat pump for this one room.  It was $6k.  I can buy the parts for $3.25k and do myself when I have more money, but will still need to pull a permit and hire a plumber for $500 to hook up the refrigerant.  ', 1; ...
    }, struct("listProps", false, "fontScale", 55000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image11.jpeg', 2.1667, 3.3286, 2.0079, 3.8645);
if ~isempty(p), p.crop_left = 0.72479; end
if ~isempty(p), p.crop_bottom = 0.29378; end
p = add_pic_(sh, assets, 'image12.jpeg', 5.2656, 3.8177, 3.875, 2.9062);

%% ===== Slide 8 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of 2nd bedroom'}, struct());
body = sh.item(2);
set_shape_box_(body, 0.3333, 1.4167, 9.1667, 1.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Single pane windows replaced in 2nd and 3rd bedrooms Nov. - Dec. of 2014', 0; ...
    'Trim finished just this week in one room, not in the other', 1; ...
    'Note temperature is 47 degrees despite space heater being on 24-7.  Obviously, I have a serious problem here.  Walls on this side of the house are more poorly insulated than I anticipated.  Quality in this regard is very uneven throughout the house.  Also, floor is uninsulated above vented crawl space, which probably has a big effect.  When wood stove is run constantly, a space heater can keep the room tolerable.  Without it, it is miserable.  ', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Single pane windows replaced in 2';
    apply_run_font_fp_(r, struct("pt", 16));
    r = p.add_run(); r.text = 'nd';
    apply_run_font_fp_(r, struct("pt", 16));
    r = p.add_run(); r.text = ' and 3';
    apply_run_font_fp_(r, struct("pt", 16));
    r = p.add_run(); r.text = 'rd';
    apply_run_font_fp_(r, struct("pt", 16));
    r = p.add_run(); r.text = ' bedrooms Nov. - Dec. of 2014';
    apply_run_font_fp_(r, struct("pt", 16));
end
sp = sh.add_shape('rect', In(5.0833), In(5.75), In(1), In(0.8333));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
p = add_pic_(sh, assets, 'image13.jpeg', 4.6667, 3.7106, 4.4274, 3.3205);
p = add_pic_(sh, assets, 'image14.jpeg', 1.4365, 3.5499, 1.78, 3.6803);
if ~isempty(p), p.crop_left = 0.40542; end
if ~isempty(p), p.crop_top = 0.23333; end
if ~isempty(p), p.crop_right = 0.38515; end
if ~isempty(p), p.crop_bottom = 0.18931; end
cxn = sh.add_connector('line', E(4648200), E(5257800), E(3810001), E(4114802));
style_connector_(cxn, struct("w", 38100));
cxn = sh.add_connector('line', E(4648200), E(6019800), E(3810001), E(5742447));
style_connector_(cxn, struct("w", 38100));

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of third bedroom'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.478, 0.0, 9.0, 1.25);
body = sh.item(2);
set_shape_box_(body, 0.4775, 1.2253, 8.9392, 0.7747);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Single pane window replaced in November 2014, but hasn’t been trimmed out or finished.', 1; ...
    'Third bedroom is open to the bathroom since wall has been removed. ', 1; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
tb = sh.add_textbox(In(7.0833), In(1.9167), In(2.3333), In(0.4712));
style_textbox_(tb.text_frame(), 'Hole in floor for removed propane heater covered by duct tape', struct("bullets", false, "autofit", "shape", "pt", 11));
tb = sh.add_textbox(In(4.0097), In(2.0597), In(2.593), In(0.2861));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'View of bedroom from 2';
apply_run_font_fp_(r, struct("pt", 11));
r = p.add_run(); r.text = 'nd';
apply_run_font_fp_(r, struct("pt", 11));
r = p.add_run(); r.text = ' bathroom';
apply_run_font_fp_(r, struct("pt", 11));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.5162), In(2.1523), In(2.593), In(0.2861));
style_textbox_(tb.text_frame(), 'View of bathroom from bedroom', struct("bullets", false, "autofit", "shape", "pt", 11));
tb = sh.add_textbox(In(0.521), In(4.8256), In(2.593), In(0.2861));
style_textbox_(tb.text_frame(), 'Untrimmed window in third bedroom', struct("bullets", false, "autofit", "shape", "pt", 11));
tb = sh.add_textbox(In(3.8447), In(4.7686), In(6.0009), In(0.4712));
style_textbox_(tb.text_frame(), 'Overall views of bedroom showing ungrounded plugs, untrimmed windows, asbestos flooring and old recently removed single pane windows.', struct("bullets", false, "autofit", "shape", "pt", 11));
p = add_pic_(sh, assets, 'image15.jpeg', 3.75, 2.4167, 2.8527, 2.1395);
p = add_pic_(sh, assets, 'image16.jpeg', 0.4775, 5.2398, 2.8559, 2.1419);
p = add_pic_(sh, assets, 'image17.jpeg', 6.9733, 2.4962, 2.6406, 1.9804);
p = add_pic_(sh, assets, 'image18.jpeg', 6.9733, 5.2398, 2.8724, 2.1543);
p = add_pic_(sh, assets, 'image19.jpeg', 3.8447, 5.2274, 2.8889, 2.1667);

%% ===== Slide 10 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Second Bathroom'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.4167, 1.5833, 9.1667, 1.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Shower tile had been placed over unprotected drywall and was falling apart.  Walls were covered with broken mirrors which were used as wall tile and were a cutting hazard since some of the grout was starting to fall out.', 1; ...
    'Currently walls are torn out, old ungrounded wiring needs toi be replaced with modern GFI outlets and shower needs to be finished.', 1; ...
    'Note frost on single pane window in the afternoon (nearly warmest part of the day,  plenty of time to warm up)', 1; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Currently walls are torn out, old ungrounded wiring needs ';
    apply_run_font_fp_(r, struct("pt", 10.5));
    r = p.add_run(); r.text = 'toi';
    apply_run_font_fp_(r, struct("pt", 10.5));
    r = p.add_run(); r.text = ' be replaced with modern GFI outlets and shower needs to be finished.';
    apply_run_font_fp_(r, struct("pt", 10.5));
end
p = add_pic_(sh, assets, 'image20.jpeg', 0.3333, 3.0833, 4.5, 3.375);
p = add_pic_(sh, assets, 'image21.jpeg', 5.2906, 3.5278, 4.4444, 3.3333);

%% ===== Slide 11 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Basement (1/2)'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.25, 1.25, 9.25, 2.0);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Basement was used as a second bedroom in the summer ', 0; ...
    '2nd bedroom had broken single pane window from domestic violence incident for which ex-wife was charged by AG.  Since then it has been replaced as recorded earlier.', 1; ...
    'Note massive gap to outside under 2nd door and huge hole in wall with light coming in from outside (shown below).', 0; ...
    'Basement completely inappropriate to use as bedroom in winter.', 1; ...
    'Note broken window on door which is covered in packing tape and shown below (another DV incident)', 0; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Note massive gap to outside under 2';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'nd';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = ' door and huge hole in wall with light coming in from outside (shown below).';
    apply_run_font_fp_(r, struct("pt", 14));
end
sp = sh.add_shape('rect', In(1.3333), In(6.6667), In(1.4292), In(0.25));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(2.3333), In(3.7248), In(0.4292), In(0.3585));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
sp = sh.add_shape('rect', In(7.9682), In(4.7854), In(1.1152), In(1.1313));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
p = add_pic_(sh, assets, 'image22.jpeg', 1.0833, 3.25, 5.0, 3.75);
p = add_pic_(sh, assets, 'image23.jpeg', 6.5342, 3.8825, 3.7264, 2.7948);

%% ===== Slide 12 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Basement (2/2)'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.25, 1.25, 9.25, 2.0);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Basement was used as a second bedroom in the summer ', 0; ...
    '2nd bedroom had broken window from domestic violence incident for which ex-wife was charged by AG.  Since then it has been replaced as recorded earlier.', 1; ...
    'Basement completely inappropriate to use as bedroom in winter.', 1; ...
    'Note broken window on door which is covered in packing tape and shown below (another DV incident), ', 1; ...
    'Note massive gap to outside under 2nd door and huge hole in wall with light coming in from outside (shown below).', 1; ...
    'Also note that basement is open to crawl space /unfinished utility room and exposed wiring (shown below).', 1; ...
    }, struct("listProps", false));
ps = tf.paragraphs();
if numel(ps) >= 5
    p = ps{5}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Note massive gap to outside under 2';
    apply_run_font_fp_(r, struct("pt", 12));
    r = p.add_run(); r.text = 'nd';
    apply_run_font_fp_(r, struct("pt", 12));
    r = p.add_run(); r.text = ' door and huge hole in wall with light coming in from outside (shown below).';
    apply_run_font_fp_(r, struct("pt", 12));
end
sp = sh.add_shape('rect', In(6.7044), In(4.8125), In(1), In(0.8333));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
p = add_pic_(sh, assets, 'image24.jpeg', 0.3653, 3.5755, 4.2222, 3.1667);
p = add_pic_(sh, assets, 'image25.jpeg', 4.4167, 4.4649, 3.7778, 2.8333);
p = add_pic_(sh, assets, 'image26.jpeg', 7.5, 3.0, 2.4167, 1.8125);
cxn = sh.add_connector('line', E(7044906), E(5162550), E(9067801), E(4392463));
style_connector_(cxn, struct("w", 38100));
cxn = sh.add_connector('line', E(6130506), E(4392463), E(6858000), E(2743201));
style_connector_(cxn, struct("w", 38100));

%% ===== Slide 13 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Unworking Propane Heaters in most Rooms'}, struct());
set_shape_box_(sh.item(1), 0.3333, 0.1667, 9.1667, 1.3837);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 36));
body = sh.item(2);
set_shape_box_(body, 0.3333, 1.25, 9.3385, 1.3333);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Propane was pulled by Amerigas due to dangerous piping which was undisclosed.', 0; ...
    'Rusted pipes (shown below)and main supply line running through concrete make replumbing entire house necessary to ever use again.', 0; ...
    'Propane heaters were inefficient and unsafe anyway.', 1; ...
    }, struct("listProps", false, "fontScale", 55000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Propane was pulled by ';
    r = p.add_run(); r.text = 'Amerigas';
    r = p.add_run(); r.text = ' due to dangerous piping which was undisclosed.';
end
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Rusted pipes (shown below)and main supply line running through concrete make ';
    r = p.add_run(); r.text = 'replumbing';
    r = p.add_run(); r.text = ' entire house necessary to ever use again.';
end
tb = sh.add_textbox(In(0.25), In(2.4167), In(5.9167), In(1.9167));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Wood heat used on one side of house but';
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Doesn’t reach basement or other side of house';
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Is only tolerable as whole house heat if someone is home most of the day to keep it going.  ';
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Is unworkable since I leave the house at 7:45 and get home at 6:30 most days, at best.';
apply_no_bullet_all_(tf);
apply_norm_autofit_(tf, struct("fontScale", 55000, "lnSpcReduction", 20000));
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image27.jpeg', 6.714, 4.2498, 4.5625, 1.4906);
if ~isempty(p), p.crop_left = 0.00935; end
if ~isempty(p), p.crop_top = 0.33189; end
if ~isempty(p), p.crop_right = -0.00935; end
if ~isempty(p), p.crop_bottom = 0.23251; end
p = add_pic_(sh, assets, 'image28.jpeg', 4.2917, 4.1855, 3.75, 2.8125);
p = add_pic_(sh, assets, 'image29.jpeg', 0.2791, 4.2526, 3.7778, 2.8333);

%% ===== Slide 14 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'State of Flooring'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.5, 8.75, 1.75);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Asbestos tile covers one side of house.  It is coming up in numerous places, as shown below.', 0; ...
    '50 year old nylon carpet covers other side of house, except for hole where old homemade fireplace used to exist (shown below) .  Old fireplace was removed because it was a fire hazard, didn’t draft properly filling room with smoke when fire got low and sucked more heat up the chimney than it gave to room when fire was not low.', 0; ...
    }, struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image30.jpeg', 0.4167, 3.6667, 4.25, 3.1875);
p = add_pic_(sh, assets, 'image31.jpeg', 5.1667, 3.6667, 4.3333, 3.25);

%% ===== Slide 15 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Misc. Issues'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.5, 9.0, 1.1667);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Note outside trim not finished on replaced widnows.', 0; ...
    'Note rotting wood and nails sticking up on outside deck.', 0; ...
    'Why I don’t allow the kids to play there.', 1; ...
    }, struct("listProps", false, "fontScale", 70000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Note outside trim not finished on replaced ';
    r = p.add_run(); r.text = 'widnows';
    r = p.add_run(); r.text = '.';
end
sp = sh.add_shape('rect', In(3.1352), In(5.8325), In(1), In(0.8333));
try, sp.fill().background(); catch, end
apply_shape_style_office_(sp);
p = add_pic_(sh, assets, 'image32.jpeg', 5.8889, 4.3993, 4.1111, 3.0833);
p = add_pic_(sh, assets, 'image33.jpeg', 3.6352, 2.8208, 2.4481, 1.8361);
p = add_pic_(sh, assets, 'image34.jpeg', 0.3333, 4.3993, 3.5871, 2.6903);
cxn = sh.add_connector('line', E(3781245), E(6095281), E(5562600), E(4258214));
style_connector_(cxn, struct("w", 38100));
cxn = sh.add_connector('line', E(2866845), E(5325194), E(3324045), E(2579298));
style_connector_(cxn, struct("w", 38100));

%% ===== Slide 16 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Undisclosed Problems Preventing Sale'}, struct("fontScale", 90000));
body = sh.item(2);
set_shape_box_(body, 0.1667, 1.5833, 4.75, 5.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Foundation problem discovered after buying the house has outside wall leaning over an inch in just 8’.', 0; ...
    'This was not disclosed when I bought the place and must be fixed before sale.  The problem is the foundation is not solid concrete.  It is a mixed concrete and rock, making jacking it up the normal way impossible since it is only strong in compression and not tension.', 0; ...
    'Similar to the rubble trench foundations which Frank Lloyd Wright was famous for, but which are a nightmare to fix if not done properly.', 1; ...
    }, struct("listProps", false, "fontScale", 70000, "lnSpcReduction", 20000));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image35.jpeg', 4.5521, 2.5104, 6.0833, 4.5625);

%% ===== Slide 17 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Conclusions'}, struct("autofit", "none"));
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.0833, 4.4167);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Anyone who thinks this is a proper place to raise kids in winter needs to have their head examined.  It is bitterly cold and needs much work to be rentable, comfortably livable or even saleable at anything but a huge loss.', 0; ...
    'This is only a small sampling of the problems I have with this house, some of which I’m afraid to document in pictures given to people I don’t trust.', 0; ...
    'The worst part about this whole thing is that now I have to live here an extra month (the 2nd coldest month of the year), because somebody made themselves judge and jury of things had no understanding of and forced me to jump through numerous ridiculous hoops which delayed closing past Dec. 31, costing me tons of money in legal fees and forcing my kids to endure another month of mind-numbing cold.', 0; ...
    'I only bought this house because I thought I had a partner in life who could help me fix the place up and make it livable. A lawsuit over the driveway that cost me tens of thousands of dollars and tied up funds designated for fixing this house combined with my ex losing her mind, leaving me with full custody of the kids and alimony to pay conspired to cost me that dream.  Now, somebody who has no fucking idea what it is like to live here wants to take away my chance to get out of here by not allowing a loan to go through.  What are my other options: selling at a massive loss or walking a way and defaulting on the loan.  Are those options really preferable?  I think not.', 0; ...
    'Now that I’ve been completely humiliated, “Mother, may I please have my loan?”', 0; ...
    }, struct("listProps", false, "fontScale", 85000, "lnSpcReduction", 10000));
ps = tf.paragraphs();
if numel(ps) >= 3
    p = ps{3}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'The worst part about this whole thing is that now I have to live here an extra month (the 2';
    apply_run_font_fp_(r, struct("pt", 18));
    r = p.add_run(); r.text = 'nd';
    apply_run_font_fp_(r, struct("pt", 18));
    r = p.add_run(); r.text = ' coldest month of the year), because somebody made themselves judge and jury of things had no understanding of and forced me to jump through numerous ridiculous hoops which delayed closing past Dec. 31, costing me tons of money in legal fees and forcing my kids to endure another month of mind-numbing cold.';
    apply_run_font_fp_(r, struct("pt", 18));
end
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'I only bought this house because I thought I had a partner in life who could help me fix the place up and make it livable. ';
    apply_run_font_fp_(r, struct("pt", 18));
    r = p.add_run(); r.text = 'A';
    apply_run_font_fp_(r, struct("pt", 18));
    r = p.add_run(); r.text = ' lawsuit over the driveway that cost me tens of thousands of dollars and tied up funds designated for fixing this house combined with my ex losing her mind, leaving me with full custody of the kids and alimony to pay conspired to cost me that dream.  Now, somebody who has no fucking idea what it is like to live here wants to take away my chance to get out of here by not allowing a loan to go through.  What are my other options: selling at a massive loss or walking a way and defaulting on the loan.  Are those options really preferable?  I think not.';
    apply_run_font_fp_(r, struct("pt", 18));
end

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

