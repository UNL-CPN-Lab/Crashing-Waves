function y = distance(Pa,Pb)
    y = sum((Pa-Pb).^2).^0.5;
end
