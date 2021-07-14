function y = pathloss_exp(PL,d)
    P = polyfit(10*log10(d),PL,1);
    y = P(1);
end