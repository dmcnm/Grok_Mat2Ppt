function [cSld, spTree] = find_cSld_spTree(slideElm)
%FIND_CSLD_SPTREE  Locate p:cSld and p:spTree under slide/layout/master root.
    cSld = slideElm.find("p:cSld");
    if isempty(cSld)
        kids = slideElm.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "cSld")
                cSld = kids{i};
                break
            end
        end
    end
    if isempty(cSld)
        error("mat2ppt:InvalidXml", "Missing p:cSld");
    end
    spTree = cSld.find("p:spTree");
    if isempty(spTree)
        kids = cSld.getchildren();
        for i = 1:numel(kids)
            if strcmp(char(kids{i}.localName()), "spTree")
                spTree = kids{i};
                break
            end
        end
    end
    if isempty(spTree)
        error("mat2ppt:InvalidXml", "Missing p:spTree under cSld");
    end
end
