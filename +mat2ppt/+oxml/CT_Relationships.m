classdef CT_Relationships < mat2ppt.oxml.BaseOxmlElement
%CT_RELATIONSHIPS  pr:Relationships root.
%
%   Ported from python-pptx 1.0.2: src/pptx/opc/oxml.py::CT_Relationships

    methods
        function obj = CT_Relationships(tag)
            if nargin < 1
                tag = "pr:Relationships";
            end
            obj@mat2ppt.oxml.BaseOxmlElement(tag);
        end

        function lst = relationship_lst(obj)
            lst = obj.child_list("pr:Relationship");
        end

        function rel = add_rel(obj, rId, reltype, target, isExternal)
            if nargin < 5
                isExternal = false;
            end
            if isExternal
                tm = "External";
            else
                tm = "Internal";
            end
            rel = mat2ppt.oxml.CT_Relationship.new(rId, reltype, target, tm);
            % strip root ns from child for lxml-like serialize (child inherits default)
            % keep as full element; serialize uses tree ns plan
            obj.append(rel);
        end
    end

    methods (Static)
        function obj = new()
            PR = "http://schemas.openxmlformats.org/package/2006/relationships";
            obj = mat2ppt.oxml.CT_Relationships(sprintf("{%s}Relationships", PR));
            obj.setNsDecls({"", PR});
        end
    end
end
