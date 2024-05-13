# Matlab讀檔案相關

### 全部讀進來(textread版本)

```matlab
%-------------------------------------------------------------------------
data = textread('DATA.txt','%s','delimiter','\n');
%-------------------------------------------------------------------------
```

### 讀取逗號分隔檔案(textread版本)
```matlab

%-------------------------------------------
% 讀取逗號分隔檔案(*.csv)
% 要注意，用textread的開檔錯誤只能用try catch處理。
%--
Input_filename='DATA.csv';
%--
% 找CSV檔案的X軸方向上格子數量
temp_first_csv_line_cell = textread(Input_filename,'%s',1);
temp_first_csv_x_cell=strsplit(temp_first_csv_line_cell{1},',');
temp_first_csv_x_cell_count=length(temp_first_csv_x_cell);
disp(['CSV檔案的X軸方向上格子數量=',num2str(temp_first_csv_x_cell_count)])
%--
% 讀取所有資料並重新排列
temp_all_csv_line_cell=textread(Input_filename,'%s','delimiter',',');
if (mod(length(temp_all_csv_line_cell),temp_first_csv_x_cell_count)==0)
    temp_first_csv_y_cell_count=length(temp_all_csv_line_cell)/temp_first_csv_x_cell_count;
    disp(['CSV檔案的Y軸方向上格子數量=',num2str(temp_first_csv_y_cell_count)])
else
    disp('錯誤!資料數量異常!return!')
    return
end
temp_all_csv_line_cell=reshape(temp_all_csv_line_cell,temp_first_csv_x_cell_count,[])';
%--------------------------------------------------------------------------
```
