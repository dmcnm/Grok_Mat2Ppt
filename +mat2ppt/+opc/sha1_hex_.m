function h = sha1_hex_(data)
%SHA1_HEX_  Hex SHA-1 of uint8 data (lowercase).
    data = uint8(data(:));
    md = java.security.MessageDigest.getInstance("SHA-1");
    if ~isempty(data)
        md.update(data);
    end
    dig = typecast(md.digest(), "uint8");
    h = lower(sprintf("%02x", dig));
end
