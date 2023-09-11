clear;clc;close all
Input_EDI_file_name='LRN01_edit.edi';
%==========================================================================
% 將檔案內容全部載入到記憶體中 開始
%--------------------------------------------------------------------------
% 開啟檔案
f1=fopen(Input_EDI_file_name,'rt');
if (f1<0)
    disp('開啟檔案失敗!return!')
    return
end
%--
% 用fread全部載入來加快載入檔案速度
temp_data=fread(f1);
%--------------------------------------------------------------------------
% 關閉檔案
fclose(f1);
%--------------------------------------------------------------------------
% 將檔案內容全部載入到記憶體中 結束
%==========================================================================
%==========================================================================
% 轉置陣列使資料成為一橫列，即陣列大小<1xN>，並轉為字串資料
edi_char_data=char(temp_data');
edi_char_data_count=length(edi_char_data);
disp(['本EDI檔案大小 = ',num2str(edi_char_data_count)])
%--
% 非貪婪模式找出最少數量就能符合表達式的字串。
% 「.*?? 說明:任意字元發生一次以上的最短長度
% 
input_regexp_str=edi_char_data;
temp_start_keyword='>HEAD';
temp_end_keyword='>';
input_regexp_expression=[temp_start_keyword,'.*?',temp_end_keyword];
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
EDI.HEAD.String=out_regexp_match{1}(1:end-1);
disp(EDI.HEAD.String)
%--
disp('--')
input_regexp_str=EDI.HEAD.String;
temp_start_keyword='LAT=';
temp_end_keyword='\n';
input_regexp_expression=[temp_start_keyword,'.*?',temp_end_keyword];
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
EDI.HEAD.LAT.String=out_regexp_match{1}(1+length(temp_start_keyword):end-1);
disp(EDI.HEAD.LAT.String)
%--

