%**************************************************************************
%   Name: yeh_ini2struct_ansi.m v20211021a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20211021a
%   Description: 讀取INI檔案的函數，INI檔案編碼需為ANSI
%   呼叫方法: 
%       yeh_ini2struct('Config.ini');
%**************************************************************************
function IniFile = yeh_ini2struct_ansi(input_ini_file_name)
    %----------------------------------------------------------------------
    IniFile.Struct=[];
    IniFile.Error.String=[];
    %----------------------------------------------------------------------
    % 開啟檔案    
    fid = fopen(input_ini_file_name,'r');  
    if fid<0
        disp(['開啟檔案失敗!return!檔案名稱:',input_ini_file_name,'.'])
        EarthImagerOutFile.Error.String=['開啟檔案失敗!return!檔案名稱:',input_ini_file_name,'.'];
        return
    end
    %--
    % 迴圈依序逐行讀取直到檔案結束
    while ~feof(fid)
        % 讀取一行
        temp_str=fgetl(fid);
        % 去除頭尾空白字元
        temp_str = strtrim(temp_str);        
        % 忽略空白行、分號註解、井字號註解
        if isempty(temp_str) || temp_str(1)==';' || temp_str(1)=='#' 
            continue
        end
        % 找到左中括號表示區塊起點，建立一個結構體
        if temp_str(1)=='['
            % 用genvarname來產生安全的變數名稱
            temp_section = genvarname(strtok(temp_str(2:end),']'));
            % 結構體「.()」裡面可以填字串變數來取用
            % 若temp_section='abc'，則Struct.(temp_section)等同於Struct.abc
            IniFile.Struct.(temp_section) = [];            
            continue
        end
        % 拆成等號之前與之後的字串。例如「A="CD"」，拆成「A」和「="CD"」
        [temp_Key,temp_Value] = strtok(temp_str, '='); 
        % 去除掉等號，有可能前後會有空格，也去除掉
        temp_Value = strtrim(temp_Value(2:end));
        % 判斷值的可能性: 空的或註解的、雙引號的、單引號的
        if isempty(temp_Value) || temp_Value(1)==';' || temp_Value(1)=='#' 
            temp_Value = [];
        elseif temp_Value(1)=='"'                    
            temp_Value = strtok(temp_Value, '"');
        elseif temp_Value(1)==''''                     
            temp_Value = strtok(temp_Value, '''');
        else
            % 萬一後面還有註解，只取註解之前的
            temp_Value = strtok(temp_Value, ';');
            temp_Value = strtok(temp_Value, '#'); 
            % 再次確保取完的字串沒有空白
            temp_Value = strtrim(temp_Value);
            % 嘗試轉換成數字
            [temp_num, status] = str2num(temp_Value);      
            if status
                temp_Value = temp_num; 
            end   
        end
        % 結構體填值
        if ~exist('temp_section', 'var')             
            IniFile.Struct.(genvarname(temp_Key)) = temp_Value;
        else
            IniFile.Struct.(temp_section).(genvarname(temp_Key)) = temp_Value;
        end

    end
    %--
    % 關閉檔案
    fclose(fid);
    %---------------------------------------------------------------------- 
end



    
    