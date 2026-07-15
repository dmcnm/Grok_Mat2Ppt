classdef CONTENT_TYPE
%CONTENT_TYPE  OPC / OOXML content type constants (python-pptx subset for PartFactory).
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/constants.py::CONTENT_TYPE

    properties (Constant)
        OPC_CORE_PROPERTIES = "application/vnd.openxmlformats-package.core-properties+xml"
        OPC_RELATIONSHIPS = "application/vnd.openxmlformats-package.relationships+xml"
        XML = "application/xml"
        PML_PRESENTATION_MAIN = "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
        PML_PRES_MACRO_MAIN = "application/vnd.ms-powerpoint.presentation.macroEnabled.main+xml"
        PML_TEMPLATE_MAIN = "application/vnd.openxmlformats-officedocument.presentationml.template.main+xml"
        PML_SLIDESHOW_MAIN = "application/vnd.openxmlformats-officedocument.presentationml.slideshow.main+xml"
        PML_NOTES_MASTER = "application/vnd.openxmlformats-officedocument.presentationml.notesMaster+xml"
        PML_NOTES_SLIDE = "application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml"
        PML_SLIDE = "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"
        PML_SLIDE_LAYOUT = "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"
        PML_SLIDE_MASTER = "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"
        DML_CHART = "application/vnd.openxmlformats-officedocument.drawingml.chart+xml"
        OFC_THEME = "application/vnd.openxmlformats-officedocument.theme+xml"
        BMP = "image/bmp"
        GIF = "image/gif"
        JPEG = "image/jpeg"
        MS_PHOTO = "image/vnd.ms-photo"
        PNG = "image/png"
        TIFF = "image/tiff"
        X_EMF = "image/x-emf"
        X_WMF = "image/x-wmf"
        ASF = "video/x-ms-asf"
        AVI = "video/avi"
        MOV = "video/quicktime"
        MP4 = "video/mp4"
        MPG = "video/mpeg"
        MS_VIDEO = "video/msvideo"
        SWF = "application/x-shockwave-flash"
        VIDEO = "video/unknown"
        WMV = "video/x-ms-wmv"
        X_MS_VIDEO = "video/x-msvideo"
    end
end
