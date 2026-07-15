classdef Length
%LENGTH  Length in English Metric Units (EMU), with unit conversions.
%
%   L = mat2ppt.util.Length(emu)
%   L.inches, L.cm, L.mm, L.pt, L.emu, L.centipoints
%
%   Base value class for Inches, Emu, Cm, Mm, Pt, Centipoints. Stores an
%   integer EMU count. Subclass constructors apply Python-style int()
%   truncation toward zero of (units * scale).
%
%   Ported from python-pptx 1.0.2: src/pptx/util.py::Length

    properties (Constant)
        EMUS_PER_INCH = int64(914400)
        EMUS_PER_CENTIPOINT = int64(127)
        EMUS_PER_CM = int64(360000)
        EMUS_PER_MM = int64(36000)
        EMUS_PER_PT = int64(12700)
    end

    properties (SetAccess = private)
        % Integer English Metric Units (like Python Length as int subclass)
        emu (1,1) int64 = int64(0)
    end

    properties (Dependent, SetAccess = private)
        inches
        centipoints
        cm
        mm
        pt
    end

    methods
        function obj = Length(emuVal)
            if nargin < 1
                error("mat2ppt:ArgumentError", "Length requires an EMU value.");
            end
            obj.emu = mat2ppt.util.Length.toEmuInt_(emuVal);
        end

        function v = get.inches(obj)
            v = double(obj.emu) / double(obj.EMUS_PER_INCH);
        end

        function v = get.centipoints(obj)
            v = idivide(obj.emu, obj.EMUS_PER_CENTIPOINT, "floor");
        end

        function v = get.cm(obj)
            v = double(obj.emu) / double(obj.EMUS_PER_CM);
        end

        function v = get.mm(obj)
            v = double(obj.emu) / double(obj.EMUS_PER_MM);
        end

        function v = get.pt(obj)
            v = double(obj.emu) / double(obj.EMUS_PER_PT);
        end

        function tf = eq(a, b)
            tf = mat2ppt.util.Length.emuOf_(a) == mat2ppt.util.Length.emuOf_(b);
        end

        function tf = ne(a, b)
            tf = ~eq(a, b);
        end

        function d = double(obj)
            d = double(obj.emu);
        end
    end

    methods (Static)
        function e = toEmuInt_(x)
            %TOEMUINT_  Coerce Length or numeric to int64 EMUs (package-wide helper).
            if isa(x, "mat2ppt.util.Length")
                e = x.emu;
                return
            end
            e = int64(fix(double(x)));
        end

        function e = emuOf_(x)
            if isa(x, "mat2ppt.util.Length")
                e = x.emu;
            else
                e = mat2ppt.util.Length.toEmuInt_(x);
            end
        end

        function e = scaleToEmu_(units, perUnit)
            e = int64(fix(double(units) * double(perUnit)));
        end
    end
end
