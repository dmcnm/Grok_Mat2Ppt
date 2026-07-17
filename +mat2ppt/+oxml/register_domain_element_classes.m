function register_domain_element_classes()
%REGISTER_DOMAIN_ELEMENT_CLASSES  Register typed CT classes for residual domains (R8-W1).
%
%   Registers every Mat2Ppt CT_* class that maps to python-pptx tags used by
%   authoring. Tags without typed CT remain XmlElement (see DEF-008 residual list).

    persistent done
    if ~isempty(done) && done
        return
    end

    mat2ppt.oxml.register_opc_element_classes();

    % --- dml color/fill ---
    mat2ppt.oxml.register_element_cls("a:srgbClr", "mat2ppt.oxml.dml.CT_SRgbColor");
    mat2ppt.oxml.register_element_cls("a:schemeClr", "mat2ppt.oxml.dml.CT_SchemeColor");
    mat2ppt.oxml.register_element_cls("a:solidFill", "mat2ppt.oxml.dml.CT_SolidColorFillProperties");

    % --- text ---
    mat2ppt.oxml.register_element_cls("a:r", "mat2ppt.oxml.text.CT_RegularTextRun");
    mat2ppt.oxml.register_element_cls("a:p", "mat2ppt.oxml.text.CT_TextParagraph");
    mat2ppt.oxml.register_element_cls("a:txBody", "mat2ppt.oxml.text.CT_TextBody");
    mat2ppt.oxml.register_element_cls("p:txBody", "mat2ppt.oxml.text.CT_TextBody");

    % --- slide ---
    mat2ppt.oxml.register_element_cls("p:sld", "mat2ppt.oxml.slide.CT_Slide");
    mat2ppt.oxml.register_element_cls("p:notes", "mat2ppt.oxml.slide.CT_Notes");

    % --- chart ---
    mat2ppt.oxml.register_element_cls("c:chartSpace", "mat2ppt.oxml.chart.CT_ChartSpace");
    mat2ppt.oxml.register_element_cls("c:dLbls", "mat2ppt.oxml.chart.CT_DLbls");
    mat2ppt.oxml.register_element_cls("c:legend", "mat2ppt.oxml.chart.CT_Legend");
    mat2ppt.oxml.register_element_cls("c:ser", "mat2ppt.oxml.chart.CT_Series");
    mat2ppt.oxml.register_element_cls("c:catAx", "mat2ppt.oxml.chart.CT_Axis");
    mat2ppt.oxml.register_element_cls("c:valAx", "mat2ppt.oxml.chart.CT_Axis");
    mat2ppt.oxml.register_element_cls("c:dateAx", "mat2ppt.oxml.chart.CT_Axis");
    mat2ppt.oxml.register_element_cls("c:barChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:lineChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:pieChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:doughnutChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:areaChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:area3DChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:scatterChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:bubbleChart", "mat2ppt.oxml.chart.CT_Plot");
    mat2ppt.oxml.register_element_cls("c:radarChart", "mat2ppt.oxml.chart.CT_Plot");

    done = true;
end
