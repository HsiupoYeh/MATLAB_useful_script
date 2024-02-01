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


```matlab
%-------------------------------------------------------------------------
% 驗證PHOENIX Geophysics MTU-8A,RXU-8A,MTU-5C,MTU-2C,MTU-5D檔案名稱格式: 
% 降取樣型時間序列資料格式(format of decimated time series): AAAAA_BBBBBBBB_C_DDDDDDDD.tdE
% XXXXX為5個數字，代表儀器序號，例如: 12345 。
% BBBBBBBB為8個英數字，為32位元無號數十六進制標籤，表示記錄開始時間的時間戳，與序列號一起構成記錄的唯一ID。
% C為1個數字，做為頻道代號ID，從0開始。與所在紀錄資料夾相同數字，例如:「0」、「1」、「2」、「3」、「4」。通常是指:「H2(Hy)」、「E1(Ex)」、「H1(Hx)」、「H3(Hz)」、「E2(Ey)」。
% DDDDDDDD為8個英數字，為32位元無號數十六進制標籤，紀錄器每一段時間將資料儲存為一個檔案，此標籤為該檔案的索引。每個檔案6分鐘或10分鐘儲存一次，此索引值的極限設計為可以儲存超過10000年的連續數據。索引從「00000001」開始，依序「00000002」、「00000003」、「00000004」、「00000005」、「00000006」、「00000007」、「0000000A」...，若照Windows檔案名稱排序可能部分資料會排到後面去。
% E為不定數量的多個英數字，代表降取樣後的取樣率。例如:「td_24k」表示取樣率為24000[SPS]，「td_150」表示取樣率為150[SPS]。
%--
% 說明:
% 用match加上split模式，可以取得匹配的部分與不匹配的部分。
% 這裡去找匹配數量是1，此時不匹配數量一定是2，而且不匹配的變數之
% 第一個細胞矩陣內是匹配之前的字元，不匹配的變數之第二個細胞矩陣
% 是匹配之後的字元，當這兩個都是空的，表示輸入字串數量與格式均符合。
%--
input_regexp_str='10615_63EAE53A_0_00000001.td_24k';% 格式: AAAAA_BBBBBBBB_C_DDDDDDDD.td_24k與AAAAA_BBBBBBBB_C_DDDDDDDD.td_150
input_regexp_expression=['\d{5}_[A-Z0-9]{8}_\d{1}_\d{8}.td_24k|\d{5}_[A-Z0-9]{8}_\d{1}_\d{8}.td_150',];
[out_regexp_Match,out_regexp_noMatch] = regexp(input_regexp_str,input_regexp_expression,'match','split');
if (length(out_regexp_Match)==1 && isempty(out_regexp_noMatch{1}) && isempty(out_regexp_noMatch{2}))
    disp('降取樣型時間序列資料格式正確')
else
    disp('降取樣型時間序列資料格式錯誤')
    return
end
%-------------------------------------------------------------------------
```
