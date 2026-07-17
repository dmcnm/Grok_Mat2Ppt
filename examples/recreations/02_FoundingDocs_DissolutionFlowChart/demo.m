%% demo.m — Recreate FoundingDocs Dissolution Assets FlowChart via Mat2Ppt API
% Source: Box/FoundingDocs/Bylaws/Dissolution_DistributionOfAssets_FlowChart.pptx
% Assets: none (vector flowchart only). Inventory: extracted/shapes.json
%
% Run from anywhere; writes out_mat2ppt.pptx next to this script.

here = fileparts(mfilename("fullpath"));
addpath(fullfile(here, "..", "..", ".."));  % Mat2Ppt root
outPath = fullfile(here, "out_mat2ppt.pptx");

prs = mat2ppt.Presentation();
% Match original slide size 13.33" x 7.5" (widescreen)
prs.slide_width = mat2ppt.util.Emu(12192000);
prs.slide_height = mat2ppt.util.Emu(6858000);
blank = prs.slide_layouts().get_by_name("Blank");
s = prs.slides().add_slide(blank);
sh = s.shapes();

%% Flowchart nodes and labels (geometry from original slide XML)

% --- Flowchart: Decision 4 ---
sp0 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(5728260), mat2ppt.util.Emu(132588), mat2ppt.util.Emu(1855089), mat2ppt.util.Emu(987552));
sp0.text_frame().text = 'Are the Assets Artistic?';
try
    ps = sp0.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Decision 5 ---
sp1 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(3700272), mat2ppt.util.Emu(911352), mat2ppt.util.Emu(2395728), mat2ppt.util.Emu(1014984));
sp1.text_frame().text = 'Assets Reside at a School or Nonprofit?';
try
    ps = sp1.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Decision 6 ---
sp2 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(1455384), mat2ppt.util.Emu(1796796), mat2ppt.util.Emu(2606040), mat2ppt.util.Emu(1133856));
sp2.text_frame().text = 'School or Nonprofit will Accept Gift of  Artistic Assets?';
try
    ps = sp2.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 7 ---
sp3 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(150876), mat2ppt.util.Emu(5690616), mat2ppt.util.Emu(1508760), mat2ppt.util.Emu(972312));
sp3.text_frame().text = 'A) Artistic Assets gifted to school or non-profit where they reside';
try
    ps = sp3.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 8 ---
sp4 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(3443538), mat2ppt.util.Emu(4507992), mat2ppt.util.Emu(2370812), mat2ppt.util.Emu(2154936));
sp4.text_frame().text = 'C) Artistic assets distributed equally among other affiliate schools where assets reside (or their specified non-profits).  Receiving schools must pay for associated packaging and transportation costs beyond what the St. Luke Guild monetary assets will cover.';
try
    ps = sp4.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 9 ---
sp5 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(7729012), mat2ppt.util.Emu(5675376), mat2ppt.util.Emu(1975104), mat2ppt.util.Emu(987552));
sp5.text_frame().text = 'D) Monetary gifts tied to specific programs returned to original donors';
try
    ps = sp5.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 10 ---
sp6 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(9841687), mat2ppt.util.Emu(5340096), mat2ppt.util.Emu(2255824), mat2ppt.util.Emu(1322832));
sp6.text_frame().text = 'F) Remaining monetary assets not used for distributing artistic assets distributed equally among schools where artistic assets reside';
try
    ps = sp6.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 11 ---
sp7 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(5951921), mat2ppt.util.Emu(5675376), mat2ppt.util.Emu(1639520), mat2ppt.util.Emu(987552));
sp7.text_frame().text = 'E) Non-monetary assets sold and proceeds enter general fund';
try
    ps = sp7.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Process 12 ---
sp8 = sh.add_shape("flowChartProcess", mat2ppt.util.Emu(1797207), mat2ppt.util.Emu(5340096), mat2ppt.util.Emu(1508760), mat2ppt.util.Emu(1322832));
sp8.text_frame().text = 'B) Artistic Assets gifted to non-profit specified by school or non-profit where the asset resides.';
try
    ps = sp8.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Decision 13 ---
sp9 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(7235877), mat2ppt.util.Emu(1063752), mat2ppt.util.Emu(2395728), mat2ppt.util.Emu(1014984));
sp9.text_frame().text = 'Are Assets Monetary?';
try
    ps = sp9.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- Flowchart: Decision 14 ---
sp10 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(9037245), mat2ppt.util.Emu(1876044), mat2ppt.util.Emu(2395728), mat2ppt.util.Emu(1133856));
sp10.text_frame().text = 'Was money donated for a specific program?';
try
    ps = sp10.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- connector Connector: Elbow 16 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(9631605), mat2ppt.util.Emu(1571244), mat2ppt.util.Emu(10235109), mat2ppt.util.Emu(1876044));

% --- connector Connector: Elbow 18 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(6771681), mat2ppt.util.Emu(5675376), mat2ppt.util.Emu(7235877), mat2ppt.util.Emu(1571244));

