classdef Test_r9_w3_external_corpus < matlab.unittest.TestCase
    %TEST_R9_W3_EXTERNAL_CORPUS  Open/save/reopen third-party .pptx sample (R9-W3).
    %
    %   Fixtures: workspace validation/mat2ppt/references/external_corpus/*.pptx

    methods (Test)
        function open_save_reopen_each_fixture(tc)
            corpusDir = Test_r9_w3_external_corpus.corpus_dir_();
            tc.assumeTrue(isfolder(corpusDir), "external_corpus folder missing");
            files = dir(fullfile(corpusDir, "*.pptx"));
            tc.assumeTrue(~isempty(files), "no .pptx fixtures staged");

            outDir = fullfile(tempdir, "mat2ppt_r9_corpus_rt");
            if ~isfolder(outDir), mkdir(outDir); end
            cleaner = onCleanup(@() Test_r9_w3_external_corpus.rmdir_quiet_(outDir)); %#ok<NASGU>

            results = struct("file", {}, "ok", {}, "stage", {}, "error", {}, ...
                "parts_in", {}, "parts_out", {}, "parts_common", {}, ...
                "n_only_in", {}, "n_only_out", {});
            nOk = 0;
            for i = 1:numel(files)
                name = files(i).name;
                src = char(fullfile(corpusDir, name));
                dst = char(fullfile(outDir, ['rt_' name]));
                rec = struct( ...
                    "file", name, "ok", false, "stage", "init", "error", "", ...
                    "parts_in", 0, "parts_out", 0, "parts_common", 0, ...
                    "n_only_in", 0, "n_only_out", 0);
                try
                    rec.stage = "open";
                    prs = mat2ppt.Presentation(src);
                    rec.stage = "list_in";
                    inMap = mat2ppt.opc.read_zip_blobs(src);
                    rec.parts_in = numel(inMap.keys);
                    rec.stage = "save";
                    prs.save(dst);
                    rec.stage = "reopen";
                    prs2 = mat2ppt.Presentation(dst); %#ok<NASGU>
                    rec.stage = "list_out";
                    outMap = mat2ppt.opc.read_zip_blobs(dst);
                    rec.parts_out = numel(outMap.keys);
                    inKeys = string(sort(inMap.keys));
                    outKeys = string(sort(outMap.keys));
                    rec.parts_common = numel(intersect(inKeys, outKeys));
                    rec.n_only_in = numel(setdiff(inKeys, outKeys));
                    rec.n_only_out = numel(setdiff(outKeys, inKeys));
                    rec.stage = "done";
                    rec.ok = true;
                    nOk = nOk + 1;
                    fprintf(1, "OK  %s  parts_in=%d out=%d common=%d onlyIn=%d onlyOut=%d\n", ...
                        name, rec.parts_in, rec.parts_out, rec.parts_common, ...
                        rec.n_only_in, rec.n_only_out);
                catch ME
                    rec.error = sprintf("%s: %s", ME.identifier, ME.message);
                    rec.ok = false;
                    fprintf(1, "FAIL %s @%s  %s\n", name, rec.stage, rec.error);
                end
                results(end+1) = rec; %#ok<AGROW>
            end

            try
                reportPath = fullfile(corpusDir, "REPORT.json");
                payload = struct( ...
                    "n_total", numel(results), ...
                    "n_ok", nOk, ...
                    "n_fail", numel(results) - nOk, ...
                    "results", results);
                fid = fopen(reportPath, "w");
                if fid >= 0
                    fwrite(fid, jsonencode(payload, "PrettyPrint", true));
                    fclose(fid);
                end
            catch
            end

            fprintf(1, "\nR9-W3 corpus: %d/%d open-save-reopen OK (%d fail)\n", ...
                nOk, numel(results), numel(results) - nOk);

            for i = 1:numel(results)
                tc.verifyTrue(results(i).ok, ...
                    sprintf("%s failed at %s: %s", results(i).file, results(i).stage, results(i).error));
            end
        end
    end

    methods (Static)
        function d = corpus_dir_()
            cands = { ...
                'C:\Users\dougl\Grok\MSOffice\validation\mat2ppt\references\external_corpus', ...
                '/mnt/c/Users/dougl/grok/MSOffice/validation/mat2ppt/references/external_corpus'};
            d = "";
            for i = 1:numel(cands)
                if isfolder(cands{i})
                    d = cands{i};
                    return
                end
            end
        end

        function rmdir_quiet_(d)
            try
                if isfolder(d), rmdir(d, "s"); end
            catch
            end
        end
    end
end
