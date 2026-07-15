function write_zip_blobs(pkgPath, blobMap)
%WRITE_ZIP_BLOBS  Write map of membername->uint8 using MATLAB zip.

    pkgPath = char(string(pkgPath));
    tmpDir = tempname;
    mkdir(tmpDir);
    cleanup = onCleanup(@() rmdir(tmpDir, "s"));

    keys = blobMap.keys;
    n = numel(keys);
    relNames = strings(n, 1);
    for i = 1:n
        name = keys{i};
        if isstring(name), name = char(name); end
        data = uint8(blobMap(keys{i}));
        data = data(:);
        dest = fullfile(tmpDir, strrep(name, "/", filesep));
        parent = fileparts(dest);
        if ~isempty(parent) && ~strcmp(parent, tmpDir) && ~isfolder(parent)
            mkdir(parent);
        end
        fid = fopen(dest, "w");
        if fid < 0
            error("mat2ppt:IOError", "Cannot write temp part %s", dest);
        end
        fwrite(fid, data, "uint8");
        fclose(fid);
        relNames(i) = string(strrep(name, "/", filesep));
    end

    % MATLAB zip is reliable with .zip extension; rename after.
    zipTmp = [tempname() '.zip'];
    zip(char(zipTmp), cellstr(relNames), tmpDir);
    if isfile(pkgPath)
        delete(pkgPath);
    end
    [parentOut, ~] = fileparts(pkgPath);
    if ~isempty(parentOut) && ~isfolder(parentOut)
        mkdir(parentOut);
    end
    movefile(zipTmp, pkgPath, "f");
end
