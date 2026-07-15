classdef PP_ACTION
%PP_ACTION  Alias of mat2ppt.enum.PP_ACTION_TYPE.
%
%   Ported from python-pptx 1.0.2: PP_ACTION = PP_ACTION_TYPE

    properties (Constant)
        END_SHOW = mat2ppt.enum.PP_ACTION_TYPE.END_SHOW
        FIRST_SLIDE = mat2ppt.enum.PP_ACTION_TYPE.FIRST_SLIDE
        HYPERLINK = mat2ppt.enum.PP_ACTION_TYPE.HYPERLINK
        LAST_SLIDE = mat2ppt.enum.PP_ACTION_TYPE.LAST_SLIDE
        LAST_SLIDE_VIEWED = mat2ppt.enum.PP_ACTION_TYPE.LAST_SLIDE_VIEWED
        NAMED_SLIDE = mat2ppt.enum.PP_ACTION_TYPE.NAMED_SLIDE
        NAMED_SLIDE_SHOW = mat2ppt.enum.PP_ACTION_TYPE.NAMED_SLIDE_SHOW
        NEXT_SLIDE = mat2ppt.enum.PP_ACTION_TYPE.NEXT_SLIDE
        NONE = mat2ppt.enum.PP_ACTION_TYPE.NONE
        OPEN_FILE = mat2ppt.enum.PP_ACTION_TYPE.OPEN_FILE
        OLE_VERB = mat2ppt.enum.PP_ACTION_TYPE.OLE_VERB
        PLAY = mat2ppt.enum.PP_ACTION_TYPE.PLAY
        PREVIOUS_SLIDE = mat2ppt.enum.PP_ACTION_TYPE.PREVIOUS_SLIDE
        RUN_MACRO = mat2ppt.enum.PP_ACTION_TYPE.RUN_MACRO
        RUN_PROGRAM = mat2ppt.enum.PP_ACTION_TYPE.RUN_PROGRAM
    end
end
