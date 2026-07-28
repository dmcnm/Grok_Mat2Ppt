%% demo.m — SLG Intro for Scientists (Rev1) using SOURCE master/theme
% Source: SLG_Intro4Scientists_Rev1.pptx
%
% CRITICAL: Open source_template.pptx (Gallery theme + master + layouts),
% NOT default.pptx. That supplies:
%   - beige master background (bg2)
%   - wood floor image on master
%   - red accent title rules on layouts
%   - Georgia + all-caps title styles
%
% Skills: mat2ppt-slide-templates, mat2ppt-image-place-crop,
%         mat2ppt-bullet-autofit, mat2ppt-font-paragraph-audit

here = fileparts(mfilename("fullpath"));
addpath(fullfile(here, "..", "..", ".."));
outPath = fullfile(here, "out_mat2ppt.pptx");
assets = fullfile(here, "assets");
tpl = fullfile(here, "source_template.pptx");
if ~isfile(tpl)
    error("mat2ppt:MissingTemplate", ...
        "Missing source_template.pptx — rebuild from reference_original.pptx");
end

In = @mat2ppt.util.Inches;
Pt = @mat2ppt.util.Pt;
AS = mat2ppt.enum.MSO_AUTO_SIZE;

% --- SOURCE PACKAGE (masters / theme / layouts) ---
prs = mat2ppt.Presentation(tpl);
% slide size already matches source widescreen

layouts = prs.slide_layouts();
lay_Title_Slide = layouts.get_by_name("Title Slide");
lay_Title_and_Content = layouts.get_by_name("Title and Content");

%% ===== Slide 1 · Title Slide =====
% Source title is ONE paragraph with soft break and **two run sizes**:
%   "Science vs. Art" → NO explicit sz (inherits layout ctrTitle 66 pt)
%   "Left-Brain vs. Right-Brain thinking?" → rPr sz=4400 (44 pt)
% Do not force 66 on line 1 — that fights layout/autofit and looks uneven.
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();
tf = sh.item(1).text_frame();
set_mixed_title_(tf, { ...
    "Science vs. Art", []; ...
    "Left-Brain vs. Right-Brain thinking?", 44});
tf.auto_size = AS.TEXT_TO_FIT_SHAPE;
% Subtitle: source overrides layout xfrm (centered lower band)
sub = sh.item(2);
set_shape_box_(sub, 5087501/914400, 4508825/914400, 8637072/914400, 977621/914400);
fill_paras_(sub.text_frame(), {"Douglas Coombs", "June 6, 2022"}, 0);
% Layout subTitle: 18 pt, all-caps, Georgia from theme — set face+size only
format_all_runs_(sub.text_frame(), struct("face", "Georgia", "pt", 18));
apply_no_bullet_all_(sub.text_frame());

%% ===== Slide 2 · Title and Content =====
% ORDER: (1) match source body BOX, (2) then font/para + normAutofit+fontScale.
% Source body xfrm: 0.525 x 1.0263, 11.3591 x 3.8418; sz=2800; fontScale=92500.
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {"What Makes a Great Scientist?"});
body = sh.item(2);
set_shape_box_(body, 0.525, 1.0263, 11.3591, 3.8418);
style_body_(body.text_frame(), { ...
    "Knowing science and math facts", 0, 28; ...
    "Being able to solve known scientific problems", 0, 28; ...
    ["Being able to acquire new data and assemble new theories to expand ", ...
     "knowledge and answer specific questions about the universe"], 0, 28; ...
    "Is there something that many of our greatest scientists have in common?", 0, 28}, ...
    struct("bullets", true, "face", "Georgia", "fontScale", 92500));
