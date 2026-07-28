%% demo.m — 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r
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
lay_Section_Header = layouts.get_by_name('Section Header');

%% ===== Slide 1 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Mechanical Engineering', 'Career Overview'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.1667, 1.7889, 9.4167, 1.7944);
apply_title_run_fonts_(sh.item(1).text_frame(), struct("pt", 36, "cs", 'Lucida Sans Unicode', "rgb", [0 112 192]));
set_shape_box_(sh.item(2), 2.1667, 3.8333, 6.0, 1.4167);
tf = sh.item(2).text_frame(); tf.clear();
ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Douglas Coombs';
apply_run_font_fp_(r, struct("pt", 28, "scheme", 'tx1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'April 8, 2021';
apply_run_font_fp_(r, struct("pt", 28, "cs", 'Lucida Sans Unicode'));
apply_no_autofit_(tf);
sp = sh.add_shape('rect', In(0.2083), In(1.3333), In(9.5833), In(2.5833));
try, sp.fill().background(); catch, end
apply_line_no_fill_(sp);

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Overview'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Personal Intro', 0; ...
    'Types of Engineering', 0; ...
    'Educational Requirements', 0; ...
    'Career Overview', 0; ...
    'Succeed in Any Career', 0; ...
    'Q & A', 0; ...
    'Disclaimer: These are the presenter’s opinions and do not necessarily reflect those of his employers, past and present', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 7
    p = ps{7}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Disclaimer: ';
    apply_run_font_fp_(r, struct("pt", 12));
    r = p.add_run(); r.text = 'These are the presenter’s opinions and do not necessarily reflect those of his employers, past and present';
    apply_run_font_fp_(r, struct("pt", 12));
end

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Brief Personal Intro'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'Name: Douglas Coombs', 0; ...
    'Employer: Sandia National Laboratories', 0; ...
    'Title: Principal Member of the Technical Staff', 0; ...
    'Job Roles: ', 0; ...
    'Audit scientific and engineering work to ensure national security', 1; ...
    'Perform system analyses to ensure safety', 1; ...
    'Manage software projects to help engineers work more productively ', 1; ...
    'Contribute to R&D efforts to advance product lines', 1; ...
    'Did that make any sense?', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 9
    p = ps{9}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Did that ';
    r = p.add_run(); r.text = 'make any sense?';
end

%% ===== Slide 4 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Types of Engineering'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
tf = sh.item(2).text_frame();
style_body_levels_(tf, { ...
    'What do engineers do? ', 0; ...
    'We solve scientific and technical problems to create the infrastructure and products that enable modern life', 1; ...
    'Train engineers vs. technical engineers ', 0; ...
    'Types of Engineers', 0; ...
    'Civil, Mechanical, and Electrical (most engineers) ', 1; ...
    'Niche fields', 1; ...
    'Chemical, Bio-Medical, Materials, Industrial, Aerospace, Mining, Petroleum, Nuclear, Marine, Agricultural, Environmental', 2; ...
    'Wide range of pay depending on industry, difficulty and educational level attained ($50k-$250k, median ~85k)', 0; ...
    'Commodities vs cutting edge technologies', 1; ...
    'Scalability of product', 1; ...
    'Good bread and butter job to support a family with', 1; ...
    'Most people can do it if they work hard enough – not like sports or acting where only the top .01% succeed and make enough money to support a family', 2; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
tb = sh.add_textbox(In(8.5466), In(3.75), In(0.9961), In(1.3127));
style_textbox_(tb.text_frame(), '', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 72, "rgb", [0 176 80]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 72, "cap", 'none', "rgb", [0 176 80])); end
tb = sh.add_textbox(In(0.185), In(4.0734), In(1.9664), In(3.1302));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Civil Engineering';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Bridges, Roads,  Dams, Skyscrapers, Sewage Treatment';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.2027), In(4.0415), In(2.2362), In(3.4669));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Mechanical Engineering';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Rockets, Trucks, Cars, Household Appliances, Airplanes, Machines in General';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.1667), In(3.9932), In(2.3807), In(3.1303));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Electrical Engineering';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
p = tf.add_paragraph(); p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Computers, Phones, Communication Infrastructure, General Electronics';
apply_run_font_fp_(r, struct("bold", true, "scheme", 'tx1'));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image6.jpg', 5.5833, 3.3333, 4.2796, 3.4271);
p = add_pic_(sh, assets, 'image7.jpg', 0.4796, 3.5417, 4.8369, 3.2188);
p = add_pic_(sh, assets, 'image8.jpg', 2.6667, 5.3835, 3.7314, 2.0149);
p = add_pic_(sh, assets, 'image9.png', 6.4989, 5.4504, 3.0573, 1.9553);
p = add_pic_(sh, assets, 'image10.png', 2.6667, 3.4021, 3.605, 1.9402);
p = add_pic_(sh, assets, 'image11.png', 6.3239, 3.4401, 3.4206, 1.8643);
p = add_pic_(sh, assets, 'image12.png', 2.5311, 5.5884, 2.1771, 1.6307);
p = add_pic_(sh, assets, 'image13.png', 4.8928, 5.7201, 2.194, 1.46);
p = add_pic_(sh, assets, 'image14.png', 7.1915, 5.6907, 2.5985, 1.46);
p = add_pic_(sh, assets, 'image15.png', 2.5016, 4.0621, 2.2362, 1.4245);
p = add_pic_(sh, assets, 'image16.png', 4.829, 4.0893, 2.3802, 1.3973);
p = add_pic_(sh, assets, 'image17.png', 7.1777, 3.9875, 1.4516, 1.6008);
p = add_pic_(sh, assets, 'image18.png', 8.3739, 4.0833, 1.505, 1.505);
p = add_pic_(sh, assets, 'image19.jpg', 7.1133, 5.4397, 2.6725, 1.675);
p = add_pic_(sh, assets, 'image20.png', 6.966, 3.5335, 2.8646, 1.9062);
p = add_pic_(sh, assets, 'image21.jpg', 2.7754, 5.5738, 1.4041, 1.5289);
p = add_pic_(sh, assets, 'image22.png', 3.1613, 3.5692, 3.5575, 1.8705);
p = add_pic_(sh, assets, 'image23.jpg', 4.2255, 5.5738, 2.8329, 1.6311);
if ~isempty(p), p.crop_right = 0.09818; end
p = add_pic_(sh, assets, 'image24.jpg', 7.3338, 6.1027, 1.9637, 1.3322);
if ~isempty(p), p.crop_left = 0.32; end
p = add_pic_(sh, assets, 'image25.jpg', 6.9408, 4.6849, 2.6471, 1.4511);
p = add_pic_(sh, assets, 'image26.jpg', 3.3059, 4.6948, 3.6349, 1.232);
p = add_pic_(sh, assets, 'image27.png', 3.6756, 5.9838, 2.6471, 1.4511);
p = add_pic_(sh, assets, 'image28.png', 0.6588, 5.9367, 2.6471, 1.4511);
p = add_pic_(sh, assets, 'image29.png', 0.7358, 4.7071, 2.4931, 1.433);
if ~isempty(p), p.crop_top = 0.06845; end
cxn = sh.add_connector('line', E(438555), E(3238499), E(4861436), E(6181725));
style_connector_(cxn, struct("w", 73025, "tail", 'none', "tailW", 'med', "tailLen", 'med'));
cxn = sh.add_connector('line', E(438555), E(6181725), E(4861436), E(3238499));
style_connector_(cxn, struct("w", 73025, "tail", 'none', "tailW", 'med', "tailLen", 'med'));

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Educational Requirements'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
set_shape_box_(body, 0.0833, 1.25, 9.9167, 4.75);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'A bachelors degree in engineering  entry level jobs', 0; ...
    'A master’s (minimum) is required for more advanced projects ', 0; ...
    'Most flexible degree.  Takes an extra two years after getting a bachelor’s degree', 1; ...
    'More advanced engineering pays better – Excellent investment of time', 1; ...
    'A PhD is required for very high level projects ', 0; ...
    'Can narrow opportunities.  Increases pay in many fields but can take a long time to attain (typically 2-8 years, average of 3-4).', 1; ...
    'Sometimes the monetary pay-off isn’t there – Succeed or fail quickly is a good strategy', 1; ...
    'Engineers get paid to go to graduate school.  They only take out loans for undergrad.', 0; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 1
    p = ps{1}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'A bachelors degree in engineering ';
    apply_run_font_fp_(r, struct("pt", 20));
    r = p.add_run(); r.text = ' ';
    apply_run_font_fp_(r, struct("pt", 20));
    r = p.add_run(); r.text = 'entry level jobs';
    apply_run_font_fp_(r, struct("pt", 20));
