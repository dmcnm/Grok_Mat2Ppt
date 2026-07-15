function blobMap = read_zip_blobs(pkgPath)
%READ_ZIP_BLOBS  Read .pptx zip into containers.Map membername -> uint8 row.
%
%   Uses MATLAB unzip to a temp dir for reliable byte fidelity on Windows.

    pkgPath = char(string(pkgPath));
    if ~isfile(pkgPath)
        error("mat2ppt:PackageNotFoundError", "Package not found at '%s'.", pkgPath);
    end

    tmpDir = tempname;
    mkdir(tmpDir);
    cleanup = onCleanup(@() rmdir(tmpDir, "s"));
    unzip(pkgPath, tmpDir);

    blobMap = containers.Map("KeyType", "char", "ValueType", "any");
    files = dir(fullfile(tmpDir, "**", "*"));
    for i = 1:numel(files)
        if files(i).isdir
            continue
        end
        full = fullfile(files(i).folder, files(i).name);
        rel = erase(full, [tmpDir filesep]);
        rel = strrep(rel, filesep, "/");
        fid = fopen(full, "r");
        assert(fid >= 0);
        cleaner = onCleanup(@() fclose(fid));
        data = fread(fid, inf, "*uint8");
        clear cleaner
        blobMap(rel) = data(:)';
    end
end
