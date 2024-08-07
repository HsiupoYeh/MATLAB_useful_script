%**************************************************************************
%   Name: yeh_MD5_checksum_example.m v20240807a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240807a
%   Description: 使用Java來計算檔案的MD5湊雜碼。
%**************************************************************************
clear;clc;close all
%--------------------------------------------------------------------------
% 目標檔案名稱
Input_file_name='1532.zip';
%--
% 讀取檔案
f1= fopen(Input_file_name); 
if (f1<0)
    disp('錯誤!開啟檔案失敗!return!')
    return
end
%--
% 將內容載入記憶體中
temp_uint8data=fread(f1,inf,'*uint8');
%--
% 關閉檔案
fclose(f1);
%--------------------------------------------------------------------------
% 使用Java來計算MD5湊雜碼
md5_object=java.security.MessageDigest.getInstance('MD5');
md5hash_str=lower(reshape(dec2hex(typecast(md5_object.digest(temp_uint8data),'uint8')).',1,32));
%--
% 展示MD5湊雜碼
disp(md5hash_str)
%--------------------------------------------------------------------------
