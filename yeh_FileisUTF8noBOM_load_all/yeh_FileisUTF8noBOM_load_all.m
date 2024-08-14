%**************************************************************************
%   Name: yeh_FileisUTF8noBOM_load_all.m v20240814a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240814a
%   Description: 檢測檔案內容是否為無BOM的UTF8。
%   呼叫方法: 
%        FileisUTF8noBOM=yeh_FileisUTF8noBOM_load_all('File.txt');
%**************************************************************************
function FileisUTF8noBOM=yeh_FileisUTF8noBOM_load_all(Input_file_name)
%----------------------------------------------------------------------
%  REF:
%    http://www.unicode.org/versions/Unicode7.0.0/UnicodeStandard-7.0.pdf
%    page 124, 3.9 "Unicode Encoding Forms", "UTF-8"
% 
% 
%   Table 3-7. Well-Formed UTF-8 Byte Sequences
%----------------------------------------------------------------------
%   |  Code Points        | First Byte | Second Byte | Third Byte | Fourth Byte |
%   |  U+0000..U+007F     |     00..7F |             |            |             |
%   |  U+0080..U+07FF     |     C2..DF |      80..BF |            |             |
%   |  U+0800..U+0FFF     |         E0 |      A0..BF |     80..BF |             |
%   |  U+1000..U+CFFF     |     E1..EC |      80..BF |     80..BF |             |
%   |  U+D000..U+D7FF     |         ED |      80..9F |     80..BF |             |
%   |  U+E000..U+FFFF     |     EE..EF |      80..BF |     80..BF |             |
%   |  U+10000..U+3FFFF   |         F0 |      90..BF |     80..BF |      80..BF |
%   |  U+40000..U+FFFFF   |     F1..F3 |      80..BF |     80..BF |      80..BF |
%   |  U+100000..U+10FFFF |         F4 |      80..8F |     80..BF |      80..BF |
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% 初始猜測是無BOM的UTF-8編碼
FileisUTF8noBOM.isUTF8noBOM=1;%0=不是，1=是無BOM的UTF-8編碼。
FileisUTF8noBOM.Description='此檔案內容符合無BOM的UTF-8編碼，但不保證確實是用此編碼。';
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% 將檔案全部載入記憶體中，減少IO加速運行時間，但可能不適合超大檔案。
%----------------------------------------------------------------------
% 開啟檔案    
fid = fopen(Input_file_name,'r');
if fid<0
    FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
    FileisUTF8noBOM.Description='檢測結果為:否。原因:開啟檔案失敗!';
    disp(['檢測結果為:否。原因:開啟檔案失敗!return!'])
    return
end
%--
% 全部載入記憶體中，且使用十進位數值儲存。
str_vector = fread(fid)';
%--
% 關閉檔案
fclose(fid);
%----------------------------------------------------------------------
% BOM 檢查
if (str_vector(1) ==239 && str_vector(2) <=187 && str_vector(3) ==191)% 0xEF(239), 0xBB(187), 0xBF(191)
    FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
    FileisUTF8noBOM.Description='檢測結果為:否。原因:此檔案是有BOM的UTF-8編碼!';
    disp(['檢測結果為:否。原因:此檔案是有BOM的UTF-8編碼!return!'])
    return
