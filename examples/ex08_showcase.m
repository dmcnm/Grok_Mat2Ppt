%% ex08_showcase — One slide per default layout + query demo
% Covers all 11 layouts on the built-in template. Rocket JPEGs used for pics.
%
% Layout inventory (query the same way as ex00_list_layouts):
%   1 Title Slide | 2 Title and Content | 3 Section Header | 4 Two Content
%   5 Comparison  | 6 Title Only        | 7 Blank          | 8 Content with Caption
%   9 Picture with Caption | 10 Title and Vertical Text | 11 Vertical Title and Text

addpath(fullfile(fileparts(mfilename("fullpath")), ".."));
outDir = fileparts(mfilename("fullpath"));
outPath = fullfile(outDir, "out_ex08_showcase.pptx");

imgLaunch = fullfile(outDir, "rocket_starship_launch.jpg");
if ~isfile(imgLaunch)
    imgLaunch = fullfile(outDir, "20260709_CC_Star10_42_DSC_8953_mobile_c4b1853b3c.jpg");
end
imgStarship = fullfile(outDir, "rocket_starship.jpeg");
if ~isfile(imgStarship)
    imgStarship = fullfile(outDir, "Starship.jpeg");
end

prs = mat2ppt.Presentation();
layouts = prs.slide_layouts();

%% --- Query layouts (prints to command window) ---
fprintf("Available layouts (%d):\n", layouts.length);
for i = 1:layouts.length
    fprintf("  %2d. %s\n", i, char(string(layouts.item(i).name)));
end

%% 1 Title Slide
s = prs.slides().add_slide(layouts.get_by_name("Title Slide"));
s.shapes().item(1).text_frame().text = "Mat2Ppt Examples";
s.shapes().item(2).text_frame().text = "All default slide layouts";

%% 2 Title and Content — standard bullets
s = prs.slides().add_slide(layouts.get_by_name("Title and Content"));
s.shapes().item(1).text_frame().text = "Title and Content (bullets)";
fill_bullets_(s.shapes().item(2).text_frame(), { ...
    "First bullet", 0; ...
    "Nested detail", 1; ...
    "Another top-level bullet", 0});

%% 3 Two Content — left bullets, right rocket photo
% (Matches the layout used in out_ex08_showcase_TwoContentSlide.pptx slide 3)
s = prs.slides().add_slide(layouts.get_by_name("Two Content"));
s.shapes().item(1).text_frame().text = "Two Content (bullets + image)";
fill_bullets_(s.shapes().item(2).text_frame(), { ...
    "Left: bullet list", 0; ...
    "Right: JPEG via add_picture", 1});
% Right column is shape 3 (content placeholder). Leave empty; place picture
% over the right half (same approach as the repaired Two Content sample).
if isfile(imgLaunch)
    s.shapes().add_picture(imgLaunch, ...
        mat2ppt.util.Inches(5.2), mat2ppt.util.Inches(1.6), ...
        mat2ppt.util.Inches(4.0), mat2ppt.util.Inches(4.5));
end
% Optional caption text in the right body placeholder:
s.shapes().item(3).text_frame().text = "Rocket photo (right column)";

%% 4 Section Header
s = prs.slides().add_slide(layouts.get_by_name("Section Header"));
s.shapes().item(1).text_frame().text = "Section Header";
s.shapes().item(2).text_frame().text = "Use this layout to introduce a new section of the deck.";

%% 5 Comparison — four content boxes under title
s = prs.slides().add_slide(layouts.get_by_name("Comparison"));
s.shapes().item(1).text_frame().text = "Comparison";
s.shapes().item(2).text_frame().text = "Left heading";
s.shapes().item(3).text_frame().text = "Left body text";
s.shapes().item(4).text_frame().text = "Right heading";
s.shapes().item(5).text_frame().text = "Right body text";

%% 6 Title Only
s = prs.slides().add_slide(layouts.get_by_name("Title Only"));
s.shapes().item(1).text_frame().text = "Title Only layout";

%% 7 Blank — free shapes / free text
s = prs.slides().add_slide(layouts.get_by_name("Blank"));
s.shapes().add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
    mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
tb = s.shapes().add_textbox( ...
    mat2ppt.util.Inches(1), mat2ppt.util.Inches(2.5), ...
    mat2ppt.util.Inches(6), mat2ppt.util.Inches(1));
tb.text_frame().text = "Blank layout: free shapes and textboxes";

%% 8 Content with Caption
s = prs.slides().add_slide(layouts.get_by_name("Content with Caption"));
s.shapes().item(1).text_frame().text = "Content with Caption";
fill_bullets_(s.shapes().item(2).text_frame(), { ...
    "Main content bullets", 0; ...
    "More content", 0});
s.shapes().item(3).text_frame().text = "Caption / side notes go here.";

%% 9 Picture with Caption — picture in free space + caption body
s = prs.slides().add_slide(layouts.get_by_name("Picture with Caption"));
s.shapes().item(1).text_frame().text = "Picture with Caption";
% Placeholder 2 is a picture slot (no text). Use add_picture positioned left.
if isfile(imgStarship)
    s.shapes().add_picture(imgStarship, ...
        mat2ppt.util.Inches(0.8), mat2ppt.util.Inches(1.8), ...
        mat2ppt.util.Inches(4.5), mat2ppt.util.Inches(4.5));
end
s.shapes().item(3).text_frame().text = "Caption: Starship photo via add_picture.";

%% 10 Title and Vertical Text
s = prs.slides().add_slide(layouts.get_by_name("Title and Vertical Text"));
s.shapes().item(1).text_frame().text = "Title and Vertical Text";
fill_bullets_(s.shapes().item(2).text_frame(), { ...
    "Vertical body text", 0; ...
    "Still 1-based paragraphs", 0});

%% 11 Vertical Title and Text
s = prs.slides().add_slide(layouts.get_by_name("Vertical Title and Text"));
s.shapes().item(1).text_frame().text = "Vertical Title";
fill_bullets_(s.shapes().item(2).text_frame(), { ...
    "Vertical title + body layout", 0; ...
    "Useful for tall text", 0});

%% Bonus blank: table + chart (freeform on Blank)
s = prs.slides().add_slide(layouts.get_by_name("Blank"));
gf = s.shapes().add_table(2, 2, ...
    mat2ppt.util.Inches(0.4), mat2ppt.util.Inches(0.4), ...
    mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
t = gf.table();
t.cell(1, 1).text = "A";
t.cell(2, 2).text = "B";
data = mat2ppt.chart.CategoryChartData();
data.set_categories({"Q1", "Q2", "Q3"});
data.add_series("Revenue", [10, 14, 12]);
s.shapes().add_chart( ...
    mat2ppt.enum.XL_CHART_TYPE.COLUMN_CLUSTERED, ...
    mat2ppt.util.Inches(4), mat2ppt.util.Inches(0.5), ...
    mat2ppt.util.Inches(5.5), mat2ppt.util.Inches(4.5), data);

prs.save(outPath);
fprintf("Wrote %s (%d slides = all layouts + table/chart blank)\n", ...
    outPath, prs.slides().length);

%% ---- local helpers ----
function fill_bullets_(tf, rows)
    % rows: cell N x 2 of {text, level}
    tf.clear();
    ps = tf.paragraphs();
    for i = 1:size(rows, 1)
        if i == 1
            p = ps{1};
        else
            p = tf.add_paragraph();
        end
        p.text = rows{i, 1};
        p.level = rows{i, 2};
    end
end