end
if numel(ps) >= 8
    p = ps{8}; p.clear_content(); p.level = 0;
    r = p.add_run(); r.text = 'Engineers get paid to go to graduate school.  ';
    apply_run_font_fp_(r, struct("pt", 20));
    r = p.add_run(); r.text = 'They only take out loans for undergrad.';
    apply_run_font_fp_(r, struct("pt", 20));
end
tb = sh.add_textbox(In(5.5032), In(4.9838), In(2.4167), In(0.3366));
style_textbox_(tb.text_frame(), 'Get paid to go to school', struct("bullets", false, "autofit", "shape", "pt", 14, "bold", true, "scheme", 'accent1'));
p = add_pic_(sh, assets, 'image30.png', 2.6667, 4.9184, 5.3333, 2.5935);
cxn = sh.add_connector('straightConnector1', E(5029200), E(4876800), E(7162800), E(4876800));
style_connector_(cxn, struct("w", 25400, "scheme", 'accent1', "tail", 'triangle'));

%% ===== Slide 6 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Career Overview'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
set_shape_box_(body, 0.0, 1.1858, 9.8333, 5.8385);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'High School and College Jobs', 0; ...
    'Picked produce at local farms', 1; ...
    'Yard work for elderly', 1; ...
    'Campus workstudy: mailroom and computer lab', 1; ...
    'Built homes for local construction company', 1; ...
    'Bachelor’s degree @ University of Portland', 0; ...
    'Internship @ Boeing: Maintained manufacturing equipment for Boeing 747 and 737 ', 1; ...
    'Master’s degree @ University of Cincinnati', 0; ...
    'Taught classes and worked on suspension modeling of pickup trucks', 1; ...
    'York International', 0; ...
    'Designed and produced air handlers to keep things comfortable and quiet in schools, concert halls, and hospitals', 1; ...
    'Moog-CSA Engineering ', 0; ...
    'Projects: Space Launch System (rocket to go to the moon), ESPA (mount lots of small satellites on big rockets), NICER (looking at the sun’s energy from the International Space Station to feed environmental models for global warming calculations), XSS-11, DSX, Giant Magellan Telescope (six 27’ mirrors to make an 80 ft visible spectrum telescope, resolution 10 times better than Hubble), Recon Optical telescopes for pods on F-15 jets.', 1; ...
    'Sandia National Laboratories ', 0; ...
    'Evaluate the engineering work of others to ensure that it meets technical rigor in order to keep our country safe ', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Campus ';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'workstudy';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = ': mailroom and computer lab';
    apply_run_font_fp_(r, struct("pt", 14));
