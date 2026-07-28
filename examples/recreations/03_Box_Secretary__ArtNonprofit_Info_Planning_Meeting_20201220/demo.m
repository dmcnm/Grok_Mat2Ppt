%% demo.m — 03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220 (per-text-box fingerprints)
% Skills: mat2ppt-font-paragraph-audit (every text box),
%         mat2ppt-slide-templates, mat2ppt-bullet-autofit, mat2ppt-image-place-crop
% Extract: extracted/text_fingerprints.json

here = fileparts(mfilename("fullpath"));
addpath(fullfile(here, "..", "..", ".."));
outPath = fullfile(here, "out_mat2ppt.pptx");
assets = fullfile(here, "assets");
tpl = fullfile(here, "source_template.pptx");
if ~isfile(tpl)
    error("mat2ppt:MissingTemplate", "Missing source_template.pptx");
end
In = @mat2ppt.util.Inches;
prs = mat2ppt.Presentation(tpl);
layouts = prs.slide_layouts();
lay_Title_Slide = layouts.get_by_name("Title Slide");
lay_Title_and_Content = layouts.get_by_name("Title and Content");
lay_Title_Only = layouts.get_by_name("Title Only");

%% ===== Slide 1 · Title Slide =====
s = prs.slides().add_slide(lay_Title_Slide);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Art Non-profit'});

tf = sh.item(2).text_frame();
tf.clear();
ps = tf.paragraphs();
ps{1}.text = 'Informational and Planning Meeting';
ps{1}.level = 0;
p = tf.add_paragraph();
p.text = 'December 20, 2020';
p.level = 0;
apply_no_bullet_all_(tf);
apply_norm_autofit_(tf, struct());

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Overview'});

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.2388, 11.5, 5.0869);
style_body_(body.text_frame(), { ...
    'Summary of Current Project and Status', 0, []; ...
    'Overview of Potential Non-profit Purpose and Goals', 0, []; ...
    'Survey of Participants and Potential Next Steps', 0, [] ...
    }, ...
    struct("listProps", false));

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Holy Child Project Overview'}, struct("pt", 36));

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.2692, 11.5, 5.0565);
style_body_(body.text_frame(), { ...
    'Mother Seton Hall art schema finished', 0, []; ...
    'Five main hallway sections, plus intro, closing, and side hallways', 1, []; ...
    'Focus is on reproductions of masterpiece paintings and will not include photos of statues and other architecture', 1, []; ...
    'Each main section to cover an era of history', 1, []; ...
    'Also looking to highlight art history', 2, []; ...
    'Intro section complete', 0, []; ...
    '10 paintings for just over $10k', 1, []; ...
    'Modern Era Funding Promised ? Currently in RFQ Stage', 0, []; ...
    'Two pieces awaiting final down select', 1, []; ...
    '15 paintings for $10.5k-14k', 1, []; ...
    'Fundraising and final selection remains for following sections', 0, []; ...
    'Cradle of Civilization and OT', 1, []; ...
    'Greece and Rome', 1, []; ...
    'Paschal Mystery', 1, []; ...
    'Early Church to Medieval Era', 1, []; ...
    'Estimated Costs remaining: ~40 paintings for $35k plus lighting', 0, []; ...
    'Planning not yet begun for Blessed Miguel Pro Hall', 0, [] ...
    }, ...
    struct("listProps", false, "fontScale", 62500, "lnSpcReduction", 20000));

% Fingerprint: free rect, noFill; text 40pt bold, solidFill scheme accent5, algn=ctr, spAutoFit + insets
tb = sh.add_textbox(In(8.7451), In(2.8281), In(4.5882), In(2.1205));
style_textbox_(tb.text_frame(), 'Mother Seton Hall Nearly 1/3 Complete!!!', ...
    struct("bullets", false, "pt", 40, "bold", true, "scheme", "accent5", ...
           "align", "ctr", "bodyInsets", true, "autofit", "shape"));

