function elm = java_node_to_element_(jnode)
%JAVA_NODE_TO_ELEMENT_  Map a Java Element to XmlElement (recursive).

    uri = char(jnode.getNamespaceURI());
    local = char(jnode.getLocalName());
    if isempty(local)
        local = char(jnode.getNodeName());
        % strip prefix if present
        c = strfind(local, ':');
        if ~isempty(c)
            local = local(c(end)+1:end);
        end
    end
    if isempty(uri) || strcmp(uri, "null")
        tag = string(local);
    else
        tag = sprintf("{%s}%s", uri, local);
    end
    elm = mat2ppt.oxml.XmlElement(tag);

    % attributes
    attrs = jnode.getAttributes();
    for i = 0:attrs.getLength()-1
        a = attrs.item(i);
        auri = char(a.getNamespaceURI());
        alocal = char(a.getLocalName());
        aname = char(a.getName());
        if startsWith(string(aname), "xmlns")
            continue  % ns decls handled via element tags
        end
        if isempty(alocal) || strcmp(alocal, "null")
            alocal = aname;
            c = strfind(alocal, ':');
            if ~isempty(c)
                alocal = alocal(c(end)+1:end);
            end
        end
        if isempty(auri) || strcmp(auri, "null")
            key = alocal;
        else
            key = sprintf("{%s}%s", auri, alocal);
        end
        elm.set(key, char(a.getValue()));
    end

    % children and text
    kids = jnode.getChildNodes();
    textParts = strings(0);
    for i = 0:kids.getLength()-1
        ch = kids.item(i);
        nt = ch.getNodeType();
        if nt == org.w3c.dom.Node.ELEMENT_NODE
            % flush text
            if ~isempty(textParts)
                elm.text = char(join(textParts, ""));
                textParts = strings(0);
            end
            childElm = mat2ppt.oxml.java_node_to_element_(ch);
            elm.append(childElm);
            % following text becomes tail — collect subsequent text nodes
            % handled as we continue: text after element goes to child's tail
        elseif nt == org.w3c.dom.Node.TEXT_NODE || nt == org.w3c.dom.Node.CDATA_SECTION_NODE
            tv = char(ch.getNodeValue());
            if elm.childCount() == 0
                textParts(end+1) = string(tv); %#ok<AGROW>
            else
                % tail of last child
                last = elm.child(elm.childCount());
                if mat2ppt.isAbsent(last.tail)
                    last.tail = tv;
                else
                    last.tail = [char(last.tail), tv];
                end
            end
        end
    end
    if ~isempty(textParts)
        elm.text = char(join(textParts, ""));
    end
end
