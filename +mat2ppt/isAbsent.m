function tf = isAbsent(x)
%ISABSENT  True if x means python-pptx None (absent / clear).
%
%   tf = mat2ppt.isAbsent(x)
%
%   Returns true for [] (empty non-string) and missing. Returns false for
%   empty strings ("" / '') — those are empty text, not absent (design §7.8).
%
%   Ported from python-pptx 1.0.2: None-checks across the public API
%   (see design.md §7.8; docs/absent_and_errors.md).

    if isa(x, "missing")
        tf = true;
        return
    end

    % string / char: never treat as None (including empty)
    if isstring(x) || ischar(x) || iscellstr(x)
        tf = false;
        return
    end

    % logical scalar is a real value
    if islogical(x) && isscalar(x)
        tf = false;
        return
    end

    tf = isempty(x);
end
