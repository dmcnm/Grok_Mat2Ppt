function tbl = new_tbl_(rows, cols, widthEmu, heightEmu)
%NEW_TBL_  a:tbl with grid + rows/cells (python CT_Table.new_tbl).

    rows = double(rows);
    cols = double(cols);
    widthEmu = double(widthEmu);
    heightEmu = double(heightEmu);

    tbl = mat2ppt.oxml.OxmlElement("a:tbl");
    tblPr = mat2ppt.oxml.OxmlElement("a:tblPr");
    tblPr.set("firstRow", "1");
    tblPr.set("bandRow", "1");
    styleId = mat2ppt.oxml.OxmlElement("a:tableStyleId");
    styleId.text = "{5C22544A-7EE6-4342-B048-85BDC9FD1C3A}";
    tblPr.append(styleId);
    tbl.append(tblPr);

    tblGrid = mat2ppt.oxml.OxmlElement("a:tblGrid");
    colwidth = floor(widthEmu / cols);
    for c = 1:cols
        w = colwidth;
        if c == cols
            w = widthEmu - ((cols - 1) * colwidth);
        end
        gridCol = mat2ppt.oxml.OxmlElement("a:gridCol");
        gridCol.set("w", char(string(round(w))));
        tblGrid.append(gridCol);
    end
    tbl.append(tblGrid);

    rowheight = floor(heightEmu / rows);
    for r = 1:rows
        h = rowheight;
        if r == rows
            h = heightEmu - ((rows - 1) * rowheight);
        end
        tr = mat2ppt.oxml.OxmlElement("a:tr");
        tr.set("h", char(string(round(h))));
        for c = 1:cols
            tr.append(mat2ppt.oxml.shapes.new_tc_());
        end
        tbl.append(tr);
    end
end
