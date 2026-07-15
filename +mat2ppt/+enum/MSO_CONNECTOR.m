classdef MSO_CONNECTOR
%MSO_CONNECTOR  Alias of mat2ppt.enum.MSO_CONNECTOR_TYPE.
%
%   Ported from python-pptx 1.0.2: MSO_CONNECTOR = MSO_CONNECTOR_TYPE

    properties (Constant)
        CURVE = mat2ppt.enum.MSO_CONNECTOR_TYPE.CURVE
        ELBOW = mat2ppt.enum.MSO_CONNECTOR_TYPE.ELBOW
        STRAIGHT = mat2ppt.enum.MSO_CONNECTOR_TYPE.STRAIGHT
        MIXED = mat2ppt.enum.MSO_CONNECTOR_TYPE.MIXED
    end

    methods (Static)
        function m = from_xml(xmlValue)
            m = mat2ppt.enum.MSO_CONNECTOR_TYPE.from_xml(xmlValue);
        end
        function x = to_xml(value)
            x = mat2ppt.enum.MSO_CONNECTOR_TYPE.to_xml(value);
        end
    end
end