%% ===== Slide 4 · Title and Content =====
% Fingerprint: body ph legend (not free tb) — listProps false, fontScale 92500, lnSpcReduction 10000
% per-run colors: Completed srgb 00B050, In-progress srgb 7030A0, Planning Stages scheme accent2
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Mother Seton Hall Art Schema'}, struct("autofit", "none"));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.173);

body = sh.item(2);
set_shape_box_(body, 1.571, 5.2128, 3.1311, 1.5142);
style_body_(body.text_frame(), { ...
    'Completed', 0, []; ...
    'In-progress', 0, []; ...
    'Planning Stages', 0, [] ...
    }, ...
    struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 10000));
ps = body.text_frame().paragraphs();
if numel(ps) >= 1, format_para_runs_(ps{1}, struct("rgb", {[0,176,80]})); end
if numel(ps) >= 2, format_para_runs_(ps{2}, struct("rgb", {[112,48,160]})); end
if numel(ps) >= 3, format_para_runs_(ps{3}, struct("scheme", "accent2")); end

p = add_pic_(sh, assets, 'image4.png', 0.7736, 1.2641, 10.8753, 4.0312);
if ~isempty(p), p.crop_right = 0.01414; end

cxn = sh.add_connector('line', In(0.9362), In(3.4953), In(2.8404), In(3.4953));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(3.1809), In(3.5273), In(5.8317), In(3.5273));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(0.9362), In(3.0131), In(2.8404), In(3.0131));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(0.9362), In(4.4031), In(1.7979), In(4.4031));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(0.9574), In(3.4953), In(0.9574), In(4.3772));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(5.8317), In(3.6514), In(6.2893), In(3.6514));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(3.1809), In(3.0368), In(5.8317), In(3.0368));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(6.1879), In(3.0368), In(8.5957), In(3.0368));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(6.6348), In(3.4967), In(8.5745), In(3.4967));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(8.9291), In(3.506), In(11.3085), In(3.506));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(8.9291), In(3.0368), In(10.2553), In(3.0368));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(6.656), In(3.4953), In(6.656), In(4.0782));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(6.1915), In(2.4302), In(6.1915), In(2.8404));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(5.8743), In(2.4539), In(5.8743), In(3.0368));
try, cxn.set_tail_end("none"); catch, end
cxn = sh.add_connector('line', In(6.2893), In(3.6514), In(6.2893), In(3.8626));
try, cxn.set_tail_end("none"); catch, end

%% ===== Slide 5 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Non-profit Purposes', 'Asset Protection'}, struct("pt", 36));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.2487);

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.625, 12.3934, 4.7007);
style_body_(body.text_frame(), { ...
    'Asset protection is critical to fundraising in parishes/dioceses where future friendliness toward classical education and great art is in question', 0, []; ...
    'Barbarian bishops and modernist priests have destroyed much church art and sold off numerous assets to pay abuse settlements', 1, []; ...
    'Most people have stories of friends/family saving church art from literal dumpsters', 1, []; ...
    'Non-profit can hold assets in trust and give them away to other schools if unfriendly powers take control and want to dispose of the art', 1, [] ...
    }, ...
    struct("listProps", false));

%% ===== Slide 6 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Non-profit Purposes', 'Project and Concept Promotion'}, struct("pt", 36));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.2487);

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.625, 12.3934, 4.7007);
style_body_(body.text_frame(), { ...
    'Holy Child is pioneering something new', 0, []; ...
    'Never before have modern printing methods been combined with the ever-growing library of high resolution photos of museum paintings to bring the best masterpiece paintings in the western canon to schools', 1, []; ...
    'The classical school movement is rapidly expanding and pioneering new ways to bring the a traditional education to the modern world', 0, []; ...
    'Many schools would likely be interested if they could see this project', 1, []; ...
    'Ways to promote concept', 0, []; ...
    'Speak at educational conferences', 1, []; ...
    'News coverage', 1, []; ...
    'Publishing in academic journals and educational magazines', 1, []; ...
    'Partnerships with local art museums', 1, []; ...
    'Partnerships with other schools', 1, [] ...
    }, ...
    struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 20000));

