function [orient, sz, idx] = ph_attrs_(spElm)
%PH_ATTRS_  orient/sz/idx from p:ph under shape (or []).
    orient = [];
    sz = [];
    idx = [];
    r = mat2ppt.oxml.evaluate_xpath(spElm, ".//p:ph");
    if isempty(r)
        return
    end
    ph = r{1};
    o = ph.get("orient");
    if ~mat2ppt.isAbsent(o)
        orient = char(string(o));
    end
    s = ph.get("sz");
    if ~mat2ppt.isAbsent(s)
        sz = char(string(s));
    end
    ix = ph.get("idx");
    if ~mat2ppt.isAbsent(ix)
        idx = char(string(ix));
    end
end
