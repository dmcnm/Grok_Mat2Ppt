classdef Test_r6_movie < matlab.unittest.TestCase
    %TEST_R6_MOVIE  Video / MediaPart / add_movie / timing (R6 DEF-010a).

    methods (Test)
        function video_from_path_sha1_and_ext(tc)
            moviePath = Test_r6_movie.fake_movie_path_();
            v = mat2ppt.media.Video.from_path(moviePath, mat2ppt.opc.CONTENT_TYPE.MP4);
            tc.verifyEqual(char(v.ext()), 'mp4');
            tc.verifyTrue(startsWith(string(v.filename()), "fake_movie"));
            h = v.sha1();
            tc.verifyEqual(strlength(string(h)), 40);
            tc.verifyGreaterThan(numel(v.blob()), 0);
        end

        function media_part_new_and_reuse(tc)
            moviePath = Test_r6_movie.fake_movie_path_();
            v = mat2ppt.media.Video.from_path(moviePath, mat2ppt.opc.CONTENT_TYPE.MP4);
            prs = mat2ppt.Presentation();
            pkg = prs.package();
            pn1 = mat2ppt.parts.MediaPart.get_or_add_media_partname(pkg, v);
            pn2 = mat2ppt.parts.MediaPart.get_or_add_media_partname(pkg, v);
            tc.verifyEqual(char(pn1), char(pn2));
            tc.verifyTrue(contains(string(pn1), "/ppt/media/media"));
            blob = pkg.get_blob(pn1);
            tc.verifyEqual(numel(blob), numel(v.blob()));
        end

        function add_movie_api_and_package(tc)
            moviePath = Test_r6_movie.fake_movie_path_();
            prs = mat2ppt.Presentation();
            s = prs.slides().add_slide(prs.slide_layouts().item(1));
            movie = s.shapes().add_movie(moviePath, ...
                mat2ppt.util.Inches(1), mat2ppt.util.Inches(1), ...
                mat2ppt.util.Inches(4), mat2ppt.util.Inches(3), ...
                [], mat2ppt.opc.CONTENT_TYPE.MP4);
            tc.verifyEqual(movie.shape_type().value, mat2ppt.enum.MSO_SHAPE_TYPE.MEDIA.value);
            tc.verifyEqual(movie.media_type().value, mat2ppt.enum.PP_MEDIA_TYPE.MOVIE.value);
            % videoFile in shape tree
            r = mat2ppt.oxml.evaluate_xpath(movie.shape_element(), ".//a:videoFile");
            tc.verifyGreaterThan(numel(r), 0);
            % timing on slide
            timing = mat2ppt.oxml.evaluate_xpath(s.element(), "./p:timing");
            tc.verifyGreaterThan(numel(timing), 0);
            vids = mat2ppt.oxml.evaluate_xpath(s.element(), ".//p:video");
            tc.verifyGreaterThan(numel(vids), 0);

            outPath = [tempname() '.pptx'];
            cleaner = onCleanup(@() Test_r6_movie.delete_if_(outPath));
            prs.save(char(outPath));
            m = mat2ppt.opc.read_zip_blobs(outPath);
            keys = m.keys;
            hasMedia = false;
            hasImage = false;
            for i = 1:numel(keys)
                k = keys{i};
                if startsWith(string(k), "ppt/media/media")
                    hasMedia = true;
                end
                if startsWith(string(k), "ppt/media/image")
                    hasImage = true;
                end
            end
            tc.verifyTrue(hasMedia, "media part present");
            tc.verifyTrue(hasImage, "poster image present");

            % slide rels include MEDIA + VIDEO types
            srel = "";
            for i = 1:numel(keys)
                k = string(keys{i});
                if k == "ppt/slides/_rels/slide1.xml.rels" || endsWith(k, "slide1.xml.rels")
                    b = m(keys{i});
                    if isnumeric(b)
                        srel = string(native2unicode(uint8(b(:))', "UTF-8"));
                    else
                        srel = string(b);
                    end
                    break
                end
            end
            tc.verifyTrue(strlength(srel) > 0, "slide1 rels present");
            tc.verifyTrue(contains(srel, "office/2007/relationships/media"), "MEDIA rel");
            tc.verifyTrue(contains(srel, "relationships/video"), "VIDEO rel");
        end
    end

    methods (Static, Access = private)
        function p = fake_movie_path_()
            d = tempdir;
            p = fullfile(d, "fake_movie.mp4");
            fid = fopen(p, "wb");
            blob = [uint8([0 0 0 24]), uint8('ftyp'), uint8('mp42'), ...
                uint8([0 0 0 0]), uint8('mp42'), uint8('isom'), ...
                uint8('mat2ppt-r6-test-blob-xxxxxxxx')];
            fwrite(fid, blob, "uint8");
            fclose(fid);
        end

        function delete_if_(p)
            if isfile(p), delete(p); end
        end
    end
end