end
if numel(ps) >= 11
    p = ps{11}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Designed and produced air handlers to keep things comfortable ';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'and quiet in schools, concert halls, and hospitals';
    apply_run_font_fp_(r, struct("pt", 14));
end
tb = sh.add_textbox(In(7.5847), In(1.6), In(1.6667), In(1.1107));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Step 1:';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 176 240]));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = 'Learn to work hard';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 176 240]));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(7.6234), In(2.8185), In(2.2024), In(1.1107));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Step 2:';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 176 240]));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = 'Learn a Valuable Skill';
apply_run_font_fp_(r, struct("bold", true, "rgb", [0 176 240]));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(7.1666), In(3.9831), In(2.8529), In(1.3127));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Step 3:';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "rgb", [0 176 240]));
p.element().append(mat2ppt.oxml.OxmlElement("a:br"));
r = p.add_run(); r.text = 'Get Paid to Work Hard at Job Using Your  Valuable Skill';
apply_run_font_fp_(r, struct("pt", 18, "bold", true, "rgb", [0 176 240]));
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image31.jpg', 10.2614, 5.72, 2.875, 1.9062);

%% ===== Slide 7 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Step 1: Learn to Work Hard'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0104, 7.8316, 1.1754);
body = sh.item(2);
set_shape_box_(body, 0.0871, 1.3183, 9.3681, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'High School and College Jobs', 0; ...
    'Picked produce at local farms', 1; ...
    'Yard work for elderly', 1; ...
    'Campus workstudy: mailroom and computer lab', 1; ...
    'Built homes for local construction company', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 4
    p = ps{4}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Campus ';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'workstudy';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = ': mailroom and computer lab';
    apply_run_font_fp_(r, struct("pt", 14));
end
p = add_pic_(sh, assets, 'image32.jpeg', 0.3101, 3.3085, 3.5312, 2.0873);
if ~isempty(p), p.crop_left = 0.52219; end
if ~isempty(p), p.crop_top = 0.6868; end
p = add_pic_(sh, assets, 'image33.jpg', 3.8124, 5.2039, 4.3681, 2.1118);
if ~isempty(p), p.crop_top = 0.19076; end
p = add_pic_(sh, assets, 'image34.jpg', 3.8062, 3.023, 4.3743, 2.1992);
p = add_pic_(sh, assets, 'image35.jpg', 0.3101, 5.3958, 3.5193, 1.9199);
p = add_pic_(sh, assets, 'image36.jpg', 0.2673, 3.1168, 5.8987, 4.1777);
if ~isempty(p), p.crop_left = 0.03396; end
if ~isempty(p), p.crop_top = 0.02578; end
if ~isempty(p), p.crop_right = 0.07922; end
if ~isempty(p), p.crop_bottom = 0.03893; end
p = add_pic_(sh, assets, 'image37.jpg', 6.1485, 4.9684, 3.3976, 2.2609);
p = add_pic_(sh, assets, 'image38.jpg', 6.1485, 1.5422, 3.4262, 3.4262);
p = add_pic_(sh, assets, 'image39.jpg', 5.0725, 3.8466, 4.8533, 3.2711);
p = add_pic_(sh, assets, 'image40.jpg', 0.2205, 3.8529, 4.8609, 3.2347);
p = add_pic_(sh, assets, 'image41.jpg', 3.4964, 5.4549, 3.125, 1.75);
p = add_pic_(sh, assets, 'image42.jpg', 6.933, 3.1571, 2.3438, 2.3438);
p = add_pic_(sh, assets, 'image43.jpg', 0.3746, 5.4549, 3.125, 1.75);
p = add_pic_(sh, assets, 'image44.jpg', 6.579, 5.4549, 2.6249, 1.7467);
p = add_pic_(sh, assets, 'image45.jpg', 3.4713, 3.7049, 3.489, 1.75);
p = add_pic_(sh, assets, 'image46.jpg', 0.3697, 3.7049, 3.1146, 1.75);

%% ===== Slide 8 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Step 2: Learn a Valuable Skill'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
set_shape_box_(body, 0.1849, 1.2393, 9.4331, 5.7851);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'Bachelor’s degree @ University of Portland', 0; ...
    'Internship @ Boeing: Maintained manufacturing equipment for Boeing 747 and 737 ', 1; ...
    'Master’s degree @ University of Cincinnati', 0; ...
    'Taught classes and worked on suspension modeling of pickup trucks', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
p = add_pic_(sh, assets, 'image47.jpg', 0.1849, 2.8165, 4.1482, 3.3439);
if ~isempty(p), p.crop_left = 0.04536; end
p = add_pic_(sh, assets, 'image48.jpg', 4.2716, 2.8395, 5.6207, 3.3209);
if ~isempty(p), p.crop_right = 0.05218; end
p = add_pic_(sh, assets, 'image49.jpg', 6.5, 6.2375, 3.0862, 1.1035);
if ~isempty(p), p.crop_top = 0.2376; end
if ~isempty(p), p.crop_bottom = 0.22507; end
p = add_pic_(sh, assets, 'image50.jpg', 3.3155, 6.24, 3.0078, 1.1035);
if ~isempty(p), p.crop_top = 0.18389; end
if ~isempty(p), p.crop_bottom = 0.16314; end
p = add_pic_(sh, assets, 'image51.jpg', 0.2097, 6.2375, 2.9291, 1.106);
if ~isempty(p), p.crop_top = 0.12592; end
if ~isempty(p), p.crop_bottom = 0.26822; end
p = add_pic_(sh, assets, 'image52.jpg', 2.6006, 4.8464, 3.5421, 2.6193);
p = add_pic_(sh, assets, 'image53.jpg', 6.1118, 4.8125, 3.5421, 2.6532);
p = add_pic_(sh, assets, 'image54.jpg', 6.1118, 2.5, 3.5421, 2.3571);
p = add_pic_(sh, assets, 'image55.jpg', 2.7278, 3.252, 3.4062, 1.6042);
p = add_pic_(sh, assets, 'image56.jpg', 0.1667, 4.7929, 2.5833, 2.629);
if ~isempty(p), p.crop_left = 0.01942; end
if ~isempty(p), p.crop_top = 0.05411; end
if ~isempty(p), p.crop_right = 0.61637; end
if ~isempty(p), p.crop_bottom = 0.08106; end

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Step 3: Work Hard at Job ', 'Using Valuable Skill'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0197, 7.8316, 1.1661);
body = sh.item(2);
set_shape_box_(body, -0.0097, 1.2552, 9.5196, 0.8906);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'York International', 0; ...
    'Designed and produced air handlers to keep things comfortable and quiet in schools, concert halls, and hospitals', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();
if numel(ps) >= 2
    p = ps{2}; p.clear_content(); p.level = 1;
    r = p.add_run(); r.text = 'Designed and produced air handlers to keep things comfortable ';
    apply_run_font_fp_(r, struct("pt", 14));
    r = p.add_run(); r.text = 'and quiet in schools, concert halls, and hospitals';
    apply_run_font_fp_(r, struct("pt", 14));
end
tb = sh.add_textbox(In(-0.0003), In(1.25), In(9.4514), In(1.526));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Moog-CSA Engineering ';
apply_run_font_fp_(r, struct("pt", 16));
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Projects: Space Launch System (rocket to go to the moon), ESPA (mount lots of small satellites on big rockets), NICER (looking at the sun’s energy from the International Space Station to feed environmental models for global warming calculations), XSS-11, DSX, Giant Magellan Telescope (six 27’ mirrors to make an 80 ft visible spectrum telescope, resolution 10 times better than Hubble), Recon Optical telescopes for pods on F-15 jets.';
apply_run_font_fp_(r, struct("pt", 14));
apply_no_bullet_all_(tf);
apply_no_autofit_(tf);
set_body_anchor_(tf, 't');
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0), In(1.25), In(9.4514), In(0.8906));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'Sandia National Laboratories ';
apply_run_font_fp_(r, struct("pt", 16));
p = tf.add_paragraph(); p.clear_content(); p.level = 1;
r = p.add_run(); r.text = 'Evaluate the engineering work of others to ensure that it meets technical rigor in order to keep our country safe ';
apply_run_font_fp_(r, struct("pt", 14));
apply_no_bullet_all_(tf);
apply_no_autofit_(tf);
set_body_anchor_(tf, 't');
try, tf.word_wrap = true; catch, end
p = add_pic_(sh, assets, 'image57.jpg', 0.169, 2.2412, 3.516, 2.5363);
if ~isempty(p), p.crop_left = 0.07751; end
p = add_pic_(sh, assets, 'image58.jpg', 3.419, 2.2412, 6.4102, 2.5713);
p = add_pic_(sh, assets, 'image59.jpg', 0.0041, 4.9377, 3.5807, 2.3828);
p = add_pic_(sh, assets, 'image60.jpg', 8.4758, 5.4275, 1.2786, 1.8768);
if ~isempty(p), p.crop_left = 0.29381; end
if ~isempty(p), p.crop_right = 0.32947; end
p = add_pic_(sh, assets, 'image61.jpg', 3.4623, 2.9186, 3.4879, 4.4343);
p = add_pic_(sh, assets, 'image62.jpg', 6.813, 3.8133, 2.9411, 1.6525);
p = add_pic_(sh, assets, 'image63.jpg', 0.0587, 2.595, 3.2396, 2.3228);
p = add_pic_(sh, assets, 'image64.jpg', 6.813, 2.574, 2.1978, 1.2308);
p = add_pic_(sh, assets, 'image65.jpg', 6.9447, 5.6502, 1.5448, 1.8301);
if ~isempty(p), p.crop_left = 0.02833; end
if ~isempty(p), p.crop_top = 0.06759; end
if ~isempty(p), p.crop_right = 0.15955; end
if ~isempty(p), p.crop_bottom = 0.25137; end
p = add_pic_(sh, assets, 'image66.jpg', 1.2761, 4.8275, 3.4759, 2.0664);
p = add_pic_(sh, assets, 'image67.jpg', 4.769, 4.3237, 3.8037, 2.5312);
p = add_pic_(sh, assets, 'image68.jpg', 1.3055, 2.4418, 3.4759, 2.3857);
p = add_pic_(sh, assets, 'image69.jpg', 4.7765, 2.8454, 3.7923, 1.5169);