add_pic_(sh, assets, "image3.png", 0.6821, 4.5775, 2.3852, 2.872);
p = add_pic_(sh, assets, "image4.jpg", 5.2288, 4.5605, 2.369, 2.872);
if ~isempty(p), p.crop_top = 0.077; end
add_pic_(sh, assets, "image5.jpg", 9.825, 4.5775, 2.4951, 2.872);
add_pic_(sh, assets, "image6.jpg", 0.6821, 5.8758, 3.0083, 1.519);
add_pic_(sh, assets, "image7.jpg", 4.3305, 4.5605, 4.3543, 2.872);
add_pic_(sh, assets, "image8.jpg", 9.6302, 4.5775, 2.8847, 2.8847);

%% ===== Slide 3 · free columns + gold quote =====
% Free shapes need full list para props (marL/indent/spc/bu) matching source
% lstStyle — not bare buChar on default free-textbox indents.
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {"Science: Left-Brain or Right-Brain Thinking?"});
remove_shape_at_(sh, 2);
% Subtitle — no bullets, spAutoFit
tb = sh.add_textbox(In(1.9851), In(0.9876), In(9.9714), In(0.4039));
style_textbox_(tb.text_frame(), ...
    "Our perceptions of the world come from paying a certain kind of attention to it", ...
    struct("face", "Georgia", "bullets", false, "autofit", "shape"));
% Column headers — 20 pt, accent1 bullets, hanging indent, body insets + anchor t
tb = sh.add_textbox(In(0.3781), In(1.3915), In(6.5254), In(0.4746));
style_textbox_(tb.text_frame(), "Left-Brain Characteristics", ...
    struct("face", "Georgia", "pt", 20, "bullets", true, "listProps", true, ...
           "bodyInsets", true));
tb = sh.add_textbox(In(0.3781), In(1.866), In(6.5254), In(4.862));
style_body_(tb.text_frame(), { ...
    "Helps us manipulate the world", 0, 14; ...
    "Clinical attention", 0, 14; ...
    "Left hemisphere sees isolated details that are", 0, 14; ...
    "Familiar", 1, 11; "Known", 1, 11; "Fixed", 1, 11; "Graspable", 1, 11; ...
    "Abstracted", 1, 11; "Taken out of context", 1, 11; "Categorizable", 1, 11; ...
    "General in nature", 1, 11; ...
    ["Generally inanimate, because the process has completely isolated them ", ...
     "from everything else and deaminated them"], 1, 11; ...
    "Grasping a tiny detail", 0, 14; ...
    "Narrowly, focused, targeted attention to something it already knows about", 0, 14}, ...
    struct("face", "Georgia", "listProps", true, "lnSpcReduction", 10000));
tb = sh.add_textbox(In(7.0649), In(1.3915), In(5.8903), In(0.4746));
style_textbox_(tb.text_frame(), "Right-Brain Characteristics", ...
    struct("face", "Georgia", "pt", 20, "bullets", true, "listProps", true, ...
           "bodyInsets", true));
tb = sh.add_textbox(In(7.0649), In(1.866), In(5.8903), In(4.862));
style_body_(tb.text_frame(), { ...
    "Helps us understand the world", 0, 14; ...
    "Rapt attention", 0, 14; ...
    "Right hemisphere’s vision sees things that are", 0, 14; ...
    "only partly known", 1, 12; ...
    "only partly certain of what we are looking at", 1, 12; ...
    "Fresh", 1, 12; ...
    "Interconnected, and situated where they are in context", 1, 12; ...
    "When we take them out of context, they change their nature", 2, 10; ...
    "Flowing and changing, not fixed and graspable in a simple way", 1, 12; ...
    "Unique rather than exemplars of a common theme", 1, 12; ...
    "Embodied rather than abstracted and disembodied", 1, 12; ...
    "Animate, rather than inanimate", 1, 12; ...
    "Has the ability to look out for something we might be missing -- more skeptical", 1, 12; ...
    "Assembles facts for application in an embodied world.", 0, 14}, ...
    struct("face", "Georgia", "listProps", true, "lnSpcReduction", 10000));
