classdef Test_p2_package_shell < matlab.unittest.TestCase
    % Phase 2: proxies, coreprops probes, image/media load path

    methods (Test)
        function proxies(testCase)
            e = mat2ppt.oxml.OxmlElement("a:t");
            p = mat2ppt.shared.ElementProxy(e);
            testCase.verifyEqual(p.element().tag, e.tag);
            parent = struct("part", "pkg-part-stub");
            pe = mat2ppt.shared.ParentedElementProxy(e, parent);
            testCase.verifyEqual(pe.parent().part, "pkg-part-stub");
            pep = mat2ppt.shared.PartElementProxy(e, "THEPART");
            testCase.verifyEqual(pep.part(), "THEPART");
        end

        function corePropsProbeMatrix(testCase)
            prs = mat2ppt.Presentation();
            cp = prs.core_properties();
            fields = { ...
                "author", "Mat2Ppt Author"; ...
                "category", "Cat"; ...
                "comments", "Note"; ...
                "content_status", "Draft"; ...
                "identifier", "ID-1"; ...
                "keywords", "a,b"; ...
                "language", "en-US"; ...
                "last_modified_by", "Tester"; ...
                "subject", "Subj"; ...
                "title", "Title X"; ...
                "version", "1.2.3" ...
                };
            for i = 1:size(fields, 1)
                name = fields{i, 1};
                val = fields{i, 2};
                cp.(name) = val;
                testCase.verifyEqual(cp.(name), string(val));
            end
            cp.revision = 7;
            testCase.verifyEqual(cp.revision, 7);
            out = [tempname() '.pptx'];
            cleaner = onCleanup(@() delete_if_(out));
            prs.save(out);
            prs2 = mat2ppt.Presentation(out);
            cp2 = prs2.core_properties();
            testCase.verifyEqual(cp2.author, "Mat2Ppt Author");
            testCase.verifyEqual(cp2.title, "Title X");
            testCase.verifyEqual(cp2.revision, 7);
        end

        function imagePartLoadOpaque(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            blob = uint8([255 216 255 224]);  % fake jpeg header bytes
            part = mat2ppt.opc.PartFactory.load( ...
                "/ppt/media/image1.jpeg", CT.JPEG, [], blob);
            testCase.verifyTrue(isa(part, "mat2ppt.parts.ImagePart"));
            testCase.verifyEqual(part.blob(), blob(:));
            % opaque: save path of real package keeps thumbnail jpeg L1
            oracle = 'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\m1_default_open_save\oracle.pptx';
            oMap = mat2ppt.opc.read_zip_blobs(oracle);
            testCase.verifyTrue(isKey(oMap, "docProps/thumbnail.jpeg"));
            thumb = oMap("docProps/thumbnail.jpeg");
            ip = mat2ppt.parts.ImagePart.load( ...
                "/docProps/thumbnail.jpeg", CT.JPEG, [], thumb);
            testCase.verifyEqual(ip.blob(), uint8(thumb(:)));
        end

        function mediaPartLoadOpaque(testCase)
            CT = mat2ppt.opc.CONTENT_TYPE;
            blob = uint8(1:16);
            part = mat2ppt.opc.PartFactory.load( ...
                "/ppt/media/media1.mp4", CT.MP4, [], blob);
            testCase.verifyTrue(isa(part, "mat2ppt.parts.MediaPart"));
            testCase.verifyEqual(part.blob(), blob(:));
        end

        function excIds(testCase)
            testCase.verifyEqual(string(mat2ppt.exc.PackageNotFoundError), ...
                "mat2ppt:PackageNotFoundError");
            testCase.verifyError(@() mat2ppt.Presentation("Z:\no\such\file.pptx"), ...
                "mat2ppt:PackageNotFoundError");
        end
    end
end

function delete_if_(p)
    if isfile(p), delete(p); end
end
