classdef BaseShape < mat2ppt.shared.ParentedElementProxy
%BASESHAPE  Common shape members.
%
%   Ported from python-pptx 1.0.2: src/pptx/shapes/base.py::BaseShape

    properties (Access = protected)
        sp_
    end

    properties (Dependent)
        name
        left
        top
        width
        height
        rotation
    end

    methods
        function obj = BaseShape(sp, parent)
            arguments
                sp (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj@mat2ppt.shared.ParentedElementProxy(sp, parent);
            obj.sp_ = sp;
        end

        function n = shape_id(obj)
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr)
                n = [];
                return
            end
            raw = cNvPr.get("id");
            if mat2ppt.isAbsent(raw), n = []; else, n = str2double(raw); end
        end

        function n = get.name(obj)
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr), n = ""; return; end
            raw = cNvPr.get("name");
            if mat2ppt.isAbsent(raw), n = ""; else, n = string(raw); end
        end
        function set.name(obj, value)
            cNvPr = obj.find_cNvPr_();
            if isempty(cNvPr)
                error("mat2ppt:InvalidXmlError", "Shape has no cNvPr for name");
            end
            cNvPr.set("name", char(string(value)));
        end

        function v = get.left(obj), v = obj.get_xfrm_len_("x"); end
        function set.left(obj, v), obj.set_xfrm_len_("x", v); end
        function v = get.top(obj), v = obj.get_xfrm_len_("y"); end
        function set.top(obj, v), obj.set_xfrm_len_("y", v); end
        function v = get.width(obj)
            v = obj.get_xfrm_len_("cx");
        end
        function set.width(obj, v), obj.set_xfrm_len_("cx", v); end
        function v = get.height(obj)
            v = obj.get_xfrm_len_("cy");
        end
        function set.height(obj, v), obj.set_xfrm_len_("cy", v); end

        function v = width_emu(obj)
            %WIDTH_EMU  Explicit accessor (avoids any .width ambiguity).
            v = obj.get_xfrm_len_("cx");
        end
        function v = height_emu(obj)
            v = obj.get_xfrm_len_("cy");
        end

        function v = get.rotation(obj)
            xfrm = obj.find_xfrm_();
            if isempty(xfrm)
                v = 0;
                return
            end
            raw = xfrm.get("rot");
            if mat2ppt.isAbsent(raw)
                v = 0;
            else
                v = mat2ppt.oxml.simpletypes.ST_Angle.from_xml(raw);
            end
        end
        function set.rotation(obj, value)
            xfrm = obj.ensure_xfrm_();
            xfrm.set("rot", mat2ppt.oxml.simpletypes.ST_Angle.to_xml(value));
        end

        function tf = has_text_frame(obj)
            tf = false;
        end

        function tf = is_placeholder(obj)
            tf = ~isempty(obj.find_ph_());
        end

        function e = shape_element(obj)
            e = obj.sp_;
        end
    end

    methods (Access = protected)
        function cNvPr = find_cNvPr_(obj)
            cNvPr = [];
            kids = obj.sp_.getchildren();
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                if startsWith(string(ln), "nv")
                    c = kids{i}.find("p:cNvPr");
                    if ~isempty(c), cNvPr = c; return; end
                    gc = kids{i}.getchildren();
                    for j = 1:numel(gc)
                        if strcmp(char(gc{j}.localName()), "cNvPr")
                            cNvPr = gc{j};
                            return
                        end
                    end
                end
            end
        end

        function ph = find_ph_(obj)
            ph = [];
            r = mat2ppt.oxml.evaluate_xpath(obj.sp_, ".//p:ph");
            if ~isempty(r), ph = r{1}; end
        end

        function xfrm = find_xfrm_(obj)
            xfrm = [];
            r = mat2ppt.oxml.evaluate_xpath(obj.sp_, ".//a:xfrm");
            if ~isempty(r), xfrm = r{1}; end
        end

        function xfrm = ensure_xfrm_(obj)
            xfrm = obj.find_xfrm_();
            if ~isempty(xfrm), return; end
            spPr = mat2ppt.oxml.shapes.ensure_spPr(obj.sp_);
            xfrm = mat2ppt.oxml.shapes.get_or_add_xfrm(spPr);
        end

        function L = get_xfrm_len_(obj, attr)
            xfrm = obj.find_xfrm_();
            if isempty(xfrm)
                L = mat2ppt.util.Emu(0);
                return
            end
            attr = char(string(attr));
            want = "off";
            if strcmp(attr, "cx") || strcmp(attr, "cy")
                want = "ext";
            end
            node = [];
            kids = xfrm.getchildren();
            for i = 1:numel(kids)
                ln = char(kids{i}.localName());
                if strcmp(ln, want)
                    node = kids{i};
                    break
                end
            end
            if isempty(node)
                L = mat2ppt.util.Emu(0);
                return
            end
            raw = node.get(attr);
            if mat2ppt.isAbsent(raw) || (ischar(raw) && isempty(raw))
                L = mat2ppt.util.Emu(0);
            else
                L = mat2ppt.util.Emu(str2double(string(raw)));
            end
        end

        function set_xfrm_len_(obj, attr, value)
            emu = double(mat2ppt.util.Length.toEmuInt_(value));
            xfrm = obj.ensure_xfrm_();
            if any(strcmp(attr, {"x", "y"}))
                off = xfrm.find("a:off");
                if isempty(off)
                    off = mat2ppt.oxml.OxmlElement("a:off");
                    if mat2ppt.isAbsent(off.get("x")), off.set("x", "0"); end
                    if mat2ppt.isAbsent(off.get("y")), off.set("y", "0"); end
                    xfrm.append(off);
                end
                off.set(attr, char(string(round(emu))));
            else
                ext = xfrm.find("a:ext");
                if isempty(ext)
                    ext = mat2ppt.oxml.OxmlElement("a:ext");
                    if mat2ppt.isAbsent(ext.get("cx")), ext.set("cx", "0"); end
                    if mat2ppt.isAbsent(ext.get("cy")), ext.set("cy", "0"); end
                    xfrm.append(ext);
                end
                ext.set(attr, char(string(round(emu))));
            end
        end
    end
end