% Quote — gold; spAutoFit
tb = sh.add_textbox(In(1.0052), In(6.728), In(12.1194), In(0.7068));
quote = ["Reason is this ability to bring together the faculties of logic with the ", ...
    "faculties of an intuitive, implicit, embodied understanding of what it ", ...
    "means to be alive” –Iain McGilchrist"];
style_textbox_(tb.text_frame(), strjoin(string(quote), ""), ...
    struct("face", "Georgia", "rgb", {[255, 192, 0]}, ...
           "bullets", false, "autofit", "shape"));

%% ===== Slide 4 · custom title/body boxes; bodyPr NO autofit (source) =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
set_shape_box_(sh.item(1), 0.3134, 0.0505, 13.0199, 0.9588);
style_title_(sh.item(1).text_frame(), {"Developing the Right-Brain"});
body = sh.item(2);
set_shape_box_(body, 0.3134, 1.0263, 12.791, 6.2201);
style_body_(body.text_frame(), { ...
    "If we want to educate students to be world-class scientists, we need to develop and not dismiss right-brain thinking", 0, []; ...
    "Both left and right-brain thinking are critical for breakthrough science", 1, []; ...
    "Teach an understanding of and appreciation for Music, Art, and the Sacred", 0, []; ...
    "For example: band, drawing, family, and the pledge of allegiance/reveille", 1, []; ...
    "The Saint Luke Guild was founded to bring high quality, physical reproductions of the greatest works of art to students of average means", 0, []; ...
    "Enabled by two technological developments from the last 20 years", 1, []; ...
    "The explosion of high-resolution, digital imagery of the greatest works of art, previously reserved to museum visitors", 2, []; ...
    "The dramatic improvements in low-cost, museum quality photographic printing methods", 2, []}, ...
    struct("face", "Georgia", "listProps", true, "autofit", "none"));

%% ===== Slide 5 · soft-break title + same body box; no body autofit =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
set_shape_box_(sh.item(1), 0.3134, 0.0505, 13.0199, 0.9588);
style_title_(sh.item(1).text_frame(), {"Example Project", "Holy Child Catholic School"}, ...
    struct("fontScale", 90000));
body = sh.item(2);
set_shape_box_(body, 0.3134, 1.0263, 12.791, 6.2201);
style_body_(body.text_frame(), { ...
    "Bring around 50 paintings showing both a timeline of art and world history to Holy Child Catholic School in Tijeras, NM", 0, []; ...
    "$30k in artwork installed in the last 1.5 years", 1, []; ...
    "$30k in funding promised by donors to complete the hallway", 1, []}, ...
    struct("face", "Georgia", "listProps", true, "autofit", "none"));
p = add_pic_(sh, assets, "image9.png", 0.216, 2.821, 12.782, 4.629);
if ~isempty(p)
    p.crop_top = 0.16394;
    p.crop_bottom = 0.14168;
end

%% ===== Slide 6 · painting + artist sidebar (lstStyle-equivalent props) =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {"Example Painting", "David: oath of the horatii"}, ...
    struct("fontScale", 90000));
remove_shape_at_(sh, 2);
pic = add_pic_(sh, assets, "image10.jpg", 1.1493, 1.0839, 8.2621, 6.3667);
if ~isempty(pic), send_to_back_(sh, pic); end
tb = sh.add_textbox(In(9.8476), In(1.0263), In(3.4858), In(6.4737));
fill_artist_sidebar_(tb.text_frame(), { ...
    "Jacques-Louis David  (1470–1531)"; ...
    "1784, oil on canvas"; ...
    sprintf("329.8 x 424.8 cm\n(129.8 x 167.2 in)"); ...
    "HCCS: 31” x 40”"; ...
    "Louvre, Paris, France"; ...
    "3600 x 2844 px (Wikipedia, Google)"});

%% ===== Slide 7 · painting + artist sidebar =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {"Example Painting", "Rembrandt: Return of the prodigal Son"}, ...
    struct("fontScale", 90000));
