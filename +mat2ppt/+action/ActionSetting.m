classdef ActionSetting < handle
%ACTIONSETTING  Click/hover action on a shape (R4).
%
%   Ported from python-pptx 1.0.2: src/pptx/action.py::ActionSetting

    properties (Access = private)
        cNvPr_
        shape_
        hover_ (1,1) logical = false
    end

    methods
        function obj = ActionSetting(cNvPr, shape, hover)
            arguments
                cNvPr (1,1) mat2ppt.oxml.XmlElement
                shape
                hover (1,1) logical = false
            end
            obj.cNvPr_ = cNvPr;
            obj.shape_ = shape;
            obj.hover_ = hover;
        end

        function a = action(obj)
            %ACTION  PP_ACTION member for this click/hover.
            h = obj.find_hlink_();
            if isempty(h)
                a = mat2ppt.enum.PP_ACTION.NONE;
                return
            end
            actAttr = h.get("action");
            if mat2ppt.isAbsent(actAttr)
                a = mat2ppt.enum.PP_ACTION.HYPERLINK;
                return
            end
            verb = mat2ppt.action.ActionSetting.action_verb_(char(string(actAttr)));
            if strcmp(verb, "hlinkshowjump")
                fields = mat2ppt.action.ActionSetting.action_fields_(char(string(actAttr)));
                if isfield(fields, "jump")
                    switch lower(fields.jump)
                        case "firstslide", a = mat2ppt.enum.PP_ACTION.FIRST_SLIDE; return
                        case "lastslide", a = mat2ppt.enum.PP_ACTION.LAST_SLIDE; return
                        case "lastslideviewed", a = mat2ppt.enum.PP_ACTION.LAST_SLIDE_VIEWED; return
                        case "nextslide", a = mat2ppt.enum.PP_ACTION.NEXT_SLIDE; return
                        case "previousslide", a = mat2ppt.enum.PP_ACTION.PREVIOUS_SLIDE; return
                        case "endshow", a = mat2ppt.enum.PP_ACTION.END_SHOW; return
                    end
                end
                a = mat2ppt.enum.PP_ACTION.NONE;
                return
            end
            switch string(verb)
                case "hlinksldjump", a = mat2ppt.enum.PP_ACTION.NAMED_SLIDE;
                case "hlinkpres", a = mat2ppt.enum.PP_ACTION.PLAY;
                case "hlinkfile", a = mat2ppt.enum.PP_ACTION.OPEN_FILE;
                case "customshow", a = mat2ppt.enum.PP_ACTION.NAMED_SLIDE_SHOW;
                case "ole", a = mat2ppt.enum.PP_ACTION.OLE_VERB;
                case "macro", a = mat2ppt.enum.PP_ACTION.RUN_MACRO;
                case "program", a = mat2ppt.enum.PP_ACTION.RUN_PROGRAM;
                otherwise
                    if mat2ppt.isAbsent(verb) || strlength(string(verb)) == 0
                        a = mat2ppt.enum.PP_ACTION.HYPERLINK;
                    else
                        a = mat2ppt.enum.PP_ACTION.NONE;
                    end
            end
        end

        function h = hyperlink(obj)
            %HYPERLINK  |ShapeHyperlink| for address R/W.
            h = mat2ppt.action.ShapeHyperlink(obj.cNvPr_, obj.shape_, obj.hover_);
        end

        function s = target_slide(obj)
            %TARGET_SLIDE  Slide target for jump actions, or [].
            act = obj.action();
            PP = mat2ppt.enum.PP_ACTION;
            jumps = [PP.FIRST_SLIDE.value, PP.LAST_SLIDE.value, PP.NEXT_SLIDE.value, ...
                PP.PREVIOUS_SLIDE.value, PP.NAMED_SLIDE.value];
            if ~any(act.value == jumps)
                s = [];
                return
            end
            slides = obj.presentation_slides_();
            if act.value == PP.FIRST_SLIDE.value
                s = slides.item(1);
            elseif act.value == PP.LAST_SLIDE.value
                s = slides.item(slides.length);
            elseif act.value == PP.NEXT_SLIDE.value
                idx = slides.index(obj.owning_slide_());
                if idx >= slides.length
                    error("mat2ppt:ValueError", "no next slide");
                end
                s = slides.item(idx + 1);
            elseif act.value == PP.PREVIOUS_SLIDE.value
                idx = slides.index(obj.owning_slide_());
                if idx <= 1
                    error("mat2ppt:ValueError", "no previous slide");
                end
                s = slides.item(idx - 1);
            else
                % NAMED_SLIDE via rId
                h = obj.find_hlink_();
                if isempty(h), s = []; return; end
                rid = mat2ppt.opc.rId_attr(h);
                if isempty(rid), s = []; return; end
                [pkg, pn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
                tgt = mat2ppt.opc.related_partname(pkg, pn, rid);
                if isempty(tgt), s = []; return; end
                % find slide by partname
                slides = obj.presentation_slides_();
                s = [];
                for i = 1:slides.length
                    if strcmp(char(slides.item(i).partname()), char(string(tgt)))
                        s = slides.item(i);
                        return
                    end
                end
            end
        end

        function set_target_slide(obj, slide)
            %SET_TARGET_SLIDE  Internal slide jump (or [] to clear).
            obj.clear_click_action_();
            if mat2ppt.isAbsent(slide) || isempty(slide)
                return
            end
            h = obj.ensure_hlinkClick_();
            h.set("action", "ppaction://hlinksldjump");
            [pkg, srcPn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
            tgtPn = slide.partname();
            rId = pkg.add_relationship(srcPn, mat2ppt.opc.RELATIONSHIP_TYPE.SLIDE, tgtPn);
            h.set(mat2ppt.oxml.qn("r:id"), rId);
        end
    end

    methods (Access = private)
        function h = find_hlink_(obj)
            tag = "hlinkClick";
            if obj.hover_, tag = "hlinkHover"; end
            h = obj.cNvPr_.find("a:" + string(tag));
            if ~isempty(h), return; end
            kids = obj.cNvPr_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), tag)
                    h = kids{i}; return
                end
            end
            h = [];
        end

        function h = ensure_hlinkClick_(obj)
            h = obj.find_hlink_();
            if ~isempty(h), return; end
            h = mat2ppt.oxml.OxmlElement("a:hlinkClick");
            obj.cNvPr_.append(h);
        end

        function clear_click_action_(obj)
            h = obj.find_hlink_();
            if isempty(h), return; end
            rid = mat2ppt.opc.rId_attr(h);
            if ~isempty(rid)
                [pkg, pn] = mat2ppt.action.ActionSetting.pkg_part_(obj.shape_);
                pkg.drop_relationship(pn, rid);
            end
            obj.cNvPr_.remove(h);
        end

        function slides = presentation_slides_(obj)
            sld = obj.owning_slide_();
            slides = sld.presentation().slides();
        end

        function sld = owning_slide_(obj)
            p = obj.shape_;
            for k = 1:16
                if isa(p, "mat2ppt.slide.Slide")
                    sld = p; return
                end
                if ismethod(p, "parent")
                    p = p.parent();
                elseif ismethod(p, "presentation") && ~isa(p, "mat2ppt.Presentation")
                    % shape parent is often Slide
                    try
                        sld = p; return
                    catch
                    end
                    p = p.presentation();
                else
                    break
                end
            end
            % BaseShape parent_ is slide
            if ismethod(obj.shape_, "parent")
                sld = obj.shape_.parent();
                return
            end
            error("mat2ppt:AttributeError", "Cannot resolve owning slide for ActionSetting");
        end
    end

    methods (Static)
        function verb = action_verb_(url)
            % ppaction://host?...
            if ~startsWith(string(url), "ppaction://")
                verb = [];
                return
            end
            rest = extractAfter(string(url), "ppaction://");
            parts = split(rest, "?");
            verb = char(parts(1));
        end

        function fields = action_fields_(url)
            fields = struct();
            if ~contains(string(url), "?"), return; end
            q = extractAfter(string(url), "?");
            pairs = split(q, "&");
            for i = 1:numel(pairs)
                kv = split(pairs(i), "=");
                if numel(kv) >= 2
                    fields.(matlab.lang.makeValidName(char(kv(1)))) = char(kv(2));
                end
            end
            % preserve jump key specifically
            if contains(string(url), "jump=")
                tok = regexp(char(string(url)), "jump=([^&]+)", "tokens", "once");
                if ~isempty(tok)
                    fields.jump = tok{1};
                end
            end
        end

        function [pkg, pn] = pkg_part_(shape)
            p = shape;
            for k = 1:16
                if ismethod(p, "part")
                    pr = p.part();
                    if isstruct(pr) && isfield(pr, "package") && isfield(pr, "partname")
                        pkg = pr.package;
                        pn = pr.partname;
                        return
                    end
                end
                if ismethod(p, "parent")
                    p = p.parent();
                elseif ismethod(p, "presentation")
                    break
                else
                    break
                end
            end
            error("mat2ppt:AttributeError", "Cannot resolve package part for action");
        end
    end
end
