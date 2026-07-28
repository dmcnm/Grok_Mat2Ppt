%% demo.m — 18_Dropbox_Poverty_Awareness__Display Board Titles Headers
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

%% ===== Slide 1 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.0, 0.5833);
tf = body.text_frame();
style_body_levels_(tf, { ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.25), In(2.25), In(9.5833), In(1.279));
style_textbox_(tb.text_frame(), 'A Few Children ', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 70, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 70, "bold", true, "cap", 'none')); end
tb = sh.add_textbox(In(0.25), In(3.75), In(9.5833), In(1.279));
style_textbox_(tb.text_frame(), 'Sponsored', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 70, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 70, "bold", true, "cap", 'none')); end
tb = sh.add_textbox(In(0.25), In(5.1667), In(9.5833), In(1.279));
style_textbox_(tb.text_frame(), 'By Parish Members', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 70, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 70, "bold", true, "cap", 'none')); end

%% ===== Slide 2 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.0, 0.5833);
tf = body.text_frame();
style_body_levels_(tf, { ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.1667), In(2.25), In(9.5833), In(1.0266));
style_textbox_(tb.text_frame(), 'A Few Children ', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 55, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 55, "bold", true, "cap", 'none')); end
tb = sh.add_textbox(In(0.25), In(3.75), In(9.5833), In(1.0266));
style_textbox_(tb.text_frame(), 'Sponsored', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 55, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 55, "bold", true, "cap", 'none')); end
tb = sh.add_textbox(In(0.25), In(5.1667), In(9.5833), In(1.0266));
style_textbox_(tb.text_frame(), 'By Parish Members', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 55, "bold", true));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 55, "bold", true, "cap", 'none')); end

%% ===== Slide 3 · Title and Content =====
s = prs.slides().add_slide(lay_Title_and_Content);
sh = s.shapes();
body = sh.item(2);
set_shape_box_(body, 0.5, 1.75, 9.0, 0.5833);
tf = body.text_frame();
style_body_levels_(tf, { ...
    }, struct("listProps", false, "lnSpcReduction", 10000));
ps = tf.paragraphs();
tb = sh.add_textbox(In(0.25), In(2.6667), In(9.5833), In(1.0266));
style_textbox_(tb.text_frame(), 'A Brief Look at Poverty ', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 55, "bold", true, "rgb", [0 176 80]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 55, "bold", true, "cap", 'none', "rgb", [0 176 80])); end
tb = sh.add_textbox(In(0.1667), In(4), In(9.5833), In(1.279));
tf = tb.text_frame(); tf.clear(); ps = tf.paragraphs();
p = ps{1}; p.clear_content(); p.level = 0;
r = p.add_run(); r.text = 'at Poverty';
apply_run_font_fp_(r, struct("pt", 70, "bold", true, "cap", 'none', "rgb", [0 176 80]));
r = p.add_run(); r.text = ' ';
apply_run_font_fp_(r, struct("pt", 55, "bold", true, "cap", 'none', "rgb", [0 176 80]));
set_para_align_one_(p, 'ctr');
apply_no_bullet_all_(tf);
tf.auto_size = mat2ppt.enum.MSO_AUTO_SIZE.SHAPE_TO_FIT_TEXT;
try, tf.word_wrap = true; catch, end
tb = sh.add_textbox(In(0.1667), In(5.5833), In(9.5833), In(1.279));
style_textbox_(tb.text_frame(), 'A Brief Look', struct("bullets", false, "align", 'ctr', "autofit", "shape", "pt", 70, "bold", true, "rgb", [0 176 80]));
ps = tb.text_frame().paragraphs(); rs = ps{1}.runs();
if ~isempty(rs), apply_run_font_fp_(rs{1}, struct("pt", 70, "bold", true, "cap", 'none', "rgb", [0 176 80])); end

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

