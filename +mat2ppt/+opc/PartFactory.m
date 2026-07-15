classdef PartFactory
%PARTFACTORY  Map content type → part class (exact python-pptx 1.0.2 map).
%
%   Ported from python-pptx 1.0.2: opc/package.py::PartFactory
%   + pptx/__init__.py content_type_to_part_class_map

    methods (Static)
        function clsName = part_class_for(contentType)
            contentType = char(string(contentType));
            m = mat2ppt.opc.PartFactory.map_();
            if isKey(m, contentType)
                clsName = m(contentType);
            else
                clsName = "mat2ppt.opc.Part";  % opaque blob part
            end
        end

        function part = load(partname, contentType, package, blob)
            clsName = mat2ppt.opc.PartFactory.part_class_for(contentType);
            ctor = str2func(clsName + ".load");
            part = ctor(partname, contentType, package, blob);
        end

        function tf = is_xml_part_class(contentType)
            clsName = mat2ppt.opc.PartFactory.part_class_for(contentType);
            tf = endsWith(string(clsName), "Part") && ...
                ~strcmp(clsName, "mat2ppt.opc.Part") && ...
                ~contains(clsName, "ImagePart") && ...
                ~contains(clsName, "MediaPart");
            % XmlPart subclasses for presentation domain; Image/Media are Part
            if contains(clsName, "ImagePart") || contains(clsName, "MediaPart")
                tf = false;
            elseif strcmp(clsName, "mat2ppt.opc.Part")
                tf = false;
            else
                % Presentation/Slide*/CoreProperties/Chart are XmlPart
                tf = true;
            end
        end
    end

    methods (Static, Access = private)
        function m = map_()
            persistent cache
            if ~isempty(cache)
                m = cache;
                return
            end
            CT = mat2ppt.opc.CONTENT_TYPE;
            cache = containers.Map("KeyType", "char", "ValueType", "char");
            cache(char(CT.PML_PRESENTATION_MAIN)) = "mat2ppt.parts.PresentationPart";
            cache(char(CT.PML_PRES_MACRO_MAIN)) = "mat2ppt.parts.PresentationPart";
            cache(char(CT.PML_TEMPLATE_MAIN)) = "mat2ppt.parts.PresentationPart";
            cache(char(CT.PML_SLIDESHOW_MAIN)) = "mat2ppt.parts.PresentationPart";
            cache(char(CT.OPC_CORE_PROPERTIES)) = "mat2ppt.parts.CorePropertiesPart";
            cache(char(CT.PML_NOTES_MASTER)) = "mat2ppt.parts.NotesMasterPart";
            cache(char(CT.PML_NOTES_SLIDE)) = "mat2ppt.parts.NotesSlidePart";
            cache(char(CT.PML_SLIDE)) = "mat2ppt.parts.SlidePart";
            cache(char(CT.PML_SLIDE_LAYOUT)) = "mat2ppt.parts.SlideLayoutPart";
            cache(char(CT.PML_SLIDE_MASTER)) = "mat2ppt.parts.SlideMasterPart";
            cache(char(CT.DML_CHART)) = "mat2ppt.parts.ChartPart";
            cache(char(CT.BMP)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.GIF)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.JPEG)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.MS_PHOTO)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.PNG)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.TIFF)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.X_EMF)) = "mat2ppt.parts.ImagePart";
            cache(char(CT.X_WMF)) = "mat2ppt.parts.ImagePart";
            cache("image/jpg") = "mat2ppt.parts.ImagePart";
            cache(char(CT.ASF)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.AVI)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.MOV)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.MP4)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.MPG)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.MS_VIDEO)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.SWF)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.VIDEO)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.WMV)) = "mat2ppt.parts.MediaPart";
            cache(char(CT.X_MS_VIDEO)) = "mat2ppt.parts.MediaPart";
            m = cache;
        end
    end
end