%% ===== Slide 10 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Succeed in Any Career'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 1.0833, 0.0, 7.8316, 1.1858);
body = sh.item(2);
set_shape_box_(body, 0.0833, 1.3333, 9.8333, 5.6684);
tf = body.text_frame();
style_body_levels_(tf, { ...
    'What are the most important ingredients to a successful career?', 0; ...
    'Hard work', 1; ...
    'Learn as much as possible about the field', 1; ...
    'Formal education', 2; ...
    'Internships', 2; ...
    'Apprenticeships', 2; ...
    'Very difficult and very dangerous jobs pay better than easy jobs', 0; ...
    'Examples: doctors and underwater welders', 1; ...
    'Jobs that can replicate at scale pay better than jobs that require individual attention', 0; ...
    'Software development vs. early childhood education', 1; ...
    'Pay isn’t the only factor in deciding on a career', 0; ...
    'The pay is terrible for artists, priests and stay-at-home moms, but the spiritual and emotional rewards are great – money isn’t the most important thing in life', 1; ...
    }, struct("listProps", false, "autofit", "none"));
ps = tf.paragraphs();

%% ===== Slide 11 · Section Header =====
s = prs.slides().add_slide(lay_Section_Header);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {'Questions?'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.75, 3.7468, 8.5, 1.4896);

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