%% ===== Slide 7 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Non-profit Purposes', 'Connecting School Communities and Museums'}, struct("pt", 36));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.2487);

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.25, 12.3934, 5.0757);
style_body_(body.text_frame(), { ...
    'Reproductions shouldn''t be the only art children see', 0, []; ...
    'Most masterpiece paintings live in museums', 1, []; ...
    'Traveling exhibits bring masterpieces to even smaller cities like Albuquerque', 1, []; ...
    'Reserving a section of wall to display the best of local art museums would encourage families to visit', 0, []; ...
    'Requires working with museum staff to acquire rights and select pieces for display', 1, []; ...
    'Provides visibility of museum exhibits to school families', 1, []; ...
    'Provides visibility of school in the wider community', 1, []; ...
    'Win-win for families, museum, and school', 0, []; ...
    'Strong partnerships generate opportunity for positive media interest and coverage', 0, []; ...
    'Museum staff will likely lead this effort', 1, [] ...
    }, ...
    struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 10000));

%% ===== Slide 8 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Non-profit Purposes', 'Connecting Likeminded School Communities'}, struct("pt", 36));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.2487);

body = sh.item(2);
set_shape_box_(body, 0.5393, 1.25, 12.3934, 5.0757);
style_body_(body.text_frame(), { ...
    'Serve as central resource to connect classical schools that want to implement this idea', 0, []; ...
    'Provide planning and logistical support to schools lacking expertise', 0, []; ...
    'Can help schools with planning and piece selection', 1, []; ...
    'Holy Child has already looked at thousands of paintings and has presentations with hundreds of potential candidates', 2, []; ...
    'Provide logistical support to schools', 1, []; ...
    'Connect with Duraplaq and Derek Brooks', 2, []; ...
    'Develop connections to companies in other parts of  the country/world as time progresses', 2, []; ...
    'Provide support to schools looking to circulate loaned paintings', 0, []; ...
    'Similar to how most museums have traveling exhibits', 1, []; ...
    'Help connect schools with their local art community', 0, [] ...
    }, ...
    struct("listProps", false, "lnSpcReduction", 10000));

%% ===== Slide 9 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Starting a Non-profit'}, struct("pt", 36));
set_shape_box_(sh.item(1), 0.5393, 0.0013, 11.5, 1.2102);

body = sh.item(2);
set_shape_box_(body, 0.6154, 1.2933, 6.0513, 4.8798);
style_body_(body.text_frame(), { ...
    'Decide on purpose for organization and general goals', 0, []; ...
    'Feedback - Disagreement on goals in previous slides or other ideas?', 1, []; ...
    'Select board model', 0, []; ...
    'Recruit and vote on transition board members (with future in mind)', 0, []; ...
    'Highlight business/non-profit experience, time, motivation, and art expertise', 1, []; ...
    'Avoid conflicts of interest', 1, []; ...
    'Decide on committees - both business and art related', 1, []; ...
    'Vote on a name', 0, [] ...
    }, ...
    struct("listProps", false, "fontScale", 92500, "lnSpcReduction", 20000));

tb = sh.add_textbox(In(6.5321), In(1.7051), In(6.7083), In(4.8798));
style_body_(tb.text_frame(), { ...
    'Set board meeting dates for regular meetings', 0, []; ...
    'Set due dates and goals for tasks', 1, []; ...
    'Write Articles of Incorporation and Bylaws', 0, []; ...
    'Select annual meeting date (mostly set in stone)', 1, []; ...
    'Formally vote on board members', 1, []; ...
    'Work with volunteer legal help to', 0, []; ...
    'Submit paperwork to state of NM', 1, []; ...
    'Submit paperwork to IRS', 1, []; ...
    'Get training for IRS paperwork and business aspects of tax deductibility', 0, []; ...
    'Prioritize art-related projects and get to work', 0, []; ...
    'Can''t do everything at once — figure out projects with high impact and low difficulty to begin', 1, [] ...
    }, ...
    struct("listProps", false, "injectLstStyle", true, "bodyInsets", true, "fontScale", 85000, "lnSpcReduction", 10000));

