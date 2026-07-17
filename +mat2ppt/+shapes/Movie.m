classdef Movie < mat2ppt.shapes.Picture
%MOVIE  Video shape based on p:pic (R6).
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/picture.py::Movie

    methods
        function obj = Movie(pic, parent)
            obj@mat2ppt.shapes.Picture(pic, parent);
        end

        function t = shape_type(obj) %#ok<MANU>
            t = mat2ppt.enum.MSO_SHAPE_TYPE.MEDIA;
        end

        function t = media_type(obj) %#ok<MANU>
            t = mat2ppt.enum.PP_MEDIA_TYPE.MOVIE;
        end
    end
end
