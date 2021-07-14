function y = r_square(PL,PLhat)
    RSS = sum(sum((PL - PLhat).^2, 'omitnan'), 'omitnan');
    OBS_mean =  mean(mean(PL,'omitnan'),'omitnan');
    TSS = sum(sum((PL - OBS_mean).^2, 'omitnan'), 'omitnan');
    y = 1 - RSS/TSS;
end