%% ===== Slide 10 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Questions and Feedback'}, struct("autofit", "none", "align", "ctr"));
set_shape_box_(sh.item(1), 0.0, 3.2321, 13.3333, 1.4497);

try, remove_shape_at_(sh, 2); catch, end

try, remove_shape_at_(sh, 2); catch, end

%% ===== Slide 11 · Title and Content =====
% Fingerprint: empty body placeholder present (no text); keep ph, no autofit
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();

style_title_(sh.item(1).text_frame(), {'Resources'}, struct("autofit", "none"));
body = sh.item(2);
body.text_frame().clear();
apply_no_autofit_(body.text_frame());

prs.save(outPath);
fprintf("Wrote %s (fingerprint-driven)\n", outPath);


%% ===================== fidelity helpers (per-shape fingerprints) =====================

function style_title_(tf, lines, opts)
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    if isstring(lines), lines = cellstr(lines); end
    if ischar(lines), lines = {lines}; end
    rows = cell(numel(lines), 2);
    for i = 1:numel(lines)
        rows{i, 1} = lines{i};
        rows{i, 2} = [];
        if isfield(opts, "pt") && ~isempty(opts.pt)
            rows{i, 2} = opts.pt;
        end
    end
    set_mixed_title_(tf, rows);
    if isfield(opts, "align") && ~isempty(opts.align)
        set_para_align_(tf, opts.align);
    end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function style_body_(tf, rows, opts)
    % listProps: false = levels only (placeholder inherit)
    % injectLstStyle: true = free shape with source lstStyle
    if nargin < 3, opts = struct(); end
    opts = normalize_fmt_opts_(opts);
    fill_bullets_(tf, rows);
    if isfield(opts, "listProps") && opts.listProps
        apply_list_para_props_(tf, true);
    end
    if isfield(opts, "injectLstStyle") && opts.injectLstStyle
        inject_office_body_lst_style_(tf);
    end
    if isfield(opts, "face") && ~isempty(opts.face)
        format_all_runs_(tf, struct("face", opts.face));
    end
    if isfield(opts, "pt") && ~isempty(opts.pt)
        format_all_runs_(tf, struct("pt", opts.pt));
    end
    if isfield(opts, "bodyInsets") && opts.bodyInsets
        apply_body_pr_insets_(tf);
    end
    try, tf.word_wrap = true; catch, end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    elseif isfield(opts, "autofit") && strcmpi(string(opts.autofit), "shape")
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
        if isfield(opts, "softBreak") && opts.softBreak
            rows = cell(numel(text), 2);
            for i = 1:numel(text)
                rows{i,1} = text{i};
                rows{i,2} = [];
                if isfield(opts, "pt"), rows{i,2} = opts.pt; end
            end
            set_mixed_title_(tf, rows);
        else
            tf.clear();
            ps = tf.paragraphs();
            for i = 1:numel(text)
                if i == 1, p = ps{1}; else, p = tf.add_paragraph(); end
                p.text = char(string(text{i}));
                p.level = 0;
            end
        end
    else
        tf.text = char(string(text));
    end
    if isfield(opts, "listProps") && opts.listProps
        apply_list_para_props_(tf, true);
    elseif isfield(opts, "bullets") && ~isempty(opts.bullets) && ~opts.bullets
        apply_no_bullet_all_(tf);
    end
    runOpts = struct();
    if isfield(opts, "face"), runOpts.face = opts.face; end
    if isfield(opts, "pt"), runOpts.pt = opts.pt; end
    if isfield(opts, "rgb"), runOpts.rgb = opts.rgb; end
    if isfield(opts, "scheme"), runOpts.scheme = opts.scheme; end
    if isfield(opts, "bold") && opts.bold, runOpts.bold = true; end
    format_all_runs_(tf, runOpts);
    if isfield(opts, "align") && ~isempty(opts.align)
        set_para_align_(tf, opts.align);
    end
    if isfield(opts, "bodyInsets") && opts.bodyInsets
        apply_body_pr_insets_(tf);
    end
    try, tf.word_wrap = true; catch, end
    if isfield(opts, "autofit") && strcmpi(string(opts.autofit), "shape")
        tf.auto_size = AS.SHAPE_TO_FIT_TEXT;
    elseif isfield(opts, "autofit") && strcmpi(string(opts.autofit), "none")
        apply_no_autofit_(tf);
    else
        apply_norm_autofit_(tf, opts);
    end
