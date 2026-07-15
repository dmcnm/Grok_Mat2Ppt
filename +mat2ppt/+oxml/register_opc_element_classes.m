function register_opc_element_classes()
%REGISTER_OPC_ELEMENT_CLASSES  Register M1 opc CT_* element classes.
%
%   Ported from python-pptx 1.0.2: opc/oxml.py register_element_cls calls

    persistent done
    if ~isempty(done) && done
        return
    end
    mat2ppt.oxml.register_element_cls("ct:Default", "mat2ppt.oxml.CT_Default");
    mat2ppt.oxml.register_element_cls("ct:Override", "mat2ppt.oxml.CT_Override");
    mat2ppt.oxml.register_element_cls("ct:Types", "mat2ppt.oxml.CT_Types");
    mat2ppt.oxml.register_element_cls("pr:Relationship", "mat2ppt.oxml.CT_Relationship");
    mat2ppt.oxml.register_element_cls("pr:Relationships", "mat2ppt.oxml.CT_Relationships");
    done = true;
end
