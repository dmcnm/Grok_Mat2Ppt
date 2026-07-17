classdef TextFitter
%TEXTFITTER  Fit text into rectangular extents (point size search).
%
%   Ported from python-pptx 1.0.2: src/pptx/text/layout.py::TextFitter
%   Metrics: Java AWT font from TTF/OTF file (base MATLAB; no Pillow).

    methods (Static)
        function pt = best_fit_font_size(text, extents, maxSize, fontFile)
            %BEST_FIT_FONT_SIZE  Largest integer pt size <= maxSize that fits.
            arguments
                text
                extents  % {cxEmu, cyEmu} or [cx cy]
                maxSize (1,1) double
                fontFile
            end
            text = char(string(text));
            fontFile = char(string(fontFile));
            if iscell(extents)
                widthEmu = double(extents{1});
                heightEmu = double(extents{2});
            else
                widthEmu = double(extents(1));
                heightEmu = double(extents(2));
            end
            maxSize = floor(double(maxSize));
            if maxSize < 1
                pt = 1;
                return
            end
            best = 1;
            for sz = maxSize:-1:1
                if mat2ppt.text.TextFitter.fits_inside_(text, widthEmu, heightEmu, sz, fontFile)
                    best = sz;
                    break
                end
            end
            pt = best;
        end

        function [wEmu, hEmu] = rendered_size(text, pointSize, fontFile)
            %RENDERED_SIZE  (width,height) EMU for text at pointSize.
            text = char(string(text));
            if strlength(string(text)) == 0
                text = " ";
            end
            fontFile = char(string(fontFile));
            f = java.awt.Font.createFont(java.awt.Font.TRUETYPE_FONT, java.io.File(fontFile));
            f = f.deriveFont(single(pointSize));
            frc = java.awt.font.FontRenderContext(java.awt.geom.AffineTransform(), true, true);
            bounds = f.getStringBounds(text, frc);
            pxW = bounds.getWidth();
            pxH = bounds.getHeight();
            emuPerInch = 914400;
            pxPerInch = 72.0;
            wEmu = floor(double(pxW) / pxPerInch * emuPerInch);
            hEmu = floor(double(pxH) / pxPerInch * emuPerInch);
        end
    end

    methods (Static, Access = private)
        function tf = fits_inside_(text, widthEmu, heightEmu, pointSize, fontFile)
            lines = mat2ppt.text.TextFitter.wrap_lines_(text, widthEmu, pointSize, fontFile);
            [~, lineH] = mat2ppt.text.TextFitter.rendered_size("Ty", pointSize, fontFile);
            tf = (lineH * numel(lines)) <= heightEmu;
        end

        function lines = wrap_lines_(text, widthEmu, pointSize, fontFile)
            % Word-boundary wrap similar to python _LineSource / _wrap_lines.
            words = strsplit(strtrim(char(string(text))));
            if isempty(words) || (numel(words) == 1 && strlength(string(words{1})) == 0)
                lines = {""};
                return
            end
            lines = {};
            i = 1;
            n = numel(words);
            while i <= n
                j = i;
                best = i;
                while j <= n
                    candidate = strjoin(words(i:j), " ");
                    [cx, ~] = mat2ppt.text.TextFitter.rendered_size(candidate, pointSize, fontFile);
                    if cx <= widthEmu
                        best = j;
                        j = j + 1;
                    else
                        break
                    end
                end
                if best < i
                    % single word wider than box — take one word
                    best = i;
                end
                lines{end+1} = strjoin(words(i:best), " "); %#ok<AGROW>
                i = best + 1;
            end
        end
    end
end
