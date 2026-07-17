function add_video_timing(slideElm, shapeId)
%ADD_VIDEO_TIMING  Ensure p:timing tree and append p:video for shapeId.
%
%   Ported from python-pptx CT_Slide.get_or_add_childTnLst + add_video.

    shapeId = double(shapeId);
    childTnLst = ensure_childTnLst_(slideElm);
    % next cTn id
    nextId = 2;
    r = mat2ppt.oxml.evaluate_xpath(slideElm, ".//p:cTn");
    for i = 1:numel(r)
        raw = r{i}.get("id");
        if ~mat2ppt.isAbsent(raw)
            nextId = max(nextId, str2double(string(raw)) + 1);
        end
    end
    video = mat2ppt.oxml.OxmlElement("p:video");
    cMedia = mat2ppt.oxml.OxmlElement("p:cMediaNode");
    cMedia.set("vol", "80000");
    cTn = mat2ppt.oxml.OxmlElement("p:cTn");
    cTn.set("id", char(string(nextId)));
    cTn.set("fill", "hold");
    cTn.set("display", "0");
    st = mat2ppt.oxml.OxmlElement("p:stCondLst");
    cond = mat2ppt.oxml.OxmlElement("p:cond");
    cond.set("delay", "indefinite");
    st.append(cond);
    cTn.append(st);
    cMedia.append(cTn);
    tgt = mat2ppt.oxml.OxmlElement("p:tgtEl");
    spTgt = mat2ppt.oxml.OxmlElement("p:spTgt");
    spTgt.set("spid", char(string(shapeId)));
    tgt.append(spTgt);
    cMedia.append(tgt);
    video.append(cMedia);
    childTnLst.append(video);
end

function childTnLst = ensure_childTnLst_(slideElm)
    % DOM walk: ./p:timing/p:tnLst/p:par/p:cTn/p:childTnLst
    % (mini-XPath supports single-segment ./ and .// only)
    r = mat2ppt.oxml.evaluate_xpath(slideElm, ".//p:childTnLst");
    if ~isempty(r)
        childTnLst = r{1};
        return
    end
    % remove existing timing
    kids = slideElm.getchildren();
    for i = numel(kids):-1:1
        if strcmp(char(kids{i}.localName()), "timing")
            slideElm.remove(kids{i});
        end
    end
    timing = mat2ppt.oxml.OxmlElement("p:timing");
    tnLst = mat2ppt.oxml.OxmlElement("p:tnLst");
    par = mat2ppt.oxml.OxmlElement("p:par");
    cTn = mat2ppt.oxml.OxmlElement("p:cTn");
    cTn.set("id", "1");
    cTn.set("dur", "indefinite");
    cTn.set("restart", "never");
    cTn.set("nodeType", "tmRoot");
    childTnLst = mat2ppt.oxml.OxmlElement("p:childTnLst");
    cTn.append(childTnLst);
    par.append(cTn);
    tnLst.append(par);
    timing.append(tnLst);
    slideElm.append(timing);
end
