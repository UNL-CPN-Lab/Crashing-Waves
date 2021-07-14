function y = correct_phase(x,e)
    abs_x = abs(x);
    angle_x = angle(x)+e;
    y = abs_x.*exp(1j.*angle_x);
end