%**************************************************************************
%   Name: yeh_MD5_checksum.m v20240807a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240807a
%   Description: �ϥ�Java�ӭp���ɮת�MD5�����X�C
%   �I�s��k: 
%       yeh_MD5_checksum('1532.zip');
%**************************************************************************
function md5hash = yeh_MD5_checksum(input_file_name)
    %----------------------------------------------------------------------
    md5hash.String=[];
    md5hash.Error.String=[];
    %----------------------------------------------------------------------
    % ������T
    Version_str='v20240807a'; 
    %----------------------------------------------------------------------
    % �ϥδ���
    if ~exist('input_file_name','var')
        % ���ܵe��
        disp('************************************************************')
        disp('* Program: yeh_MD5_checksum')
        disp('* Author: HsiupoYeh')
        disp(['* Version: ',Version_str])
        disp('* Usage:')
        disp('* yeh_MD5_checksum(''1532.zip'')')
        disp('************************************************************')
        md5hash.Error.String=['���~!�Ш̷Ӵ��ܩI�s���{��!return!.'];
        return
    end
    %--------------------------------------------------------------------------
    % Ū���ɮ�
    f1= fopen(input_file_name); 
    if (f1<0)
        %disp(['���~!�}���ɮץ���!return!�ɮצW��:',Input_file_name,'.'])
        md5hash.Error.String=['���~!�}���ɮץ���!return!�ɮצW��:',input_file_name,'.'];
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
    md5hash.String=lower(reshape(dec2hex(typecast(md5_object.digest(temp_uint8data),'uint8')).',1,32));
    %--
    % �i��MD5�����X
    %disp(md5hash.String)
    %--------------------------------------------------------------------------
end