end
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% 逐個位元檢測內容是否符合UTF-8編碼規範
%--
% 目標檢查位元索引
str_vector_index=1;
% 最大檢查位元索引
max_str_vector_index=length(str_vector);
%--
% 逐個檢查
while(1)
    %--
    if str_vector(str_vector_index)<=127% 00..7F(0~127) ，這是1個Byte表示一個字元
        %----------------------------------------------------------------------
        %disp(['1Byte: ',native2unicode(str_vector(str_vector_index),'UTF-8')])
        str_vector_index=str_vector_index+1;
        %----------------------------------------------------------------------
    elseif (str_vector(str_vector_index) >=194 && str_vector(str_vector_index) <=223)%  C2..DF(194~223) 80..BF(128~191)，這是2個Byte表示一個字元
        %----------------------------------------------------------------------
        if (str_vector_index+1 <= max_str_vector_index) %確認有2個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191)%  C2..DF(194~223) 80..BF(128~191)，這是2個Byte表示一個字元
                %disp(['2Byte[C2~DF]: ',native2unicode(str_vector(str_vector_index:str_vector_index+1),'UTF-8')])
                str_vector_index=str_vector_index+2;                
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足2Byte (|C2..DF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足2Byte (|C2..DF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成2Byte (|C2..DF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成2Byte (|C2..DF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------
	elseif (str_vector(str_vector_index) ==224)% E0(224) A0..BF(160~191) 80..BF(128~191)，這是3個Byte表示一個字元
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %確認有3個Byte
            if (str_vector(str_vector_index+1) >=160 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% E0(224) A0..BF(160~191) 80..BF(128~191)，這是3個Byte表示一個字元
                %disp(['3Byte[E0]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足3Byte (|E0|A0..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足3Byte (|E0|A0..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成3Byte (|E0|A0..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成3Byte (|E0|A0..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------
    elseif (str_vector(str_vector_index) >=225 && str_vector(str_vector_index) <=236)% E1..EC(225~236) 80..BF(128~191) 80..BF(128~191)，這是3個Byte表示一個字元    
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %確認有3個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% E1..EC(225~236) 80..BF(128~191) 80..BF(128~191)，這是3個Byte表示一個字元    
                %disp(['3Byte[E1~EC]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足3Byte (|E1..EC|80..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足3Byte (|E1..EC|80..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成3Byte (|E1..EC|80..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成3Byte (|E1..EC|80..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------       
 elseif (str_vector(str_vector_index) ==237)% ED(237) 80..9F(128~159) 80..BF(128~191)，這是3個Byte表示一個字元
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %確認有3個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=159 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)%  ED(237) 80..9F(128~159) 80..BF(128~191)，這是3個Byte表示一個字元
                %disp(['3Byte[ED]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足3Byte (|ED|80..9F|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足3Byte (|ED|80..9F|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成3Byte (|ED|80..9F|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成3Byte (|ED|80..9F|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------
     elseif (str_vector(str_vector_index) >=238 && str_vector(str_vector_index) <=239)% EE..EF(238~239) 80..BF(128~191) 80..BF(128~191)，這是3個Byte表示一個字元    
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %確認有3個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% EE..EF(238~239) 80..BF(128~191) 80..BF(128~191)，這是3個Byte表示一個字元    
                %disp(['3Byte[EE~EF]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足3Byte (|EE..EF|80..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足3Byte (|EE..EF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成3Byte (|EE..EF|80..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成3Byte (|EE..EF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------          
     elseif (str_vector(str_vector_index) ==240)% F0(240) 90..BF(144~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %確認有4個Byte
            if (str_vector(str_vector_index+1) >=144 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F0(240) 90..BF(144~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元    
                %disp(['4Byte[F0]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足4Byte (|F0|90..BF|80..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足4Byte (|F0|90..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成4Byte (|F0|90..BF|80..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成4Byte (|F0|90..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------         
     elseif (str_vector(str_vector_index) >=241 && str_vector(str_vector_index) <=243)% F1..F3(241~243) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %確認有4個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F1..F3(241~243) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元    
                %disp(['4Byte[F1~F3]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足4Byte (|F1..F3|80..BF|80..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足4Byte (|F1..F3|80..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成4Byte (|F1..F3|80..BF|80..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成4Byte (|F1..F3|80..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------    
     elseif (str_vector(str_vector_index) ==244)% F4(244) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %確認有4個Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F4(244) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)，這是4個Byte表示一個字元        
                %disp(['4Byte[F4]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
                FileisUTF8noBOM.Description='檢測結果為:否。原因:不滿足4Byte (|F4|80..BF|80..BF|80..BF|)的UTF-8編碼規則!';
                disp(['檢測結果為:否。原因:不滿足4Byte (|F4|80..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
            FileisUTF8noBOM.Description='檢測結果為:否。原因:數量湊不成4Byte (|F4|80..BF|80..BF|80..BF|)的UTF-8編碼規則!';
            disp(['檢測結果為:否。原因:數量湊不成4Byte (|F4|80..BF|80..BF|80..BF|)的UTF-8編碼規則!return!'])
            return
        end
        %----------------------------------------------------------------------       
    else
        %----------------------------------------------------------------------
        FileisUTF8noBOM.isUTF8noBOM=0;%0=不是，1=是無BOM的UTF-8編碼。
        FileisUTF8noBOM.Description='檢測結果為:否。原因:不存在的UTF-8編碼規則!';
        disp(['檢測結果為:否。原因:原因:不存在的UTF-8編碼規則!return!'])
        return
        %----------------------------------------------------------------------
    end    
    %--
    if str_vector_index>=max_str_vector_index
        FileisUTF8noBOM.isUTF8noBOM=1;%0=不是，1=是無BOM的UTF-8編碼。
        FileisUTF8noBOM.Description='此檔案內容符合無BOM的UTF-8編碼，但不保證確實是用此編碼。';
        disp(['檢測結果為:是。原因:此檔案內容符合無BOM的UTF-8編碼，但不保證確實是用此編碼。'])
        return
    end  
    %--
end