remove_shape_at_(sh, 2);
pic = add_pic_(sh, assets, "image11.jpg", 2.884, 1.0575, 5.0543, 6.3004);
if ~isempty(pic), send_to_back_(sh, pic); end
tb = sh.add_textbox(In(9.8476), In(1.0263), In(3.4858), In(6.4737));
fill_artist_sidebar_(tb.text_frame(), { ...
    "Rembrandt van Rijn  (1606–1669)"; ...
    "1668, oil on canvas"; ...
    sprintf("262 x 205 cm\n(103.1 x 80.7 in)"); ...
    "HCCS: 30” x 38”"; ...
    "Hermitage Museum, St. Petersburg, Russia"; ...
    "22,991 x 30,000 px (Wikipedia, Google)"});

%% ===== Slide 8 · Summary =====
% Source body box + sz 24/20 + fontScale=85000 (visual ~20.4/17 pt — not "inherit smaller").
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
style_title_(sh.item(1).text_frame(), {"Summary"});
body = sh.item(2);
set_shape_box_(body, 0.3134, 1.0093, 12.9227, 5.9609);
style_body_(body.text_frame(), { ...
    "Left-brain science brings us disembodied, decontextualized facts about the world", 0, 24; ...
    "Art and myth are centered in the right-brain and are focused on how embodied humans should act in the real world, which is particular and uncertain", 0, 24; ...
    "Both left and right-brained thinking is necessary for a world-class scientific enterprise", 0, 24; ...
    "The scientist is servant to the humanities major", 0, 24; ...
    "They control how our inventions are used", 1, 20; ...
    "The Saint Luke Guild helps develop right-brain thinking by bringing high quality reproductions of the greatest works of art in the Western Canon to average students", 0, 24; ...
    "Developing an appreciation for rapt attention alongside clinical attention", 1, 20; ...
    "Over 10 years projects of a similar scale could be done in every school throughout the country for ~.086% of their budget ($50k*130,980 schools/$762 billion/10 years)", 0, []; ...
    "Compare with Zuckerberg’s $100,000,000 donation to the Newark School District – Zero improvement in student achievement", 1, []; ...
    "Fixing education is an extraordinarily difficult problem – No one solution will do", 1, []; ...
    "We need to reinvigorate the imagination and motivation of students – The problem more of a soul problem than a money problem", 1, []}, ...
    struct("bullets", true, "face", "Georgia", ...
           "fontScale", 85000, "lnSpcReduction", 10000));

prs.save(outPath);
fprintf("Wrote %s (source master/theme package)\n", outPath);

%% ===================== helpers =====================

function pic = add_pic_(sh, assets, name, L, T, W, H)
    In = @mat2ppt.util.Inches;
    img = fullfile(assets, name);
    pic = [];
    if isfile(img)
        pic = sh.add_picture(img, In(L), In(T), In(W), In(H));
    end
end

function fill_paras_(tf, lines, level)
    tf.clear();
    ps = tf.paragraphs();
    for i = 1:numel(lines)
        if i == 1
            p = ps{1};
        else
            p = tf.add_paragraph();
        end
        p.text = char(string(lines{i}));
        p.level = level;
    end
end

function style_title_(tf, lines, opts)
    %STYLE_TITLE_  Placeholder title: one paragraph, soft breaks between lines.
    % Optional opts.fontScale (e.g. 90000) on normAutofit — matches source.
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    if isstring(lines), lines = cellstr(lines); end
    if ischar(lines), lines = {lines}; end
    rows = cell(numel(lines), 2);
    for i = 1:numel(lines)
        rows{i, 1} = lines{i};
        rows{i, 2} = [];  % inherit layout/master size
    end
    set_mixed_title_(tf, rows);
    apply_norm_autofit_(tf, opts);
end