end

function set_mixed_title_(tf, rows)
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
        if ~isempty(rows{i, 2}), opts.pt = rows{i, 2}; end
        format_one_run_(r, opts);
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
        if i == 1, p = ps{1}; else, p = tf.add_paragraph(); end
        p.text = char(string(txt));
        p.level = lvl;
        if ~isempty(pt)
            format_para_runs_(p, struct("pt", pt));
        end
    end
end

function format_all_runs_(tf, opts)
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

function format_one_run_(r, opts)
    opts = normalize_fmt_opts_(opts);
    Pt = @mat2ppt.util.Pt;
    f = r.font();
    if isfield(opts, "pt") && ~isempty(opts.pt)
        f.size = Pt(double(opts.pt));
    end
    if isfield(opts, "bold") && ~isempty(opts.bold)
        try, f.bold = logical(opts.bold); catch, end
    end
    % Color before face (rPr child order: solidFill then latin)
    if isfield(opts, "scheme") && ~isempty(opts.scheme)
        try
            f.color().theme_color = mat2ppt.enum.MSO_THEME_COLOR.from_xml(char(string(opts.scheme)));
        catch
        end
    elseif isfield(opts, "rgb") && ~isempty(opts.rgb)
        rgb = double(opts.rgb);
        f.color().rgb = mat2ppt.dml.RGBColor(rgb(1), rgb(2), rgb(3));
    end
    if isfield(opts, "face") && ~isempty(opts.face)
        try, f.name = string(opts.face); catch, end
    end
end

function opts = normalize_fmt_opts_(opts)
    if isempty(opts), opts = struct(); return; end
    if numel(opts) > 1
        base = opts(1);
        if isfield(base, "rgb")
            rgb = [opts.rgb];
            base.rgb = rgb(:).';
        end
        opts = base;
    end
    if isfield(opts, "rgb") && iscell(opts.rgb), opts.rgb = opts.rgb{1}; end
    if isfield(opts, "face") && iscell(opts.face), opts.face = opts.face{1}; end
    if isfield(opts, "scheme") && iscell(opts.scheme), opts.scheme = opts.scheme{1}; end
    if isfield(opts, "pt") && iscell(opts.pt), opts.pt = opts.pt{1}; end
end

function set_para_align_(tf, algn)
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        p = ps{pi};
        try
            if strcmpi(algn, "ctr")
                p.alignment = mat2ppt.enum.PP_ALIGN.CENTER;
                continue
            end
        catch
        end
        el = p.element();
        pPr = el.find("a:pPr");
        if isempty(pPr)
            kids = el.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "pPr"), pPr = kids{i}; break; end
            end
        end
        if isempty(pPr)
            pPr = mat2ppt.oxml.OxmlElement("a:pPr");
            kids = el.getchildren();
            for i = 1:numel(kids), el.remove(kids{i}); end
            el.append(pPr);
            for i = 1:numel(kids), el.append(kids{i}); end
        end
        pPr.set("algn", char(string(algn)));
    end
