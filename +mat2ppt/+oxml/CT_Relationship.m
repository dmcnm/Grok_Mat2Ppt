classdef CT_Relationship < mat2ppt.oxml.BaseOxmlElement
%CT_RELATIONSHIP  pr:Relationship element.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::CT_Relationship

    properties (Dependent)
        rId
        reltype
        target_ref
        targetMode
    end

    methods
        function obj = CT_Relationship(tag)
            if nargin < 1
                tag = "pr:Relationship";
            end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function v = get.rId(obj)
            v = obj.get_attr_value("Id", "mat2ppt.oxml.simpletypes.XsdId");
        end
        function set.rId(obj, v)
            obj.set_attr_value("Id", v, "mat2ppt.oxml.simpletypes.XsdId");
        end

        function v = get.reltype(obj)
            v = obj.get_attr_value("Type", "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end
        function set.reltype(obj, v)
            obj.set_attr_value("Type", v, "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end

        function v = get.target_ref(obj)
            v = obj.get_attr_value("Target", "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end
        function set.target_ref(obj, v)
            obj.set_attr_value("Target", v, "mat2ppt.oxml.simpletypes.XsdAnyUri");
        end

        function v = get.targetMode(obj)
            raw = obj.get("TargetMode");
            if mat2ppt.isAbsent(raw)
                v = "Internal";
            else
                v = mat2ppt.oxml.simpletypes.ST_TargetMode.from_xml(raw);
            end
        end
        function set.targetMode(obj, v)
            if strcmp(char(string(v)), "Internal")
                obj.removeAttr("TargetMode");
            else
                obj.set_attr_value("TargetMode", v, "mat2ppt.oxml.simpletypes.ST_TargetMode");
            end
        end
    end

    methods (Static)
        function obj = new(rId, reltype, targetRef, targetMode)
            if nargin < 4
                targetMode = "Internal";
            end
            PR = "http://schemas.openxmlformats.org/package/2006/relationships";
            obj = mat2ppt.oxml.CT_Relationship(sprintf("{%s}Relationship", PR));
            obj.setNsDecls({"", PR});
            obj.rId = rId;
            obj.reltype = reltype;
            obj.target_ref = targetRef;
            obj.targetMode = targetMode;
        end
    end
end
