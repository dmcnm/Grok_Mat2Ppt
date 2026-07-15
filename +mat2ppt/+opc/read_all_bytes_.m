function b = read_all_bytes_(istrm)
%READ_ALL_BYTES_  Drain Java InputStream to uint8 row vector.

    bos = java.io.ByteArrayOutputStream();
    buffer = javaArray("byte", 8192);
    while true
        n = istrm.read(buffer);
        if n <= 0
            break
        end
        bos.write(buffer, 0, n);
    end
    jba = bos.toByteArray(); % Java byte[] as int8 in MATLAB
    if isempty(jba)
        b = uint8([]);
        return
    end
    % Convert signed Java bytes to uint8
    b = typecast(jba(:), "uint8")';
end