function style_textbox_(tf, text, opts)
    %STYLE_TEXTBOX_  Single-paragraph free textbox with uniform run policy.
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    tf.text = char(string(text));
    useList = isfield(opts, "listProps") && opts.listProps;
    if useList
        apply_list_para_props_(tf, true);
    elseif isfield(opts, "bullets") && ~isempty(opts.bullets)
        apply_bullet_all_(tf, logical(opts.bullets));
    end
    runOpts = struct();
    if isfield(opts, "face"), runOpts.face = opts.face; end
    if isfield(opts, "pt"), runOpts.pt = opts.pt; end
    if isfield(opts, "rgb"), runOpts.rgb = opts.rgb; end
    format_all_runs_(tf, runOpts);
    if isfield(opts, "bodyInsets") && opts.bodyInsets
        apply_body_pr_insets_(tf);
    end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "shape")
        tf.auto_size = AS.SHAPE_TO_FIT_TEXT;
    elseif isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
    try, tf.word_wrap = true; catch, end
end

function style_body_(tf, rows, opts)
    %STYLE_BODY_  Multi-paragraph body AFTER box has been set (if needed).
    % rows: N x 3 {text, level, pt|[]}
    % opts: face, listProps, spacing, fontScale, lnSpcReduction, autofit
    %   autofit: "norm" (default) | "none" | "shape"
    % ORDER: fill → list para props (indent/spc/bu) → face → bodyPr → autofit
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    fill_bullets_(tf, rows);
    useList = (isfield(opts, "listProps") && opts.listProps) || ...
              (isfield(opts, "spacing") && opts.spacing) || ...
              (isfield(opts, "bullets") && opts.bullets);
    if useList
        apply_list_para_props_(tf, true);
    end
    if isfield(opts, "face") && ~isempty(opts.face)
        format_all_runs_(tf, struct("face", opts.face));
    end
    if isfield(opts, "bodyInsets") && opts.bodyInsets
        apply_body_pr_insets_(tf);
    end
    try, tf.word_wrap = true; catch, end
    % Autofit last (after word_wrap, which also touches bodyPr)
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    elseif isfield(opts, "autofit") && strcmpi(string(opts.autofit), "shape")
        tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
    else
        apply_norm_autofit_(tf, opts);
    end
end

function apply_norm_autofit_(tf, opts)
    %APPLY_NORM_AUTOFIT_  TEXT_TO_FIT_SHAPE + optional fontScale / lnSpcReduction.
    % Source freezes these on a:normAutofit so rendered size matches (e.g. 28 pt
    % with fontScale=92500 ≈ 25.9 pt visual; 24 pt * 0.85 = 20.4 pt visual).
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 2, opts = struct(); end
    tf.auto_size = AS.TEXT_TO_FIT_SHAPE;
    hasScale = isfield(opts, "fontScale") && ~isempty(opts.fontScale);
    hasLn = isfield(opts, "lnSpcReduction") && ~isempty(opts.lnSpcReduction);
    if ~hasScale && ~hasLn
        return
    end
    txBody = tf.element();  % p:txBody
    bodyPr = [];
    kids = txBody.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "bodyPr")
            bodyPr = kids{i}; break
        end
    end
    if isempty(bodyPr), return; end
    na = [];
    bk = bodyPr.getchildren();
    for i = 1:numel(bk)
        if strcmp(char(bk{i}.localName()), "normAutofit")
            na = bk{i}; break
        end
    end
    if isempty(na)
        na = mat2ppt.oxml.OxmlElement("a:normAutofit");
        bodyPr.append(na);
    end
    if hasScale
        na.set("fontScale", char(string(int64(opts.fontScale))));
    end
    if hasLn
        na.set("lnSpcReduction", char(string(int64(opts.lnSpcReduction))));
    end
end

function fill_bullets_(tf, rows)
    tf.clear();
    ps = tf.paragraphs();
    for i = 1:size(rows, 1)
        txt = rows{i, 1};
        if iscell(txt) || (isstring(txt) && numel(txt) > 1)
            txt = strjoin(string(txt), "");
        end
        lvl = rows{i, 2};
        pt = rows{i, 3};
        if i == 1
            p = ps{1};
        else
            p = tf.add_paragraph();
        end
        p.text = char(string(txt));
        p.level = lvl;
        if ~isempty(pt)
            format_para_runs_(p, struct("pt", pt));
        end
    end
