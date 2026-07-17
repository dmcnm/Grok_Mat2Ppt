classdef PROG_ID
%PROG_ID  OLE program-id members with icon + default size (R7-W1 / DEF-011).
%
%   Ported from python-pptx 1.0.2: src/pptx/enum/shapes.py::PROG_ID
%
%   Members expose:
%     .name / .value  (BaseEnum)
%     .progId         COM progId string (e.g. "Excel.Sheet.12")
%     .icon_filename  template icon under resources/templates
%     .width / .height default size in EMU

    properties (Constant)
        DOCX = mat2ppt.enum.ProgIdMember( ...
            "DOCX", 1, "Word.Document.12", "docx-icon.emf", 965200, 609600)
        PPTX = mat2ppt.enum.ProgIdMember( ...
            "PPTX", 2, "PowerPoint.Show.12", "pptx-icon.emf", 965200, 609600)
        XLSX = mat2ppt.enum.ProgIdMember( ...
            "XLSX", 3, "Excel.Sheet.12", "xlsx-icon.emf", 965200, 609600)
    end

    methods (Static)
        function tf = is_member(x)
            tf = isa(x, "mat2ppt.enum.ProgIdMember");
        end

        function m = from_name(name)
            name = upper(char(string(name)));
            switch name
                case "DOCX", m = mat2ppt.enum.PROG_ID.DOCX;
                case "PPTX", m = mat2ppt.enum.PROG_ID.PPTX;
                case "XLSX", m = mat2ppt.enum.PROG_ID.XLSX;
                otherwise
                    error("mat2ppt:ValueError", "Unknown PROG_ID member %s", name);
            end
        end
    end
end
