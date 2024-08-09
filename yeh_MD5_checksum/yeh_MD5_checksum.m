%**************************************************************************
%   Name: yeh_MD5_checksum.m v20240807a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240807a
%   Description: 使用Java來計算檔案的MD5湊雜碼。
%   呼叫方法: 
%       yeh_MD5_checksum('1532.zip');
%**************************************************************************
function md5hash = yeh_MD5_checksum(input_file_name)
    %----------------------------------------------------------------------
    md5hash.String=[];
    md5hash.Error.String=[];
    %----------------------------------------------------------------------
    % 版本資訊
    Version_str='v20240807a'; 
    %----------------------------------------------------------------------
    % 使用提醒
    if ~exist('input_file_name','var')
        % 提示畫面
        disp('************************************************************')
        disp('* Program: yeh_MD5_checksum')
        disp('* Author: HsiupoYeh')
        disp(['* Version: ',Version_str])
        disp('* Usage:')
        disp('* yeh_MD5_checksum(''1532.zip'')')
        disp('************************************************************')
        md5hash.Error.String=['錯誤!請依照提示呼叫本程式!return!.'];
        return
    end
    %--------------------------------------------------------------------------
    % 讀取檔案
    f1= fopen(input_file_name); 
    if (f1<0)
        %disp(['錯誤!開啟檔案失敗!return!檔案名稱:',Input_file_name,'.'])
        md5hash.Error.String=['錯誤!開啟檔案失敗!return!檔案名稱:',input_file_name,'.'];
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
    md5hash.String=lower(reshape(dec2hex(typecast(md5_object.digest(temp_uint8data),'uint8')).',1,32));
    %--
    % 展示MD5湊雜碼
    %disp(md5hash.String)
    %--------------------------------------------------------------------------
end