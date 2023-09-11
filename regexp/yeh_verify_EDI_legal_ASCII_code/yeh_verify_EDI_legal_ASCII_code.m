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
% MATLAB 正規表達式
% 根據EDI文件，6.23章節，EDI格式的所有內容為ANSI編碼。這表示所有內容是不允許有中
% 文的。但實際上，許多軟體仍嘗試使用現在流行的ANSI或UTF-8格式來儲存，這些格式允許
% 儲存不同語系的文字，但其編碼不同在讀取上要特別小心，但幸運的是ANSI編碼在不同格
% 式下都是相同的，因此乖乖按照原規劃使用ASCII來處理是最簡單的。一般而言，重要的資
% 料欄位均為英數字，僅有說明或地名人名等項目可能會有例外字元。
%--
% 具體的說，EDI文件，6.23章節，規定了可用的編碼:
% 0x00 -> 不建議用，但有時候可能仍有人要用這個來填充數據。請忽略他。
% 0x01 ~ 0x09 -> 禁用，不可見字元
% 0x0A -> 可以用，換行，不可見字元
% 0x0B ~ 0x0C -> 禁用，不可見字元
% 0x0D -> 可以用，回車，不可見字元
% 0x0E ~ 0x1F -> 禁用，不可見字元
% 0x20 ~ 0x7E -> 可以用，可見字元
% 0x7F -> 禁用，不可見字元
% 0x80 ~ 0xFE-> 沒規定不能用，但重要的資料區域都不會用到，可見字元
% 0xFF -> 禁用，不可見字元
% 綜合以上，為了練習正規表達式，我們現在就是允許所有可見字元、換行以及回車。
%--
disp('--')
%--
disp('故意寫的範例:')
% 正規表達式:查詢有多少個0x00
input_regexp_str=edi_char_data;
input_regexp_expression='[\x00]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x00。'])
%--
% 正規表達式:查詢有多少個0x0A
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0A]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x0A。'])
%--
% 正規表達式:查詢有多少個0x0B~0x0C
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0B-\x0C]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x0B~0x0C。'])
%--
% 正規表達式:查詢有多少個0x0D
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0D]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x0D。'])
%--
% 正規表達式:查詢有多少個0x0E~0x1F
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0E-\x1F]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x0E~0x1F。'])
%--
% 正規表達式:查詢有多少個0x20~0x7E
input_regexp_str=edi_char_data;
input_regexp_expression='[\x20-\x7E]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x20~0x7E。'])
%--
% 正規表達式:查詢有多少個0x7F
input_regexp_str=edi_char_data;
input_regexp_expression='[\x7F]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x7F。'])
%--
% 正規表達式:查詢有多少個0x80 ~ 0xFE
input_regexp_str=edi_char_data;
input_regexp_expression='[\x80-\xFE]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0x80~0xFE。'])
% 正規表達式:查詢有多少個0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個0xFF。'])
%--
disp('--')
%--
disp('比較有用的驗證:')
% 驗證EDI檔案中，不合法字元的數量
% 正規表達式:查詢有多少個0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[\x00\x01-\x09\x0B\x0C\x0E-\x1F\x7F\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個不合法字元。'])
%--
% 驗證EDI檔案中，合法字元的數量
% 正規表達式:查詢有多少個0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[^\x00\x01-\x09\x0B\x0C\x0E-\x1F\x7F\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['本EDI內容有',num2str(temp_count),'個合法字元。'])
%--
disp('--')
%--