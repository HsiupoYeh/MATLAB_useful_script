# MATLAB regexp範例

### 驗證電話號碼

```matlab
%-------------------------------------------------------------------------
% 驗證電話號碼格式: 台灣行動電話號碼一律以 09 開頭，後接 8 位數字
% 格式: 09XX-XXX-XXX
%--
% 說明:
% 用match加上split模式，可以取得匹配的部分與不匹配的部分。
% 這裡去找匹配數量是1，此時不匹配數量一定是2，而且不匹配的變數之
% 第一個細胞矩陣內是匹配之前的字元，不匹配的變數之第二個細胞矩陣
% 是匹配之後的字元，當這兩個都是空的，表示輸入字串數量與格式均符合。
%--
input_regexp_str='0912-345-678';% 格式: 09XX-XXX-XXX
input_regexp_expression=['09\d{2}-\d{3}-\d{3}',];
[out_regexp_Match,out_regexp_noMatch] = regexp(input_regexp_str,input_regexp_expression,'match','split');
if (length(out_regexp_Match)==1 && isempty(out_regexp_noMatch{1}) && isempty(out_regexp_noMatch{2}))
    disp('電話號碼格式正確')
else
    disp('電話號碼格式錯誤')
end
%-------------------------------------------------------------------------
```
