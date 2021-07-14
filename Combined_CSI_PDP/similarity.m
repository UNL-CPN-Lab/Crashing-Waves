function y = similarity(p,q)
    p_t = ifft(p);
    q_t = ifft(q);
    m_p  = max(max(abs(p_t)));
    m_q  = max(max(abs(q_t)));
    y = 1/norm((p_t./m_p)-(q_t./m_q));
end