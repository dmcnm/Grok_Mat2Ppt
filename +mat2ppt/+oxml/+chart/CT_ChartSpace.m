classdef CT_ChartSpace
%CT_CHARTSPACE  c:chartSpace root factories and helpers (P8-W1).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/chart/chart.py::CT_ChartSpace

    methods (Static)
        function elm = new_minimal()
            %NEW_MINIMAL  Bare chartSpace with empty chart/plotArea (API shell).
            C = "http://schemas.openxmlformats.org/drawingml/2006/chart";
            A = "http://schemas.openxmlformats.org/drawingml/2006/main";
            R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
            elm = mat2ppt.oxml.OxmlElement(sprintf("{%s}chartSpace", C));
            elm.setNsDecls({"c", C; "a", A; "r", R});
            date1904 = mat2ppt.oxml.OxmlElement("c:date1904");
            date1904.set("val", "0");
            elm.append(date1904);
            chart = mat2ppt.oxml.OxmlElement("c:chart");
            autoTitle = mat2ppt.oxml.OxmlElement("c:autoTitleDeleted");
            autoTitle.set("val", "0");
            chart.append(autoTitle);
            plotArea = mat2ppt.oxml.OxmlElement("c:plotArea");
            chart.append(plotArea);
            elm.append(chart);
        end

        function elm = from_xml_bytes(blob)
            elm = mat2ppt.oxml.parse_xml(blob);
        end

        function ch = chart_element(chartSpace)
            ch = chartSpace.find("c:chart");
            if ~isempty(ch), return; end
            kids = chartSpace.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "chart")
                    ch = kids{i}; return
                end
            end
            ch = [];
        end

        function pa = plotArea_element(chartSpace)
            ch = mat2ppt.oxml.chart.CT_ChartSpace.chart_element(chartSpace);
            if isempty(ch)
                pa = []; return
            end
            pa = ch.find("c:plotArea");
            if ~isempty(pa), return; end
            kids = ch.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "plotArea")
                    pa = kids{i}; return
                end
            end
            pa = [];
        end

        function n = count_local(elm, localName)
            n = mat2ppt.oxml.chart.CT_ChartSpace.count_local_(elm, localName);
        end

        function texts = collect_v_texts(elm)
            texts = mat2ppt.oxml.chart.CT_ChartSpace.collect_v_(elm);
        end

        function uri = graphic_data_uri()
            uri = "http://schemas.openxmlformats.org/drawingml/2006/chart";
        end
    end

    methods (Static, Access = private)
        function n = count_local_(elm, localName)
            n = 0;
            kids = elm.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), localName)
                    n = n + 1;
                end
                n = n + mat2ppt.oxml.chart.CT_ChartSpace.count_local_(kids{i}, localName);
            end
        end

        function texts = collect_v_(elm)
            texts = strings(0);
            if strcmp(char(elm.localName()), "v")
                if ~mat2ppt.isAbsent(elm.text)
                    texts(end+1) = string(elm.text); %#ok<AGROW>
                end
            end
            kids = elm.getchildren();
            for i = 1:numel(kids)
                texts = [texts, mat2ppt.oxml.chart.CT_ChartSpace.collect_v_(kids{i})]; %#ok<AGROW>
            end
        end
    end
end
