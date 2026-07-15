function ref = relative_pack_ref(sourcePartname, targetPartname)
%RELATIVE_PACK_REF  Relative Target path from source part to target part.
%
%   ref = mat2ppt.opc.relative_pack_ref("/ppt/presentation.xml", ...
%       "/ppt/slides/slide1.xml")  % -> "slides/slide1.xml"

    srcBase = char(mat2ppt.opc.PackURI(char(string(sourcePartname))).baseURI);
    tgt = char(string(targetPartname));
    if startsWith(string(tgt), "/")
        tgt = tgt(2:end);
    end
    if strcmp(srcBase, "/") || strlength(string(srcBase)) == 0
        srcSeg = strings(0);
    else
        b = string(srcBase);
        if startsWith(b, "/")
            b = extractAfter(b, 1);
        end
        if strlength(b) == 0
            srcSeg = strings(0);
        else
            srcSeg = split(b, "/");
            srcSeg = srcSeg(:)';  % column
        end
    end
    if strlength(string(tgt)) == 0
        tgtSeg = strings(0);
    else
        tgtSeg = split(string(tgt), "/");
        tgtSeg = tgtSeg(:);
    end
    n = min(numel(srcSeg), numel(tgtSeg));
    c = 0;
    for i = 1:n
        if srcSeg(i) == tgtSeg(i)
            c = i;
        else
            break
        end
    end
    ups = numel(srcSeg) - c;
    rest = tgtSeg(c+1:end);
    parts = [repmat("..", ups, 1); rest];
    if isempty(parts)
        ref = "";
    else
        ref = char(join(parts, "/"));
    end
end
