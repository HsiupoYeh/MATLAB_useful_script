# MATLAB的dir使用
+ 使用平台:
  +  Windows 10 64bit
+ MATLAB版本:
  + MATLAB R2013a 64bit
+ 說明:
  + 使用dir命令查詢資料夾，結果都會回傳「.」與「..」資料夾，可以用下面的簡潔寫法刪掉這兩項資料夾。
+ Matlab Script:
```matlab
clear;clc;close all
%-----------------------------------------
% 目標資料夾 target_folder='C:\Windows';
% 使用dir查詢資料夾內的清單 temp_dir_result=dir(target_folder);
% 去除結構體中「.」與「..」資料夾 temp_dir_result=temp_dir_result(~ismember({temp_dir_result.name},{'.','..'}));
% 去除結構體中非資料夾 temp_dir_result2=temp_dir_result(cell2mat({temp_dir_result.isdir}));
% 結構體轉成細胞矩陣 temp_dir_result_cell=struct2cell(temp_dir_result2)';
% 只取出資料夾名的細胞矩陣 temp_dir_foldername_cell={temp_dir_result2(:).name}';
%-----------------------------------------
```
