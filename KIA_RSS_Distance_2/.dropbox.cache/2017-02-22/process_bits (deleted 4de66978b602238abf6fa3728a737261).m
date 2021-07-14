clc
clear variables
close all


%delete('test.csv')

load bits_all.mat
load evm_ts_clean.mat

n_rows = 46;


%bits_witout_preamble = bits_all;

% bits_witout_preamble(:,frame_idx) = [];
%
% a = size(bits_witout_preamble);
%
% bits_reshape = reshape(bits_witout_preamble, 1, a(1)*a(2));

j = 0;

K = ones(1, length(bits_all))*NaN;



for i = 1 : length(frame_idx)-1
    
    diff = frame_idx(i+1) - frame_idx(i) - 1;
    
    
    
    processed_bits = bits_all(:,frame_idx(i)+1:frame_idx(i+1)-1);
    
    bits_reshape = reshape(processed_bits, 1, diff*n_rows);
    
    string_bits = binaryVectorToHex(bits_reshape,'LSBFirst');
    
    
    if  mod(length(string_bits),2) ~= 0
        string_bits = strcat('0',string_bits);
    end
    
    
    
    
    cell_str = flip(cellstr(reshape(string_bits,2,[])'));
    
    
    
    if length(cell_str) > 1
        

        
        j = j+1;
        
        
        
        if strcmp(cell_str(1), '00') & strcmp(cell_str(2), '84') & strcmp(cell_str(3), '00') & strcmp(cell_str(4), '84')
            
            
            
            if strcmp(cell_str(7), cell_str(9)) & strcmp(cell_str(7), cell_str(11)) & strcmp(cell_str(7), cell_str(18)) & strcmp(cell_str(7), cell_str(37)) & strcmp(cell_str(7), cell_str(39)) & strcmp(cell_str(7), cell_str(67))
                
                N(j) = hex2dec(cell_str(7));
                K(frame_idx(i)+1:frame_idx(i+1)-1) = N(j);
                K(frame_idx(i)) = -1;
                K(frame_idx(i+1)) = -1;
                M(j) =  hex2dec(cell_str(5));
            else
                
                N(j) = NaN;
                M(j) = hex2dec( cell_str(6));
                
            end
        else
            
            N(j) = NaN;
            M(j) = NaN;
            
        end
        
        
    else
        
                K(frame_idx(i)) = -1;
                K(frame_idx(i+1)) = -1;
        
        
    end
    
    %end
    
    
    
end

figure
subplot(2,1,1);
plot(N)

subplot(2,1,2);
plot(M)

figure
plot(K)

%j