end

function apply_norm_autofit_(tf, opts)
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    if nargin < 2, opts = struct(); end
    tf.auto_size = AS.TEXT_TO_FIT_SHAPE;
    hasScale = isfield(opts, "fontScale") && ~isempty(opts.fontScale);
    hasLn = isfield(opts, "lnSpcReduction") && ~isempty(opts.lnSpcReduction);
    if ~hasScale && ~hasLn, return; end
    bodyPr = find_or_make_body_pr_(tf.element());
    na = [];
    bk = bodyPr.getchildren();
    for i = 1:numel(bk)
        if strcmp(char(bk{i}.localName()), "normAutofit"), na = bk{i}; break; end
    end
    if isempty(na)
        na = mat2ppt.oxml.OxmlElement("a:normAutofit");
        bodyPr.append(na);
    end
    if hasScale, na.set("fontScale", char(string(int64(opts.fontScale)))); end
    if hasLn, na.set("lnSpcReduction", char(string(int64(opts.lnSpcReduction)))); end
end

function apply_no_autofit_(tf)
    bodyPr = find_or_make_body_pr_(tf.element());
    kids = bodyPr.getchildren();
    for i = numel(kids):-1:1
        ln = char(kids{i}.localName());
        if any(strcmp(ln, {"noAutofit", "normAutofit", "spAutoFit"}))
            bodyPr.remove(kids{i});
        end
    end
end

function apply_list_para_props_(tf, withBullets)
    if nargin < 2, withBullets = true; end
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
        kids = pPr.getchildren();
        for k = numel(kids):-1:1
            ln = char(kids{k}.localName());
            if any(strcmp(ln, {"lnSpc", "spcBef", "spcAft"})) || startsWith(string(ln), "bu")
                pPr.remove(kids{k});
            end
        end
        lnSpc = mat2ppt.oxml.OxmlElement("a:lnSpc");
        spcPct = mat2ppt.oxml.OxmlElement("a:spcPct");
        spcPct.set("val", "90000");
        lnSpc.append(spcPct);
        pPr.append(lnSpc);
        spcBef = mat2ppt.oxml.OxmlElement("a:spcBef");
        spcPts = mat2ppt.oxml.OxmlElement("a:spcPts");
        if lvl >= 1, spcPts.set("val", "500"); else, spcPts.set("val", "1000"); end
        spcBef.append(spcPts);
        pPr.append(spcBef);
        if withBullets
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

function apply_no_bullet_all_(tf)
    ps = tf.paragraphs();
    for i = 1:numel(ps)
        pPr = ensure_pPr_(ps{i});
        kids = pPr.getchildren();
        for k = numel(kids):-1:1
            if startsWith(string(kids{k}.localName()), "bu"), pPr.remove(kids{k}); end
        end
        pPr.append(mat2ppt.oxml.OxmlElement("a:buNone"));
    end
end

function apply_body_pr_insets_(tf)
    bodyPr = find_or_make_body_pr_(tf.element());
    bodyPr.set("vert", "horz");
    bodyPr.set("lIns", "91440");
    bodyPr.set("tIns", "45720");
    bodyPr.set("rIns", "91440");
    bodyPr.set("bIns", "45720");
    bodyPr.set("rtlCol", "0");
end