end

function fill_artist_sidebar_(tf, lines)
    % Source sidebar: lstStyle 20 pt Georgia, accent1 bullets, hanging indent,
    % lnSpc 120%, spcBef 10 pt, bodyPr insets + anchor=t. Soft-break dimensions.
    try, tf.word_wrap = true; catch, end
    tf.clear();
    ps = tf.paragraphs();
    for i = 1:numel(lines)
        if i == 1, p = ps{1}; else, p = tf.add_paragraph(); end
        p.text = char(string(lines{i}));
        p.level = 0;
        format_para_runs_(p, struct("face", "Georgia", "pt", 20));
    end
    apply_list_para_props_(tf, true);
    apply_body_pr_insets_(tf);
    apply_norm_autofit_(tf, struct());
end

function set_mixed_title_(tf, rows)
    % rows: N x 2 {lineText, ptSize|[]} — one paragraph, soft breaks, per-run size.
    % Empty ptSize ⇒ inherit layout/master (source line 1 has no rPr@sz).
    tf.clear();
    ps = tf.paragraphs();
    p = ps{1};
    p.clear_content();
    for i = 1:size(rows, 1)
        if i > 1
            el = p.element();
            el.append(mat2ppt.oxml.OxmlElement("a:br"));
        end
        r = p.add_run();
        r.text = char(string(rows{i, 1}));
        opts = struct();
        if ~isempty(rows{i, 2})
            opts.pt = rows{i, 2};
        end
        format_one_run_(r, opts);
    end
end

function format_all_runs_(tf, opts)
    %UNIFORM run formatting for every run in a text frame.
    % opts fields (all optional): face (string), pt (double), rgb ([R G B] 0-255)
    % Order applied: size attr → solidFill color → latin face (OOXML child order).
    % NOTE: build opts with cell for vectors so struct() does not expand:
    %   struct("face","Georgia","pt",18,"rgb",{[255 192 0]})
    opts = normalize_fmt_opts_(opts);
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        format_para_runs_(ps{pi}, opts);
    end
end

function format_para_runs_(p, opts)
    opts = normalize_fmt_opts_(opts);
    rs = p.runs();
    for ri = 1:numel(rs)
        format_one_run_(rs{ri}, opts);
    end
end

function opts = normalize_fmt_opts_(opts)
    % Collapse MATLAB struct-expansion (vector values → struct array) and cells.
    if numel(opts) > 1
        % e.g. struct("rgb",[255 192 0]) became 1x3 — rebuild scalars
        base = opts(1);
        if isfield(base, "rgb")
            rgb = [opts.rgb];
            base.rgb = rgb(:).';
        end
        opts = base;
    end
    if isfield(opts, "rgb") && iscell(opts.rgb)
        opts.rgb = opts.rgb{1};
    end
    if isfield(opts, "face") && iscell(opts.face)
        opts.face = opts.face{1};
    end
    if isfield(opts, "pt") && iscell(opts.pt)
        opts.pt = opts.pt{1};
    end
end

function format_one_run_(r, opts)
    % Single-run policy so titles, bullets, quotes share one code path.
    opts = normalize_fmt_opts_(opts);
    Pt = @mat2ppt.util.Pt;
    f = r.font();
    % 1) size is an attribute — safe any time
    if isfield(opts, "pt") && ~isempty(opts.pt)
        f.size = Pt(double(opts.pt));
    end
    % 2) color → solidFill (must precede latin in rPr)
    if isfield(opts, "rgb") && ~isempty(opts.rgb)
        rgb = double(opts.rgb);
        f.color().rgb = mat2ppt.dml.RGBColor(rgb(1), rgb(2), rgb(3));
    end
    % 3) face → a:latin (after solidFill)
    if isfield(opts, "face") && ~isempty(opts.face)
        try, f.name = string(opts.face); catch, end
    end
