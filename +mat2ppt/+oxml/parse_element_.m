function [elm, pos] = parse_element_(s, pos, nsStack)
%PARSE_ELEMENT_  Parse one element starting at '<' .

    n = length(s);
    if s(pos) ~= '<'
        error("mat2ppt:XMLSyntaxError", "Expected '<' at %d", pos);
    end
    pos = pos + 1;
    if pos <= n && (s(pos) == '/' || s(pos) == '!' || s(pos) == '?')
        error("mat2ppt:XMLSyntaxError", "Unexpected markup at %d", pos);
    end

    % read name
    [rawName, pos] = mat2ppt.oxml.read_name_(s, pos);
    % attributes until > or />
    attrs = {};  % {qname, value} in order
    while true
        pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
        if pos <= n && s(pos) == '>'
            pos = pos + 1;
            selfClose = false;
            break
        end
        if pos < n && s(pos) == '/' && s(pos+1) == '>'
            pos = pos + 2;
            selfClose = true;
            break
        end
        [aname, pos] = mat2ppt.oxml.read_name_(s, pos);
        pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
        if pos > n || s(pos) ~= '='
            error("mat2ppt:XMLSyntaxError", "Expected = after attribute name");
        end
        pos = pos + 1;
        pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
        [aval, pos] = mat2ppt.oxml.read_quoted_(s, pos);
        attrs{end+1, 1} = aname; %#ok<AGROW>
        attrs{end, 2} = aval;
    end

    % update ns stack from xmlns attrs (#default = default namespace)
    if nsStack{end}.Count > 0
        localMap = containers.Map(nsStack{end}.keys, nsStack{end}.values, "UniformValues", true);
    else
        localMap = containers.Map("KeyType", "char", "ValueType", "char");
    end
    for i = 1:size(attrs, 1)
        an = attrs{i, 1};
        av = attrs{i, 2};
        if strcmp(an, "xmlns")
            localMap("#default") = av;
        elseif startsWith(string(an), "xmlns:")
            pfx = an(7:end);
            localMap(pfx) = av;
        end
    end
    nsStack{end+1} = localMap; %#ok<AGROW>

    % resolve element tag to Clark
    clark = mat2ppt.oxml.resolve_qname_(rawName, localMap);
    elm = mat2ppt.oxml.XmlElement(clark);

    % Preserve xmlns decls in document order (lxml nsmap / tostring identity)
    nsDecls = {};
    for i = 1:size(attrs, 1)
        an = attrs{i, 1};
        av = attrs{i, 2};
        if strcmp(an, "xmlns")
            nsDecls(end+1, 1:2) = {"", av}; %#ok<AGROW>
        elseif startsWith(string(an), "xmlns:")
            pfx = an(7:end);
            nsDecls(end+1, 1:2) = {pfx, av}; %#ok<AGROW>
        end
    end
    if ~isempty(nsDecls)
        elm.setNsDecls(nsDecls);
    end

    % set attributes (skip xmlns), resolve to Clark for namespaced attrs
    for i = 1:size(attrs, 1)
        an = attrs{i, 1};
        av = attrs{i, 2};
        if strcmp(an, "xmlns") || startsWith(string(an), "xmlns:")
            continue
        end
        if contains(string(an), ":")
            key = mat2ppt.oxml.resolve_qname_(an, localMap);
        else
            key = an;
        end
        elm.set(key, av);
    end

    if selfClose
        nsStack(end) = [];
        return
    end

    % content: text and child elements until </name>
    % textBuf holds raw character data (with entities) until flush;
    % CDATA is appended already-final (no entity processing).
    textBuf = '';
    while pos <= n
        if s(pos) == '<'
            if pos < n && s(pos+1) == '/'
                % end tag
                pos = pos + 2;
                [endName, pos] = mat2ppt.oxml.read_name_(s, pos);
                pos = mat2ppt.oxml.skip_ws_and_misc_(s, pos);
                if pos > n || s(pos) ~= '>'
                    error("mat2ppt:XMLSyntaxError", "Expected > on end tag");
                end
                pos = pos + 1;
                if ~strcmp(endName, rawName)
                    error("mat2ppt:XMLSyntaxError", "Mismatched end tag %s vs %s", endName, rawName);
                end
                flush_text_buf_(elm, textBuf, true);
                nsStack(end) = [];
                return
            elseif pos < n && s(pos+1) == '!'
                % comment or cdata
                if pos+3 <= n && strcmp(s(pos:pos+3), "<!--")
                    endp = strfind(s(pos:end), "-->");
                    pos = pos + endp(1) + 2;
                    continue
                end
                if pos+8 <= n && strcmp(s(pos:pos+8), "<![CDATA[")
                    endp = strfind(s(pos:end), "]]>");
                    % Flush pending entity-bearing text first, then append CDATA raw
                    flush_text_buf_(elm, textBuf, true);
                    textBuf = '';
                    cdata = s(pos+9:pos+endp(1)-2);
                    append_text_final_(elm, cdata);
                    pos = pos + endp(1) + 2;
                    continue
                end
            end
            % child element — flush text as text or tail
            flush_text_buf_(elm, textBuf, true);
            textBuf = '';
            [child, pos] = mat2ppt.oxml.parse_element_(s, pos, nsStack);
            elm.append(child);
        else
            textBuf = [textBuf, s(pos)]; %#ok<AGROW>
            pos = pos + 1;
        end
    end
    error("mat2ppt:XMLSyntaxError", "Unexpected end of document");
end

function flush_text_buf_(elm, textBuf, doUnescape)
    if isempty(textBuf)
        return
    end
    if doUnescape
        textBuf = mat2ppt.oxml.unescape_xml_(textBuf);
    end
    append_text_final_(elm, textBuf);
end

function append_text_final_(elm, textBuf)
    if isempty(textBuf)
        return
    end
    if elm.childCount() == 0
        if mat2ppt.isAbsent(elm.text) || isempty(elm.text)
            elm.text = textBuf;
        else
            elm.text = [char(elm.text), textBuf];
        end
    else
        last = elm.child(elm.childCount());
        if mat2ppt.isAbsent(last.tail)
            last.tail = textBuf;
        else
            last.tail = [char(last.tail), textBuf];
        end
    end
end