function inject_office_body_lst_style_(tf)
    txBody = tf.element();
    kids = txBody.getchildren();
    lst = [];
    for i = 1:numel(kids)
        if strcmp(char(kids{i}.localName()), "lstStyle"), lst = kids{i}; break; end
    end
    if isempty(lst)
        lst = mat2ppt.oxml.OxmlElement("a:lstStyle");
        bodyPr = [];
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "bodyPr"), bodyPr = kids{i}; break; end
        end
        rest = {};
        for i = 1:numel(kids)
            if isempty(bodyPr) || kids{i} ~= bodyPr
                rest{end+1} = kids{i}; %#ok<AGROW>
            end
        end
        for i = 1:numel(kids), txBody.remove(kids{i}); end
        if ~isempty(bodyPr), txBody.append(bodyPr); end
        txBody.append(lst);
        for i = 1:numel(rest), txBody.append(rest{i}); end
    else
        ck = lst.getchildren();
        for i = numel(ck):-1:1, lst.remove(ck{i}); end
    end
    sizes = [2800, 2400, 2000, 1800, 1800, 1800, 1800, 1800, 1800];
    marLs = [228600, 685800, 1143000, 1600200, 2057400, 2514600, 2971800, 3429000, 3886200];
    for li = 1:9
        lvl = mat2ppt.oxml.OxmlElement(sprintf("a:lvl%dpPr", li));
        lvl.set("marL", char(string(marLs(li))));
        lvl.set("indent", "-228600");
        lvl.set("algn", "l");
        lvl.set("defTabSz", "914400");
        lvl.set("rtl", "0");
        lvl.set("eaLnBrk", "1");
        lvl.set("latinLnBrk", "0");
        lvl.set("hangingPunct", "1");
        lnSpc = mat2ppt.oxml.OxmlElement("a:lnSpc");
        spcPct = mat2ppt.oxml.OxmlElement("a:spcPct");
        spcPct.set("val", "90000");
        lnSpc.append(spcPct);
        lvl.append(lnSpc);
        spcBef = mat2ppt.oxml.OxmlElement("a:spcBef");
        spcPts = mat2ppt.oxml.OxmlElement("a:spcPts");
        if li == 1, spcPts.set("val", "1000"); else, spcPts.set("val", "500"); end
        spcBef.append(spcPts);
        lvl.append(spcBef);
        buFont = mat2ppt.oxml.OxmlElement("a:buFont");
        buFont.set("typeface", "Arial");
        lvl.append(buFont);
        buChar = mat2ppt.oxml.OxmlElement("a:buChar");
        buChar.set("char", char(8226));
        lvl.append(buChar);
        defRPr = mat2ppt.oxml.OxmlElement("a:defRPr");
        defRPr.set("sz", char(string(sizes(li))));
        defRPr.set("kern", "1200");
        fill = mat2ppt.oxml.OxmlElement("a:solidFill");
        sch = mat2ppt.oxml.OxmlElement("a:schemeClr");
        sch.set("val", "tx1");
        fill.append(sch);
        defRPr.append(fill);
        lat = mat2ppt.oxml.OxmlElement("a:latin");
        lat.set("typeface", "+mn-lt");
        defRPr.append(lat);
        lvl.append(defRPr);
        lst.append(lvl);
    end
end

function pPr = ensure_pPr_(p)
    el = p.element();
    pPr = el.find("a:pPr");
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
    x = round(L * EMU); y = round(T * EMU);
    cx = round(W * EMU); cy = round(H * EMU);
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
    off = mat2ppt.oxml.OxmlElement("a:off");
    off.set("x", char(string(x))); off.set("y", char(string(y)));
    ext = mat2ppt.oxml.OxmlElement("a:ext");
    ext.set("cx", char(string(cx))); ext.set("cy", char(string(cy)));
    xfrm.append(off); xfrm.append(ext);
    spPr.append(xfrm);
end

function remove_shape_at_(sh, idx)
    el = sh.item(idx).shape_element();
    par = el.getparent();
    if ~isempty(par), par.remove(el); end
    sh.rebuild_items_public_();
end

function pic = add_pic_(sh, assets, name, L, T, W, H)
    In = @mat2ppt.util.Inches;
    img = fullfile(assets, name);
    pic = [];
    if isfile(img)
        pic = sh.add_picture(img, In(L), In(T), In(W), In(H));
    end
end