end

function set_shape_box_(shapeObj, L, T, W, H)
    % Force slide-level a:xfrm when source overrides layout geometry.
    % Write proper a:off + a:ext (BaseShape setters can mis-place attrs on empty xfrm).
    EMU = 914400;
    x = round(L * EMU); y = round(T * EMU);
    cx = round(W * EMU); cy = round(H * EMU);
    sp = shapeObj.shape_element();
    spPr = sp.find("p:spPr");
    if isempty(spPr)
        kids = sp.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "spPr")
                spPr = kids{i}; break
            end
        end
    end
    if isempty(spPr)
        spPr = mat2ppt.oxml.shapes.ensure_spPr(sp);
    end
    % remove old xfrm
    kids = spPr.getchildren();
    for i = numel(kids):-1:1
        if strcmp(char(kids{i}.localName()), "xfrm")
            spPr.remove(kids{i});
        end
    end
    xfrm = mat2ppt.oxml.OxmlElement("a:xfrm");
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(x)));
    off.set("y", char(string(y)));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(cx)));
    ext.set("cy", char(string(cy)));
    xfrm.append(off);
    xfrm.append(ext);
    spPr.append(xfrm);
end

function pPr = ensure_pPr_(p)
    el = p.element();
    pPr = el.find("a:pPr");
    if ~isempty(pPr), return; end
    kids = el.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "pPr")
            pPr = kids{i}; return
        end
    end
    pPr = mat2ppt.oxml.OxmlElement("a:pPr");
    % prepend
    for i = 1:numel(kids)
        el.remove(kids{i});
    end
    el.append(pPr);
    for i = 1:numel(kids)
        el.append(kids{i});
    end
end

function clear_bu_kids_(pPr)
    kids = pPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if startsWith(string(ln), "bu")
            pPr.remove(kids{i});
        end
    end
end

function apply_no_bullet_all_(tf)
    ps = tf.paragraphs();
    for i = 1:numel(ps)
        pPr = ensure_pPr_(ps{i});
        clear_bu_kids_(pPr);
        pPr.append(mat2ppt.oxml.OxmlElement("a:buNone"));
    end
end

