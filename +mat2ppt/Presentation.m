classdef Presentation < handle
%PRESENTATION  PowerPoint presentation package (public entry, Option C).
%
%   prs = mat2ppt.Presentation()
%   prs = mat2ppt.Presentation(path)
%   prs.save(path)
%
%   Ported from python-pptx 1.0.2: src/pptx/api.py::Presentation
%   + src/pptx/presentation.py::Presentation (thin M1 shell)

    properties (Access = private)
        pkg_
        coreProps_ = []  % cached CoreProperties or []
    end

    properties (Dependent)
        % Slide size in EMU (python-pptx Presentation.slide_width / slide_height)
        slide_width
        slide_height
    end

    methods
        function obj = Presentation(pptx)
            %PRESENTATION  Open default template or path.
            if nargin < 1 || mat2ppt.isAbsent(pptx)
                pptx = mat2ppt.template_path("default.pptx");
            end
            pptx = char(string(pptx));
            if ~isfile(pptx)
                error("mat2ppt:PackageNotFoundError", ...
                    "Package not found at '%s'.", pptx);
            end
            obj.pkg_ = mat2ppt.opc.OpcPackage.open(pptx);
        end

        function save(obj, path)
            %SAVE  Write package to path.
            arguments
                obj
                path
            end
            path = char(string(path));
            if strlength(string(path)) == 0
                error("mat2ppt:ArgumentError", "save path must be non-empty text.");
            end
            obj.pkg_.save(path);
        end

        function pkg = package(obj)
            %PACKAGE  Underlying OpcPackage (advanced).
            pkg = obj.pkg_;
        end

        function cp = core_properties(obj)
            %CORE_PROPERTIES  Dublin Core metadata for this package.
            if isempty(obj.coreProps_)
                elm = obj.pkg_.xml_part_element("/docProps/core.xml");
                if isempty(elm)
                    error("mat2ppt:InvalidPackage", "Missing /docProps/core.xml");
                end
                obj.coreProps_ = mat2ppt.parts.CoreProperties(elm);
            end
            cp = obj.coreProps_;
        end

        function elm = presentation_element(obj)
            %PRESENTATION_ELEMENT  Root p:presentation of /ppt/presentation.xml.
            elm = obj.pkg_.xml_part_element("/ppt/presentation.xml");
            if isempty(elm)
                error("mat2ppt:InvalidPackage", "Missing /ppt/presentation.xml");
            end
        end

        function w = get.slide_width(obj)
            %SLIDE_WIDTH  Width of slides (EMU Length) or [] if no p:sldSz.
            sldSz = obj.find_sldSz_();
            if isempty(sldSz)
                w = [];
                return
            end
            raw = sldSz.get("cx");
            if mat2ppt.isAbsent(raw)
                w = [];
            else
                w = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function set.slide_width(obj, width)
            %SLIDE_WIDTH  Set slide width (Length or numeric EMU).
            sldSz = obj.get_or_add_sldSz_();
            e = mat2ppt.util.Length.toEmuInt_(width);
            sldSz.set("cx", char(string(e)));
        end

        function h = get.slide_height(obj)
            %SLIDE_HEIGHT  Height of slides (EMU Length) or [] if no p:sldSz.
            sldSz = obj.find_sldSz_();
            if isempty(sldSz)
                h = [];
                return
            end
            raw = sldSz.get("cy");
            if mat2ppt.isAbsent(raw)
                h = [];
            else
                h = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function set.slide_height(obj, height)
            %SLIDE_HEIGHT  Set slide height (Length or numeric EMU).
            sldSz = obj.get_or_add_sldSz_();
            e = mat2ppt.util.Length.toEmuInt_(height);
            sldSz.set("cy", char(string(e)));
        end

        function s = slides(obj)
            %SLIDES  |Slides| collection (1-based). Empty on default template.
            s = mat2ppt.slide.Slides(obj);
        end

        function sm = slide_masters(obj)
            %SLIDE_MASTERS  |SlideMasters| collection (1-based).
            sm = mat2ppt.slide.SlideMasters(obj);
        end

        function sm = slide_master(obj)
            %SLIDE_MASTER  First slide master (common single-master case).
            sm = obj.slide_masters().item(1);
        end

        function layouts = slide_layouts(obj)
            %SLIDE_LAYOUTS  Layouts of the first slide master (1-based).
            layouts = obj.slide_master().slide_layouts();
        end

        function nm = notes_master(obj)
            %NOTES_MASTER  |NotesMaster| for this presentation (lazy create).
            %
            %   Ported from python-pptx presentation.py::Presentation.notes_master
            %   + parts/presentation.py notes_master_part.
            masterPn = mat2ppt.slide.ensure_notes_master(obj);
            elm = obj.package().xml_part_element(masterPn);
            if isempty(elm)
                error("mat2ppt:InvalidPackage", ...
                    "Notes master part missing after ensure: %s", masterPn);
            end
            nm = mat2ppt.slide.NotesMaster(elm, masterPn, obj);
        end
    end

    methods (Access = private)
        function sldSz = find_sldSz_(obj)
            prs = obj.presentation_element();
            sldSz = prs.find("p:sldSz");
        end

        function sldSz = get_or_add_sldSz_(obj)
            %GET_OR_ADD_SLDSZ_  p:sldSz child; insert before p:notesSz when adding.
            prs = obj.presentation_element();
            sldSz = prs.find("p:sldSz");
            if ~isempty(sldSz)
                return
            end
            sldSz = mat2ppt.oxml.OxmlElement("p:sldSz");
            % Default 10" x 7.5" (standard) if creating bare — setters overwrite.
            sldSz.set("cx", "9144000");
            sldSz.set("cy", "6858000");
            notesSz = prs.find("p:notesSz");
            if ~isempty(notesSz)
                kids = prs.getchildren();
                idx = 1;
                for i = 1:numel(kids)
                    if kids{i} == notesSz
                        idx = i;
                        break
                    end
                end
                prs.insert(idx, sldSz);
            else
                prs.append(sldSz);
            end
        end
    end
end

