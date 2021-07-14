function y = get_num_of_secs(start_time, end_time)

diff_time = end_time - start_time;

y = diff_time(6) + diff_time(5)*60 + diff_time(4)*3600 ;

end