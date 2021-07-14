function y = rms_delay_spread(t,P)
      t1 = sum(t.*P)/sum(P);
      y = sqrt((sum(P.*((t-t1).^2)))/sum(P));
end
