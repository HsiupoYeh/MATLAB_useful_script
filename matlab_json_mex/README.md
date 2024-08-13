# matlab_json_mex


### 使用範例
+ Windows 10, MATLAB 2014a通過測試

```matlab
%**************************************************************************
%   Name: yeh_ json_encode_decode_example .m v20240814a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240814a
%   Description:  json_encode / json_decode 使用範例:
%**************************************************************************
clear;clc
%----------------------------------------------------------------------
% php運行以下程式碼:
% <?php
% echo json_encode(array('Name' => '金\城武', 'Age' => 18, 'Email' => 'kimchen5@gmail.com'),JSON_UNESCAPED_UNICODE);
% exit;
% ?>
% 會印出:
% {"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}
%--
% 若沒有加上JSON_UNESCAPED_UNICODE，則為:
% <?php
% echo json_encode(array('Name' => '金\城武', 'Age' => 18, 'Email' => 'kimchen5@gmail.com'));
% exit;
% ?>
% 會印出:
% {"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}
%----------------------------------------------------------------------
% 閱讀的時候我們喜歡讀JSON_UNESCAPED_UNICODE字串，但是Json中仍有跳脫字元規則要遵守:
% 「{"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}」
% 但是多數函式庫只支援unicode編碼後普通JSON檔案，本範例中稱作JSON_Normal字串:
% 「{"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}」
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% 先來實作解析
%----------------------------------------------------------------------
% 用JSON_Normal字串進行解碼:
JSON_Normal_str='{"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}';
disp(JSON_Normal_str)
disp('解碼->')
temp_json_struct=json_decode(JSON_Normal_str);
disp(temp_json_struct)
disp('--')
% 顯示為:
% {"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}
% 解碼->
%      Name: '金\城武'
%       Age: 18
%     Email: 'kimchen5@gmail.com'
% 
% --
% 以上解析完美符合需求
%----------------------------------------------------------------------
% 用JSON_UNESCAPED_UNICODE字串進行解碼:
JSON_UNESCAPED_UNICODE_str='{"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}';
disp(JSON_UNESCAPED_UNICODE_str)
disp('解碼->')
% 直接用這個好讀的字串來呼叫json_decode會失敗...
try
	 json_decode(JSON_UNESCAPED_UNICODE_str)
catch ME
    disp('運行錯誤!無法解析!')
    disp(ME.message)
end
disp('--')
% 顯示為:
% {"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}
% 解碼->
% 運行錯誤!無法解析!
% Parse error at character 37:
% {"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}
%                                     ^
% --
% 以上解碼失敗
%--
disp(JSON_UNESCAPED_UNICODE_str)
disp('轉換->')
% 因此要進行以下操作，轉換回JSON_Normal字串一樣的內容
temp_string_vector=double(JSON_UNESCAPED_UNICODE_str);
temp_string_vector(temp_string_vector<=127)=temp_string_vector(temp_string_vector<=127)+65536;
temp_str=sprintf('\\u%05x',temp_string_vector);
temp_str=strrep(strrep(temp_str,'\u100','\x'),'\u0','\\u');
new_JSON_Normal_str=sprintf(temp_str);
disp(new_JSON_Normal_str)
disp('解碼->')
temp_json_struct=json_decode(new_JSON_Normal_str);
disp(temp_json_struct)
disp('--')
% 顯示為:
% {"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}
% 轉換->
% {"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}
% 解碼->
%      Name: '金\城武'
%       Age: 18
%     Email: 'kimchen5@gmail.com'
% 
% --
% 以上解析完美符合需求
%----------------------------------------------------------------------
% 接著測試JSON_Normal字串套用上述解碼:
disp(JSON_Normal_str)
disp('轉換->')
% 因此要進行以下操作，轉換回JSON_Normal字串一樣的內容
temp_string_vector=double(JSON_Normal_str);
temp_string_vector(temp_string_vector<=127)=temp_string_vector(temp_string_vector<=127)+65536;
temp_str=sprintf('\\u%05x',temp_string_vector);
temp_str=strrep(strrep(temp_str,'\u100','\x'),'\u0','\\u');
new_JSON_Normal_str=sprintf(temp_str);
disp(new_JSON_Normal_str)
disp('解碼->')
temp_json_struct=json_decode(new_JSON_Normal_str);
disp(temp_json_struct)
disp('--')
% 顯示為:
% {"Name":"金\\城武","Age":18,"Email":"kimchen5@gmail.com"}
% 轉換->
% {"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}
% 解碼->
%      Name: '金\城武'
%       Age: 18
%     Email: 'kimchen5@gmail.com'
% 
% --
% 以上解析完美符合需求
%----------------------------------------------------------------------


%----------------------------------------------------------------------
% 接著再試試看編碼:
disp(temp_json_struct)
disp('編碼->')
my_JSON_Normal_str=json_encode(temp_json_struct);
disp(my_JSON_Normal_str)
disp('轉換->')
%--
% 模仿轉出JSON_UNESCAPED_UNICODE字串:
my_JSON_UNESCAPED_UNICODE_str=sprintf(strrep(my_JSON_Normal_str,'\u','\x'));
disp(my_JSON_UNESCAPED_UNICODE_str)
% 顯示為:
%      Name: '金\城武'
%       Age: 18
%     Email: 'kimchen5@gmail.com'
% 
% 編碼->
% {"Name":"\u91d1\\\u57ce\u6b66","Age":18,"Email":"kimchen5@gmail.com"}
% 轉換->
% {"Name":"金\城武","Age":18,"Email":"kimchen5@gmail.com"}
%----------------------------------------------------------------------
```
