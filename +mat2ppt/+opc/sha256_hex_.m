function h = sha256_hex_(data)
%SHA256_HEX_  Hex SHA-256 of uint8 data.
    data = uint8(data(:));
    md = java.security.MessageDigest.getInstance("SHA-256");
    md.update(data);
    dig = typecast(md.digest(), "uint8");
    h = lower(sprintf("%02x", dig));
end
