classdef Test_p5_shapes_phase < matlab.unittest.TestCase
    % P5-W2..W12 shape + dml/text residual coverage

    methods (Test)
        function addShapeGeometry(testCase)
            spTree = mat2ppt.oxml.OxmlElement("p:spTree");
            parent = struct("part", "stub");
            shapes = mat2ppt.shapes.SlideShapes(spTree, parent);
            sh = shapes.add_shape(mat2ppt.enum.MSO_SHAPE.RECTANGLE, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(2), ...
                mat2ppt.util.Inches(3), mat2ppt.util.Inches(1.5));
            testCase.verifyEqual(shapes.length, 1);
            testCase.verifyEqual(sh.left.inches, 1, "AbsTol", 1e-6);
            testCase.verifyEqual(sh.top.inches, 2, "AbsTol", 1e-6);
            testCase.verifyEqual(sh.width.inches, 3, "AbsTol", 1e-6);
            testCase.verifyTrue(sh.has_text_frame());
            sh.name = "Box1";
            testCase.verifyEqual(sh.name, "Box1");
        end

        function adjustmentEffective(testCase)
            a = mat2ppt.shapes.Adjustment("adj", 50000);
            testCase.verifyEqual(a.effective_value, 0.5, "AbsTol", 1e-9);
            a.effective_value = 0.25;
            testCase.verifyEqual(a.actual, 25000);
        end

        function pictureElm(testCase)
            pic = mat2ppt.shapes.Picture.new_pic_elm(3, "Image 1", ...
                mat2ppt.util.Inches(0), mat2ppt.util.Inches(0), ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), "rId2");
            p = mat2ppt.shapes.Picture(pic, struct("part","x"));
            testCase.verifyEqual(p.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.PICTURE.value);
            testCase.verifyEqual(p.name, "Image 1");
        end

        function placeholderDetect(testCase)
            sp = mat2ppt.oxml.shapes.new_sp(1, "Title", 0, 0, 100, 100, "rect");
            nvPr = sp.find("p:nvSpPr");
            if isempty(nvPr)
                kids = sp.getchildren();
                nvPr = kids{1};
            end
            % find nvPr child
            gc = nvPr.getchildren();
            nvPrEl = [];
            for i = 1:numel(gc)
                if strcmp(char(gc{i}.localName()), "nvPr")
                    nvPrEl = gc{i}; break
                end
            end
            ph = mat2ppt.oxml.OxmlElement("p:ph");
            ph.set("type", "title");
            nvPrEl.append(ph);
            testCase.verifyTrue(mat2ppt.shapes.PlaceholderMixin.element_is_placeholder(sp));
            testCase.verifyEqual(string(mat2ppt.shapes.PlaceholderMixin.placeholder_type(sp)), "title");
        end

        function freeformOps(testCase)
            fb = mat2ppt.shapes.FreeformBuilder([], mat2ppt.util.Inches(0), mat2ppt.util.Inches(0));
            fb.move_to(mat2ppt.util.Inches(1), mat2ppt.util.Inches(1));
            fb.line_to(mat2ppt.util.Inches(2), mat2ppt.util.Inches(1));
            testCase.verifyEqual(fb.operation_count(), 2);
        end

        function colorFormatRgb(testCase)
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            solid = mat2ppt.oxml.dml.CT_SolidColorFillProperties(sprintf("{%s}solidFill", A));
            cf = mat2ppt.dml.ColorFormat.from_colorchoice_parent(solid);
            cf.rgb = mat2ppt.dml.RGBColor(1, 2, 3);
            testCase.verifyEqual(cf.type().value, mat2ppt.enum.MSO_COLOR_TYPE.RGB.value);
            testCase.verifyEqual(cf.rgb.hex, "010203");
        end

        function fillSolidOnSpPr(testCase)
            sp = mat2ppt.oxml.shapes.new_sp(1, "S", 0, 0, 100, 100, "rect");
            sh = mat2ppt.shapes.Shape(sp, struct("part","p"));
            f = sh.fill();
            f.solid();
            f.set_fore_color_rgb(mat2ppt.dml.RGBColor(255, 0, 0));
            testCase.verifyEqual(f.fore_color_rgb().hex, "FF0000");
        end

        function textBodyRun(testCase)
            tb = mat2ppt.oxml.text.CT_TextBody.new();
            tb.clear_content();
            p = tb.add_p();
            r = p.add_r();
            r.set_text("Hello");
            testCase.verifyEqual(string(p.get_text()), "Hello");
            testCase.verifyEqual(numel(tb.p_lst()), 1);
        end

        function connectorAndGroupTypes(testCase)
            cxn = mat2ppt.oxml.OxmlElement("p:cxnSp");
            nv = mat2ppt.oxml.OxmlElement("p:nvCxnSpPr");
            cNvPr = mat2ppt.oxml.OxmlElement("p:cNvPr");
            cNvPr.set("id", "9"); cNvPr.set("name", "Connector 9");
            nv.append(cNvPr);
            cxn.append(nv);
            c = mat2ppt.shapes.Connector(cxn, struct("part","p"));
            testCase.verifyEqual(c.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.LINE.value);
            g = mat2ppt.shapes.GroupShape(mat2ppt.oxml.OxmlElement("p:grpSp"), struct("part","p"));
            testCase.verifyEqual(g.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.GROUP.value);
        end
    end
end
