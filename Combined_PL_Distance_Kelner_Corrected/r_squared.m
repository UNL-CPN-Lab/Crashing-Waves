function r = r_squared(y,yCalc1)
    r = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
end