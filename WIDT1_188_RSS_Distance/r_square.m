function y = r_square(PL,PLhat)
    RSS = sum((PL - PLhat).^2, 'omitnan');
    OBS_mean =  mean(PL,'omitnan');
    TSS = sum((PL - OBS_mean).^2, 'omitnan');
    %1 - (rms(PL - PLhat, 'omitnan').^2)/var(PL,'omitnan')
    y = 1 - RSS/TSS;
end