%% demo.m — Hand-authored recreation: Dissolution / Distribution of Assets flowchart
% Source: reference_original.pptx (Office-authored flowchart)
%
% Goals for this demo (visual pass, not just structural inventory):
%   1) Human units: Inches (not raw EMU) — slide is 13.33" x 7.50" widescreen
%   2) Font size on every shape (14 pt body / 12 pt Yes-No labels)
%   3) Yes/No as textboxes (noFill) — not styled rectangles with fill
%   4) Theme solid fill via fillRef idx 1 (product default; not gradient idx 3)
%   5) Connector begin/end + flip + adj (path) + triangle tailEnd arrows
%
% Run from MATLAB:
%   cd to this folder, then: demo
% Outputs: out_mat2ppt.pptx next to this script.

here = fileparts(mfilename("fullpath"));
addpath(fullfile(here, "..", "..", ".."));  % Mat2Ppt root
outPath = fullfile(here, "out_mat2ppt.pptx");
tpl = fullfile(here, "source_template.pptx");

In = @mat2ppt.util.Inches;
Pt = @mat2ppt.util.Pt;

% Fidelity: open source package (Office Theme + layouts), not default.pptx
if isfile(tpl)
    prs = mat2ppt.Presentation(tpl);
else
    prs = mat2ppt.Presentation();
    prs.slide_width = In(13.333333);
    prs.slide_height = In(7.5);
end
% Free flowchart on Blank layout (no placeholders).
lay = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(lay);
sh = s.shapes();

%% ===== Decision diamonds (flowChartDecision) — 14 pt white theme text =====
sp = add_flow_(sh, "flowChartDecision", 6.265, 0.145, 2.029, 1.080, ...
    "Are the Assets Artistic?");
sp = add_flow_(sh, "flowChartDecision", 4.047, 0.997, 2.620, 1.110, ...
    "Assets Reside at a School or Nonprofit?");
sp = add_flow_(sh, "flowChartDecision", 1.592, 1.965, 2.850, 1.240, ...
    "School or Nonprofit will Accept Gift of  Artistic Assets?");
sp = add_flow_(sh, "flowChartDecision", 7.913, 1.163, 2.620, 1.110, ...
    "Are Assets Monetary?");
sp = add_flow_(sh, "flowChartDecision", 9.883, 2.052, 2.620, 1.240, ...
    "Was money donated for a specific program?");
sp = add_flow_(sh, "flowChartDecision", 3.150, 2.911, 3.517, 1.609, ...
    "School or non-profit specifies alternate non-profit to receive artistic assets?");

%% ===== Process boxes (flowChartProcess) =====
sp = add_flow_(sh, "flowChartProcess", 0.165, 6.223, 1.650, 1.063, ...
    "A) Artistic Assets gifted to school or non-profit where they reside");
sp = add_flow_(sh, "flowChartProcess", 1.965, 5.840, 1.650, 1.447, ...
    "B) Artistic Assets gifted to non-profit specified by school or non-profit where the asset resides.");
sp = add_flow_(sh, "flowChartProcess", 3.766, 4.930, 2.593, 2.356, ...
    ["C) Artistic assets distributed equally among other affiliate schools ", ...
     "where assets reside (or their specified non-profits).  Receiving schools ", ...
     "must pay for associated packaging and transportation costs beyond what ", ...
     "the St. Luke Guild monetary assets will cover."]);
sp = add_flow_(sh, "flowChartProcess", 6.510, 6.207, 1.793, 1.080, ...
    "E) Non-monetary assets sold and proceeds enter general fund");
sp = add_flow_(sh, "flowChartProcess", 8.453, 6.207, 2.160, 1.080, ...
    "D) Monetary gifts tied to specific programs returned to original donors");
sp = add_flow_(sh, "flowChartProcess", 10.763, 5.840, 2.467, 1.447, ...
    ["F) Remaining monetary assets not used for distributing artistic assets ", ...
     "distributed equally among schools where artistic assets reside"]);

%% ===== Connectors: begin = source, end = destination (arrow at end) =====
% Office originals often store flipV with geom end at the SOURCE and rely on
% a:stCxn/a:endCxn for attachment. Mat2Ppt does not yet wire connection sites,
% so for free-standing connectors we put begin at the upstream shape and end at
% the downstream shape — triangle tailEnd then points the right way.
% bentConnector4 also needs adj gd values or the mid elbow routes wrong.

% 16: Are Assets Monetary? → Was money donated for a specific program?
sh.add_connector("bentConnector2", In(10.533), In(1.718), In(11.193), In(2.052));
% 18: Are Assets Monetary? → E (long vertical)
sh.add_connector("bentConnector2", In(7.913), In(1.718), In(7.406), In(6.207));
% 20: Was money donated? → D
sh.add_connector("bentConnector2", In(9.883), In(2.672), In(9.533), In(6.207));
% 22: Was money donated? No → F (bentConnector4 + adj)
sh.add_connector("bentConnector4", In(12.503), In(2.672), In(11.996), In(5.840), ...
    {"adj1", "val -49334"; "adj2", "val 59784"});
