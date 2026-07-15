classdef Mat2PptError < MException
%MAT2PPTERROR  Base exception for Mat2Ppt (python-pptx PythonPptxError).
%
%   Ported from python-pptx 1.0.2: src/pptx/exc.py::PythonPptxError

    methods
        function obj = Mat2PptError(id, msg, varargin)
            if nargin < 1 || strlength(string(id)) == 0
                id = "mat2ppt:Error";
            end
            if nargin < 2
                msg = "Mat2Ppt error";
            end
            obj@MException(id, msg, varargin{:});
        end
    end
end
