function s = unescape_xml_(s)
    s = strrep(s, '&lt;', '<');
    s = strrep(s, '&gt;', '>');
    s = strrep(s, '&quot;', '"');
    s = strrep(s, '&apos;', "'");
    s = strrep(s, '&amp;', '&');
end
