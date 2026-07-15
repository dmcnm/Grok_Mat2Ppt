classdef TableCell < handle
%TABLECELL  Table cell (a:tc).
%
%   Ported from python-pptx table._Cell (P7-W1 subset)

    properties (Access = private)
        tc_
        parent_
    end

    properties (Dependent)
        text
    end

    methods
        function obj = TableCell(tcElm, parent)
            arguments
                tcElm (1,1) mat2ppt.oxml.XmlElement
                parent
            end
            obj.tc_ = tcElm;
            obj.parent_ = parent;
        end

        function e = element(obj)
            e = obj.tc_;
        end

        function tf = text_frame(obj)
            tx = obj.txBody_();
            if isempty(tx)
                tx = mat2ppt.oxml.shapes.new_tc_txBody_();
                % insert before tcPr if present
                kids = obj.tc_.getchildren();
                tcPr = [];
                for i = 1:numel(kids)
                    if strcmp(char(kids{i}.localName()), "tcPr")
                        tcPr = kids{i};
                        break
                    end
                end
                if isempty(tcPr)
                    obj.tc_.append(tx);
                else
                    obj.tc_.remove(tcPr);
                    obj.tc_.append(tx);
                    obj.tc_.append(tcPr);
                end
            end
            tf = mat2ppt.text.TextFrame(tx, obj);
        end

        function t = get.text(obj)
            t = string(obj.text_frame().text);
        end

        function set.text(obj, value)
            obj.text_frame().text = value;
        end
    end

    methods (Access = private)
        function tx = txBody_(obj)
            tx = obj.tc_.find("a:txBody");
            if ~isempty(tx), return; end
            kids = obj.tc_.getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "txBody")
                    tx = kids{i}; return
                end
            end
            tx = [];
        end
    end
end