% --- connector Connector: Elbow 20 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(8716565), mat2ppt.util.Emu(5675376), mat2ppt.util.Emu(9037246), mat2ppt.util.Emu(2442972));

% --- connector Connector: Elbow 22 (bentConnector4) ---
sh.add_connector("bentConnector4", mat2ppt.util.Emu(11432973), mat2ppt.util.Emu(2442972), mat2ppt.util.Emu(10969599), mat2ppt.util.Emu(5340096));

% --- connector Connector: Elbow 24 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(7583349), mat2ppt.util.Emu(626364), mat2ppt.util.Emu(8433741), mat2ppt.util.Emu(1063752));

% --- connector Connector: Elbow 26 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(4898136), mat2ppt.util.Emu(911352), mat2ppt.util.Emu(5728260), mat2ppt.util.Emu(626364));

% --- connector Connector: Elbow 28 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(905256), mat2ppt.util.Emu(5690616), mat2ppt.util.Emu(1455384), mat2ppt.util.Emu(2363724));

% --- Flowchart: Decision 29 ---
sp18 = sh.add_shape("flowChartDecision", mat2ppt.util.Emu(2880360), mat2ppt.util.Emu(2662047), mat2ppt.util.Emu(3215640), mat2ppt.util.Emu(1471422));
sp18.text_frame().text = 'School or non-profit specifies alternate non-profit to receive artistic assets?';
try
    ps = sp18.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1400);
    end
catch
end

% --- connector Connector: Elbow 31 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(2551588), mat2ppt.util.Emu(5340096), mat2ppt.util.Emu(2880361), mat2ppt.util.Emu(3397758));

% --- connector Connector: Elbow 33 (bentConnector4) ---
sh.add_connector("bentConnector4", mat2ppt.util.Emu(6096000), mat2ppt.util.Emu(3397758), mat2ppt.util.Emu(4628944), mat2ppt.util.Emu(4507992));

% --- connector Connector: Elbow 36 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(4061424), mat2ppt.util.Emu(2363724), mat2ppt.util.Emu(4488180), mat2ppt.util.Emu(2662047));

% --- connector Connector: Elbow 38 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(2758404), mat2ppt.util.Emu(1796796), mat2ppt.util.Emu(3700272), mat2ppt.util.Emu(1418844));

% --- connector Connector: Elbow 40 (bentConnector2) ---
sh.add_connector("bentConnector2", mat2ppt.util.Emu(6096000), mat2ppt.util.Emu(1418844), mat2ppt.util.Emu(6336832), mat2ppt.util.Emu(3914966));

% --- TextBox 44 ---
sp24 = sh.add_shape("rect", mat2ppt.util.Emu(7660617), mat2ppt.util.Emu(321171), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp24.text_frame().text = 'No';
try
    ps = sp24.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 45 ---
sp25 = sh.add_shape("rect", mat2ppt.util.Emu(6772672), mat2ppt.util.Emu(1278427), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp25.text_frame().text = 'No';
try
    ps = sp25.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 46 ---
sp26 = sh.add_shape("rect", mat2ppt.util.Emu(11292896), mat2ppt.util.Emu(2165973), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp26.text_frame().text = 'No';
try
    ps = sp26.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 47 ---
sp27 = sh.add_shape("rect", mat2ppt.util.Emu(3980555), mat2ppt.util.Emu(2155692), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp27.text_frame().text = 'No';
try
    ps = sp27.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 48 ---
sp28 = sh.add_shape("rect", mat2ppt.util.Emu(5967829), mat2ppt.util.Emu(3093720), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp28.text_frame().text = 'No';
try
    ps = sp28.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 49 ---
sp29 = sh.add_shape("rect", mat2ppt.util.Emu(5967885), mat2ppt.util.Emu(1165362), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp29.text_frame().text = 'No';
try
    ps = sp29.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 51 ---
sp30 = sh.add_shape("rect", mat2ppt.util.Emu(5048002), mat2ppt.util.Emu(347847), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp30.text_frame().text = 'Yes';
try
    ps = sp30.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 52 ---
sp31 = sh.add_shape("rect", mat2ppt.util.Emu(2958675), mat2ppt.util.Emu(1123397), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp31.text_frame().text = 'Yes';
try
    ps = sp31.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 53 ---
sp32 = sh.add_shape("rect", mat2ppt.util.Emu(833535), mat2ppt.util.Emu(2099126), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp32.text_frame().text = 'Yes';
try
    ps = sp32.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

% --- TextBox 54 ---
sp33 = sh.add_shape("rect", mat2ppt.util.Emu(2412588), mat2ppt.util.Emu(3116562), mat2ppt.util.Emu(530391), mat2ppt.util.Emu(276999));
sp33.text_frame().text = 'Yes';
try
    ps = sp33.text_frame().paragraphs();
    rs = ps{1}.runs();
    if ~isempty(rs)
        rs{1}.font().size = mat2ppt.util.Centipoints(1200);
    end
catch
end

prs.save(outPath);
fprintf("Wrote %s\n", outPath);
