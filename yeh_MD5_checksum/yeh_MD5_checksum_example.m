%**************************************************************************
%   Name: yeh_MD5_checksum_example.m v20240807a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240807a
%   Description: �ϥ�Java�ӭp���ɮת�MD5�����X�C
%**************************************************************************
clear;clc;close all
%--------------------------------------------------------------------------
% �ؼ��ɮצW��
Input_file_name='1532.zip';
%--
% Ū���ɮ�
f1= fopen(Input_file_name); 
if (f1<0)
    disp('���~!�}���ɮץ���!return!')
    return
end
%--
% �N���e���J�O���餤
temp_uint8data=fread(f1,inf,'*uint8');
%--
% �����ɮ�
fclose(f1);
%--------------------------------------------------------------------------
% �ϥ�Java�ӭp��MD5�����X
md5_object=java.security.MessageDigest.getInstance('MD5');
md5hash_str=lower(reshape(dec2hex(typecast(md5_object.digest(temp_uint8data),'uint8')).',1,32));
%--
% �i��MD5�����X
disp(md5hash_str)
%--------------------------------------------------------------------------
