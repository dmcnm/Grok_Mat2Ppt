classdef BaseOxmlElement < mat2ppt.oxml.XmlElement
%BASEOXMLELEMENT  Custom element base (xmlchemy twin without metaclasses).
%
%   Ported from python-pptx 1.0.2: src/pptx/oxml/xmlchemy.py::BaseOxmlElement
%   design.md §7.2 — explicit methods + registration tables.

    methods
        function obj = BaseOxmlElement(tag)
            if nargin < 1
                error("mat2ppt:ArgumentError", "BaseOxmlElement requires a tag");
            end
            obj@mat2ppt.oxml.XmlElement(tag);
        end

        function v = get_attr_value(obj, attrName, simpleTypeCls)
            %GET_ATTR_VALUE  Read attribute via simpletype.from_xml, or [].
            raw = obj.get(attrName);
            if mat2ppt.isAbsent(raw)
                v = [];
                return
            end
            if nargin >= 3 && ~isempty(simpleTypeCls)
                fcn = str2func(simpleTypeCls + ".from_xml");
                v = fcn(raw);
            else
                v = raw;
            end
        end

        function set_attr_value(obj, attrName, value, simpleTypeCls)
            %SET_ATTR_VALUE  Write attribute via simpletype.to_xml.
            if mat2ppt.isAbsent(value)
                obj.removeAttr(attrName);
                return
            end
            if nargin >= 4 && ~isempty(simpleTypeCls)
                fcn = str2func(simpleTypeCls + ".to_xml");
                s = fcn(value);
            else
                s = char(string(value));
            end
            obj.set(attrName, s);
        end

        function kids = child_list(obj, tag)
            %CHILD_LIST  All direct children matching tag (Clark or pfx:local).
            kids = obj.findall(tag);
        end

        function c = first_child(obj, tag)
            %FIRST_CHILD  First matching child or [].
            c = obj.find(tag);
        end

        function c = get_or_add_child(obj, tag)
            %GET_OR_ADD_CHILD  First child with tag, or create/append one.
            c = obj.find(tag);
            if isempty(c)
                c = mat2ppt.oxml.OxmlElement(tag);
                obj.append(c);
            end
        end

        function remove_all(obj, tag)
            %REMOVE_ALL  Remove all direct children with tag.
            tag = string(tag);
            if contains(tag, ":") && ~startsWith(tag, "{")
                tag = string(mat2ppt.oxml.qn(tag));
            end
            kids = obj.getchildren();
            for i = numel(kids):-1:1
                if kids{i}.tag == tag
                    obj.remove(kids{i});
                end
            end
        end
    end

    methods (Static)
        function elm = from_xml_element(xmlElm)
            %FROM_XML_ELEMENT  Re-wrap XmlElement as registered BaseOxmlElement if any.
            arguments
                xmlElm (1,1) mat2ppt.oxml.XmlElement
            end
            clsName = mat2ppt.oxml.element_class_for_tag(xmlElm.tag);
            if strlength(string(clsName)) == 0
                elm = xmlElm;
                return
            end
            ctor = str2func(clsName);
            elm = ctor(xmlElm.tag);
            % copy tree surface
            [an, av] = xmlElm.attribItems();
            for i = 1:numel(an)
                elm.set(an{i}, av{i});
            end
            if xmlElm.hasNsDecls()
                elm.setNsDecls(xmlElm.getNsDecls());
            end
            if ~mat2ppt.isAbsent(xmlElm.text)
                elm.text = xmlElm.text;
            end
            kids = xmlElm.getchildren();
            for i = 1:numel(kids)
                child = mat2ppt.oxml.BaseOxmlElement.from_xml_element(kids{i});
                if ~mat2ppt.isAbsent(kids{i}.tail)
                    child.tail = kids{i}.tail;
                end
                elm.append(child);
            end
        end
    end
end