function apply_bullet_all_(tf, on)
    % Gallery master uses a:buClr schemeClr=accent1 (wine #B71E42), not black.
    if ~on
        apply_no_bullet_all_(tf); return
    end
    apply_list_para_props_(tf, true);
end

function apply_list_spacing_(tf)
    apply_list_para_props_(tf, true);
end

function apply_list_para_props_(tf, withBullets)
    %APPLY_LIST_PARA_PROPS_  Source free-shape lstStyle → per-paragraph pPr.
    % Matches Gallery list geometry on slides 3/6/7:
    %   lvl0: marL=228600 indent=-228600 spcBef=10pt
    %   lvl1: marL=685800 indent=-228600 spcBef=5pt
    %   lvl2: marL=1143000 indent=-228600 spcBef=5pt
    %   all:  lnSpc 120%, accent1 bullet, Arial buFont
    if nargin < 2, withBullets = true; end
    % marL by 0-based level (EMU)
    marL = [228600, 685800, 1143000, 1600200, 2057400, 2514600, 2971800, 3429000, 3886200];
    indent = -228600;
    ps = tf.paragraphs();
    for i = 1:numel(ps)
        p = ps{i};
        pPr = ensure_pPr_(p);
        lvl = double(p.level);
        if lvl < 0, lvl = 0; end
        if lvl > 8, lvl = 8; end
        pPr.set("marL", char(string(marL(lvl + 1))));
        pPr.set("indent", char(string(indent)));
        pPr.set("algn", "l");
        % strip old spacing / bullets
        kids = pPr.getchildren();
        for k = numel(kids):-1:1
            ln = char(kids{k}.localName());
            if any(strcmp(ln, {"lnSpc", "spcBef", "spcAft"})) || startsWith(string(ln), "bu")
                pPr.remove(kids{k});
            end
        end
        lnSpc = mat2ppt.oxml.OxmlElement("a:lnSpc");
        spcPct = mat2ppt.oxml.OxmlElement("a:spcPct");
        spcPct.set("val", "120000");
        lnSpc.append(spcPct);
        pPr.append(lnSpc);
        spcBef = mat2ppt.oxml.OxmlElement("a:spcBef");
        spcPts = mat2ppt.oxml.OxmlElement("a:spcPts");
        if lvl >= 1
            spcPts.set("val", "500");
        else
            spcPts.set("val", "1000");
        end
        spcBef.append(spcPts);
        pPr.append(spcBef);
        if withBullets
            buClr = mat2ppt.oxml.OxmlElement("a:buClr");
            sch = mat2ppt.oxml.OxmlElement("a:schemeClr");
            sch.set("val", "accent1");
            buClr.append(sch);
            pPr.append(buClr);
            buSz = mat2ppt.oxml.OxmlElement("a:buSzPct");
            buSz.set("val", "100000");
            pPr.append(buSz);
            buFont = mat2ppt.oxml.OxmlElement("a:buFont");
            buFont.set("typeface", "Arial");
            pPr.append(buFont);
            buChar = mat2ppt.oxml.OxmlElement("a:buChar");
            buChar.set("char", char(8226));
            pPr.append(buChar);
        else
            pPr.append(mat2ppt.oxml.OxmlElement("a:buNone"));
        end
    end
end

function apply_body_pr_insets_(tf)
    %APPLY_BODY_PR_INSETS_  Source free-shape bodyPr: 0.1" L/R, 0.05" T/B, anchor=t.
    txBody = tf.element();
    bodyPr = find_or_make_body_pr_(txBody);
    bodyPr.set("vert", "horz");
    bodyPr.set("lIns", "91440");
    bodyPr.set("tIns", "45720");
    bodyPr.set("rIns", "91440");
    bodyPr.set("bIns", "45720");
    bodyPr.set("rtlCol", "0");
    bodyPr.set("anchor", "t");
end

function apply_no_autofit_(tf)
    %APPLY_NO_AUTOFIT_  Match source slides 4–5: bodyPr with no autofit child.
    % Do not use MSO_AUTO_SIZE.NONE (that injects a:noAutofit).
    txBody = tf.element();
    bodyPr = find_or_make_body_pr_(txBody);
    kids = bodyPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"noAutofit", "normAutofit", "spAutoFit"}))
            bodyPr.remove(kids{i});
        end
    end
end

function bodyPr = find_or_make_body_pr_(txBody)
    bodyPr = [];
    kids = txBody.getchildren();
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "bodyPr")
            bodyPr = kids{i}; return
        end
    end
    bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
    % prepend bodyPr (OOXML order: bodyPr, lstStyle, p...)
    for i = 1:numel(kids)
        txBody.remove(kids{i});
    end
    txBody.append(bodyPr);
    for i = 1:numel(kids)
        txBody.append(kids{i});
    end
end

function remove_shape_at_(sh, idx)
    el = sh.item(idx).shape_element();
    par = el.getparent();
    if ~isempty(par), par.remove(el); end
    sh.rebuild_items_public_();
end

function send_to_back_(sh, shapeObj)
    el = shapeObj.shape_element();
    par = el.getparent();
    if isempty(par), return; end
    par.remove(el);
    kids = par.getchildren();
    insertIdx = numel(kids) + 1;
    for i = 1:numel(kids)
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"sp", "pic", "cxnSp", "graphicFrame", "grpSp"}))
            insertIdx = i; break
        end
    end
    par.insert(insertIdx, el);
    sh.rebuild_items_public_();
end
