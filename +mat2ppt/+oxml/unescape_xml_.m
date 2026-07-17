function s = unescape_xml_(s)
%UNESCAPE_XML_  Decode XML character and named entities to Unicode text.
%
%   Handles &#xHH;, &#NNN;, and &lt; &gt; &quot; &apos; &amp; (amp last).
%   Used for attribute values and element text/tail after parse.

    if isempty(s)
        s = '';
        return
    end
    s = char(string(s));

    % Numeric character references first (so they are not affected by named).
    s = replace_hex_refs_(s);
    s = replace_dec_refs_(s);

    % Named entities — &amp; MUST be last.
    s = strrep(s, '&lt;', '<');
    s = strrep(s, '&gt;', '>');
    s = strrep(s, '&quot;', '"');
    s = strrep(s, '&apos;', "'");
    s = strrep(s, '&amp;', '&');
    s = char(s);
end

function s = replace_hex_refs_(s)
    while true
        [tok, startIdx, endIdx] = regexp(s, '&#[xX]([0-9A-Fa-f]+);', ...
            'tokens', 'start', 'end', 'once');
        if isempty(startIdx)
            return
        end
        cp = hex2dec(tok{1});
        ch = codepoint_to_chars_(cp);
        s = [s(1:startIdx-1), ch, s(endIdx+1:end)]; %#ok<AGROW>
    end
end

function s = replace_dec_refs_(s)
    while true
        [tok, startIdx, endIdx] = regexp(s, '&#([0-9]+);', ...
            'tokens', 'start', 'end', 'once');
        if isempty(startIdx)
            return
        end
        cp = str2double(tok{1});
        ch = codepoint_to_chars_(cp);
        s = [s(1:startIdx-1), ch, s(endIdx+1:end)]; %#ok<AGROW>
    end
end

function ch = codepoint_to_chars_(cp)
    cp = double(cp);
    if isnan(cp) || cp < 0 || cp > hex2dec('10FFFF')
        ch = '';
        return
    end
    if cp <= hex2dec('FFFF')
        ch = char(cp);
        return
    end
    % UTF-16 surrogate pair for supplementary planes
    cp = cp - hex2dec('10000');
    hi = hex2dec('D800') + floor(cp / 1024);
    lo = hex2dec('DC00') + mod(cp, 1024);
    ch = [char(hi), char(lo)];
end
