classdef Test_p2_w2b_coreprops_datetime < matlab.unittest.TestCase
    % P2-W2b: created / modified / last_printed W3CDTF fidelity

    methods (Test)
        function parseOffsetCreated(testCase)
            % 2012-11-17T11:07:40-05:30 -> 16:37:40 (python twin)
            xml = sprintf([ ...
                '<?xml version=''1.0'' encoding=''UTF-8'' standalone=''yes''?>\n' ...
                '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" ' ...
                'xmlns:dc="http://purl.org/dc/elements/1.1/" ' ...
                'xmlns:dcterms="http://purl.org/dc/terms/" ' ...
                'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' ...
                '<dcterms:created xsi:type="dcterms:W3CDTF">2012-11-17T11:07:40-05:30</dcterms:created>' ...
                '</cp:coreProperties>']);
            cp = mat2ppt.parts.CoreProperties.from_xml_bytes(uint8(unicode2native(xml, "UTF-8")));
            d = cp.created;
            testCase.verifyTrue(isdatetime(d));
            testCase.verifyEqual(year(d), 2012);
            testCase.verifyEqual(month(d), 11);
            testCase.verifyEqual(day(d), 17);
            testCase.verifyEqual(hour(d), 16);
            testCase.verifyEqual(minute(d), 37);
            testCase.verifyEqual(second(d), 40);
        end

        function missingModifiedIsAbsent(testCase)
            xml = sprintf([ ...
                '<?xml version=''1.0'' encoding=''UTF-8'' standalone=''yes''?>\n' ...
                '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" ' ...
                'xmlns:dc="http://purl.org/dc/elements/1.1/" ' ...
                'xmlns:dcterms="http://purl.org/dc/terms/" ' ...
                'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>']);
            cp = mat2ppt.parts.CoreProperties.from_xml_bytes(uint8(unicode2native(xml, "UTF-8")));
            testCase.verifyTrue(mat2ppt.isAbsent(cp.modified));
        end

        function setCreatedWritesZAndXsiType(testCase)
            prs = mat2ppt.Presentation();
            cp = prs.core_properties();
            cp.created = datetime(2001, 2, 3, 4, 5, 0);
            el = cp.element();
            kids = el.getchildren();
            found = false;
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "created")
                    found = true;
                    testCase.verifyEqual(string(kids{i}.text), "2001-02-03T04:05:00Z");
                    XSI = "http://www.w3.org/2001/XMLSchema-instance";
                    xt = kids{i}.get(sprintf("{%s}type", XSI));
                    testCase.verifyEqual(string(xt), "dcterms:W3CDTF");
                end
            end
            testCase.verifyTrue(found);
            out = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(out));
            prs.save(out);
            prs2 = mat2ppt.Presentation(out);
            d2 = prs2.core_properties().created;
            testCase.verifyEqual(year(d2), 2001);
            testCase.verifyEqual(month(d2), 2);
            testCase.verifyEqual(day(d2), 3);
            testCase.verifyEqual(hour(d2), 4);
            testCase.verifyEqual(minute(d2), 5);
        end

        function setModifiedAndLastPrinted(testCase)
            prs = mat2ppt.Presentation();
            cp = prs.core_properties();
            cp.modified = datetime(2005, 4, 3, 2, 1, 0);
            cp.last_printed = datetime(2014, 6, 4, 4, 0, 0);
            testCase.verifyEqual(hour(cp.modified), 2);
            testCase.verifyEqual(day(cp.last_printed), 4);
            % lastPrinted has no xsi:type in python
            kids = cp.element().getchildren();
            for i = 1:numel(kids)
                if strcmp(char(kids{i}.localName()), "lastPrinted")
                    testCase.verifyEqual(string(kids{i}.text), "2014-06-04T04:00:00Z");
                    XSI = "http://www.w3.org/2001/XMLSchema-instance";
                    xt = kids{i}.get(sprintf("{%s}type", XSI), []);
                    testCase.verifyTrue(mat2ppt.isAbsent(xt));
                end
            end
        end

        function rejectNonDatetime(testCase)
            prs = mat2ppt.Presentation();
            cp = prs.core_properties();
            testCase.verifyError(@() setfield_created_bad_(cp), "mat2ppt:ValueError");
        end
    end
end

function setfield_created_bad_(cp)
    cp.created = "not-a-datetime";
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
