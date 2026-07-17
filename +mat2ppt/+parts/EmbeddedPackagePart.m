classdef EmbeddedPackagePart < mat2ppt.opc.Part
%EMBEDDEDPACKAGEPART  Embedded DOCX/PPTX/XLSX/OLE blob part (R7).
%
%   Ported from python-pptx 1.0.2: src/pptx/parts/embeddedpackage.py

    methods
        function obj = EmbeddedPackagePart(partname, contentType, package, blob)
            obj@mat2ppt.opc.Part(partname, contentType, package, blob);
        end
    end

    methods (Static)
        function obj = load(partname, contentType, package, blob)
            obj = mat2ppt.parts.EmbeddedPackagePart(partname, contentType, package, blob);
        end

        function pn = factory(pkg, progIdArg, objectBlob)
            %FACTORY  Add embedded package part; return partname.
            %   progIdArg is ProgIdMember or char progId string.
            arguments
                pkg
                progIdArg
                objectBlob
            end
            objectBlob = uint8(objectBlob(:));
            CT = mat2ppt.opc.CONTENT_TYPE;
            if mat2ppt.enum.PROG_ID.is_member(progIdArg)
                switch char(progIdArg.name)
                    case "DOCX"
                        tmpl = "/ppt/embeddings/Microsoft_Word_Document%d.docx";
                        ct = CT.WML_DOCUMENT;
                    case "PPTX"
                        tmpl = "/ppt/embeddings/Microsoft_PowerPoint_Presentation%d.pptx";
                        ct = CT.PML_PRESENTATION;
                    case "XLSX"
                        tmpl = "/ppt/embeddings/Microsoft_Excel_Sheet%d.xlsx";
                        ct = CT.SML_SHEET;
                    otherwise
                        tmpl = "/ppt/embeddings/oleObject%d.bin";
                        ct = CT.OFC_OLE_OBJECT;
                end
            else
                tmpl = "/ppt/embeddings/oleObject%d.bin";
                ct = CT.OFC_OLE_OBJECT;
            end
            pn = mat2ppt.parts.EmbeddedPackagePart.next_partname_(pkg, tmpl);
            pkg.add_blob_part(pn, objectBlob, ct);
        end

        function pn = next_partname_(pkg, template)
            %NEXT_PARTNAME_  First free index for printf template with %d.
            names = pkg.list_partnames();
            % Extract pattern: replace %d with capture
            pat = regexptranslate("escape", template);
            pat = strrep(pat, "%d", "(\\d+)");
            pat = ["^" + string(pat) + "$"];
            idxs = [];
            for i = 1:numel(names)
                tok = regexp(char(names(i)), char(pat), "tokens", "once");
                if ~isempty(tok)
                    idxs(end+1) = str2double(tok{1}); %#ok<AGROW>
                end
            end
            n = 1;
            if ~isempty(idxs)
                for candidate = 1:(max(idxs) + 1)
                    if ~any(idxs == candidate)
                        n = candidate;
                        break
                    end
                end
            end
            pn = sprintf(template, n);
        end
    end
end
