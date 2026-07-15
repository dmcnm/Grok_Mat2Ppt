classdef ChartPart < mat2ppt.opc.XmlPart
%CHARTPART  Chart package part (c:chartSpace).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/chart.py::ChartPart (P8-W1/W6)

    methods
        function obj = ChartPart(partname, contentType, package, element)
            obj@mat2ppt.opc.XmlPart(partname, contentType, package, element);
        end

        function cs = chartSpace(obj)
            cs = obj.element();
        end

        function pa = plotArea(obj)
            pa = mat2ppt.oxml.chart.CT_ChartSpace.plotArea_element(obj.element());
        end
    end
    methods (Static)
        function obj = load(partname, contentType, package, blob)
            elm = mat2ppt.oxml.parse_xml(blob);
            obj = mat2ppt.parts.ChartPart(partname, contentType, package, elm);
        end

        function obj = from_chartspace(partname, package, chartSpaceElm)
            obj = mat2ppt.parts.ChartPart(partname, ...
                mat2ppt.opc.CONTENT_TYPE.DML_CHART, package, chartSpaceElm);
        end

        function [chartPn, rIdChart] = new_in_package(pkg, slidePn, chartType, chartData)
            %NEW_IN_PACKAGE  Create chart + embedded xlsx; return partname and slide rId.
            %   Port of ChartPart.new + ChartWorkbook.update_from_xlsx_blob + slide rel.
            arguments
                pkg
                slidePn
                chartType
                chartData mat2ppt.chart.CategoryChartData
            end
            chartPn = mat2ppt.parts.ChartPart.next_chart_partname_(pkg);
            xlsxPn = mat2ppt.parts.ChartPart.next_xlsx_partname_(pkg);

            xml = chartData.xml_string(chartType);
            elm = mat2ppt.oxml.parse_xml(xml);
            pkg.add_xml_part(chartPn, elm, mat2ppt.opc.CONTENT_TYPE.DML_CHART);

            xlsxBlob = chartData.xlsx_blob();
            pkg.add_blob_part(xlsxPn, xlsxBlob, mat2ppt.opc.CONTENT_TYPE.SML_SHEET);
            rIdXlsx = pkg.add_relationship(chartPn, mat2ppt.opc.RELATIONSHIP_TYPE.PACKAGE, xlsxPn);

            % c:externalData on chartSpace (python ChartWorkbook.xlsx_part setter)
            mat2ppt.parts.ChartPart.ensure_external_data_(elm, rIdXlsx);
            pkg.replace_xml_part(chartPn, elm);

            rIdChart = pkg.add_relationship(slidePn, mat2ppt.opc.RELATIONSHIP_TYPE.CHART, chartPn);
        end

        function pn = next_chart_partname_(pkg)
            names = pkg.list_partnames();
            maxN = 0;
            for i = 1:numel(names)
                tok = regexp(char(names(i)), "^/ppt/charts/chart(\d+)\.xml$", "tokens", "once");
                if ~isempty(tok)
                    maxN = max(maxN, str2double(tok{1}));
                end
            end
            pn = sprintf("/ppt/charts/chart%d.xml", maxN + 1);
        end

        function pn = next_xlsx_partname_(pkg)
            names = pkg.list_partnames();
            maxN = 0;
            for i = 1:numel(names)
                tok = regexp(char(names(i)), ...
                    "^/ppt/embeddings/Microsoft_Excel_Sheet(\d+)\.xlsx$", "tokens", "once");
                if ~isempty(tok)
                    maxN = max(maxN, str2double(tok{1}));
                end
            end
            pn = sprintf("/ppt/embeddings/Microsoft_Excel_Sheet%d.xlsx", maxN + 1);
        end

        function ensure_external_data_(chartSpaceElm, rId)
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            kids = chartSpaceElm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "externalData")
                    kids{i}.set(sprintf("{%s}id", R), char(string(rId)));
                    return
                end
            end
            ext = mat2ppt.oxml.OxmlElement("c:externalData");
            ext.set(sprintf("{%s}id", R), char(string(rId)));
            auto = mat2ppt.oxml.OxmlElement("c:autoUpdate");
            auto.set("val", "0");
            ext.append(auto);
            chartSpaceElm.append(ext);
        end
    end
end