% 24: Are the Assets Artistic? No → Are Assets Monetary?
sh.add_connector("bentConnector2", In(8.293), In(0.685), In(9.223), In(1.163));
% 26: Are the Assets Artistic? Yes → Assets Reside at a School?
sh.add_connector("bentConnector2", In(6.265), In(0.685), In(5.357), In(0.997));
% 28: Accept Gift? Yes → A
sh.add_connector("bentConnector2", In(1.592), In(2.585), In(0.990), In(6.223));
% 31: Alternate non-profit? Yes → B
sh.add_connector("bentConnector2", In(3.150), In(3.716), In(2.790), In(5.840));
% 33: Alternate non-profit? No → C (bentConnector4 + adj)
sh.add_connector("bentConnector4", In(6.667), In(3.716), In(5.062), In(4.930), ...
    {"adj1", "val -15582"; "adj2", "val 83133"});
% 36: Accept Gift? No → Alternate non-profit?
sh.add_connector("bentConnector2", In(4.442), In(2.585), In(4.908), In(2.911));
% 38: Assets Reside? Yes → Accept Gift?
sh.add_connector("bentConnector2", In(4.047), In(1.552), In(3.017), In(1.965));
% 40: Assets Reside? No → toward E/C merge (original has no tailEnd)
sh.add_connector("bentConnector2", In(6.667), In(1.552), In(6.930), In(4.281));

%% ===== Yes / No labels: textboxes (transparent), 12 pt — NOT filled rects =====
% Original: p:cNvSpPr txBox="1" + a:noFill. add_textbox matches that.
% add_shape('rect') applies style fill (solid/gradient) — wrong visually.
add_label_(sh, 5.520, 0.380, 0.580, 0.303, "Yes");
add_label_(sh, 3.235, 1.228, 0.580, 0.303, "Yes");
add_label_(sh, 0.912, 2.296, 0.580, 0.303, "Yes");
add_label_(sh, 2.638, 3.408, 0.580, 0.303, "Yes");
add_label_(sh, 8.377, 0.351, 0.580, 0.303, "No");
add_label_(sh, 7.406, 1.398, 0.580, 0.303, "No");
add_label_(sh, 6.525, 1.274, 0.580, 0.303, "No");
add_label_(sh, 4.353, 2.357, 0.580, 0.303, "No");
add_label_(sh, 6.525, 3.383, 0.580, 0.303, "No");
add_label_(sh, 12.350, 2.368, 0.580, 0.303, "No");

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
fprintf("Slide size: %.3f in x %.3f in (widescreen)\n", 13.333333, 7.5);

%% ----- local helpers (fidelity: size + center paragraph + body anchor) -----
function sp = add_flow_(sh, prst, left, top, width, height, txt)
    In = @mat2ppt.util.Inches;
    Pt = @mat2ppt.util.Pt;
    if iscell(txt) || isstring(txt)
        txt = strjoin(string(txt), "");
    end
    sp = sh.add_shape(prst, In(left), In(top), In(width), In(height));
    tf = sp.text_frame();
    tf.text = char(string(txt));
    try, tf.word_wrap = true; catch, end
    % Source: rPr sz=1400, pPr algn=ctr, bodyPr anchor=ctr
    set_run_font_(tf, Pt(14));
    set_para_align_center_(tf);
    set_body_anchor_ctr_(tf);
end

function add_label_(sh, left, top, width, height, txt)
    In = @mat2ppt.util.Inches;
    Pt = @mat2ppt.util.Pt;
    AS = mat2ppt.enum.MSO_AUTO_SIZE;
    tb = sh.add_textbox(In(left), In(top), In(width), In(height));
    tf = tb.text_frame();
    tf.text = char(string(txt));
    % Source labels: sz=1200, pPr algn=ctr, bodyPr wrap=square + spAutoFit
    set_run_font_(tf, Pt(12));
    set_para_align_center_(tf);
    try, tf.auto_size = AS.SHAPE_TO_FIT_TEXT; catch, end
end

function set_run_font_(tf, sizeLen)
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        runs = ps{pi}.runs();
        for i = 1:numel(runs)
            rf = runs{i}.font();
            rf.size = sizeLen;
        end
    end
end

function set_para_align_center_(tf)
    % Source flowchart text: <a:pPr algn="ctr"/>
    ps = tf.paragraphs();
    for pi = 1:numel(ps)
        p = ps{pi};
        try
            p.alignment = mat2ppt.enum.PP_ALIGN.CENTER;
        catch
            % Fallback: write pPr@algn directly
            el = p.element();
            pPr = el.find("a:pPr");
            if isempty(pPr)
                kids = el.getchildren();
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "pPr")
                        pPr = kids{i}; break
                    end
                end
            end
            if isempty(pPr)
                pPr = mat2ppt.oxml.OxmlElement("a:pPr");
                kids = el.getchildren();
                for i = 1:numel(kids), el.remove(kids{i}); end
                el.append(pPr);
                for i = 1:numel(kids), el.append(kids{i}); end
            end
            pPr.set("algn", "ctr");
        end
    end
end

function set_body_anchor_ctr_(tf)
    % Source diamonds/process: <a:bodyPr rtlCol="0" anchor="ctr"/>
    try
        tf.vertical_anchor = mat2ppt.enum.MSO_VERTICAL_ANCHOR.MIDDLE;
    catch
        txBody = tf.element();
        bodyPr = [];
        kids = txBody.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "bodyPr")
                bodyPr = kids{i}; break
            end
        end
        if isempty(bodyPr)
            bodyPr = mat2ppt.oxml.OxmlElement("a:bodyPr");
            for i = 1:numel(kids), txBody.remove(kids{i}); end
            txBody.append(bodyPr);
            for i = 1:numel(kids), txBody.append(kids{i}); end
        end
        bodyPr.set("anchor", "ctr");
        bodyPr.set("rtlCol", "0");
    end
end
