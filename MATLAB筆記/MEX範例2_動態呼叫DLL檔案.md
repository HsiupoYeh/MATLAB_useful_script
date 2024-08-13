# MEX範例2_動態呼叫DLL檔案

### 使用平台:
+ Windows 10 64bit

### MATLAB版本:
+ MATLAB R2014a 64bit

###說明:
+ 注意，這個範例只適合Windows平台。
+ 示範透過MEX檔案呼叫windows內建的「user32.dll」中的對話窗功能。
+ 可以觀察怎麼從已有的C語言改寫為MEX規格的C語言。

### Matlab運行效果:
+ 略

### 原本C語言運行效果:
+ 略

### 原C語言程式碼:
```c
//**************************************************************************
//   Name: Call_dll_example.c v20171130a
//   Copyright:
//   Author: Hsiupo Yeh
//   Version: v20171130a
//   Description: Call_dll_example source code by C language
//**************************************************************************
#include <stdio.h>
#include <windows.h>
int main()
{
  //--------------------------------------------------------------------------
  //宣告部分
  //--------------------------------------------------------------------------
  typedef int (WINAPI *pf_MessageBox)(HWND, LPCSTR, LPCSTR, UINT);
  //為什麼會有這行就是因為參考其函式定義:
  //int WINAPI MessageBox(
  //  _In_opt_ HWND    hWnd,
  //  _In_opt_ LPCTSTR lpText,
  //  _In_opt_ LPCTSTR lpCaption,
  //  _In_     UINT    uType
  //);
  //REF:https://msdn.microsoft.com/en-us/library/windows/desktop/ms645505(v=vs.85).aspx
  //其中，(*pf_MessageBox)就是一個函式指標，我們可以用自己喜歡的名字代替，讓程
  //式碼可讀性更高。 	//所以如果是自己寫的dll，要按照dll定義的函數來修改這行。
  //--------------------------------------------------------------------------
  pf_MessageBox my_pf_MessageBoxA;
  HMODULE HMODULE_my_user32dll;
  int int_result;
  //--------------------------------------------------------------------------
  //--------------------------------------------------------------------------
  //用LoadLibrary載入dll，回傳的模組位址是 HMODULE類型。 	HMODULE_my_user32dll = LoadLibrary("user32.dll");
  //有時候會用LoadLibraryA來載入ANSI的，用LoadLibraryW來載入Unicode的，我不太確
  //定什麼時候要用哪個，但用錯時編譯器可能會告訴我錯誤。
  //--
  //防錯
  if (HMODULE_my_user32dll == NULL)
  {
    printf("動態載入user32.dll失敗，返回-1！\n");
    system("PAUSE");
    return -1;
  }
  //--------------------------------------------------------------------------
  //--------------------------------------------------------------------------
  //用GetProcAddress取得該dll中的某個函式的指標位置，查手冊知道有一個函數名稱為
  //"MessageBoxA"。
  my_pf_MessageBoxA = (pf_MessageBox)GetProcAddress(HMODULE_my_user32dll, "MessageBoxA");
  //前面已經定義過的型態這時候就很好用，程式碼變好寫也容易讀。
  //--
  //防錯
  if (my_pf_MessageBoxA == NULL)
  {
    printf("取得MessageBoxA函數指標失敗，返回-1！\n");
    system("PAUSE");
    return -1;
  }
  //--------------------------------------------------------------------------
  //--------------------------------------------------------------------------
  //呼叫這個函式
  int_result=my_pf_MessageBoxA(NULL,"這是內容", "這是標題", MB_OK);
  printf("my_pf_MessageBoxA Return value = %d\n",int_result);
  //--------------------------------------------------------------------------
  //釋放DLL，實際上這個函式只是個計數器，釋放就是計數器的值-1，到0才會被真的釋放
  //。重複使用載入函數也不會重複載入，只是會增加計數器的值。
  FreeLibrary(HMODULE_my_user32dll);
  //--------------------------------------------------------------------------
  system("PAUSE");
  return 0;
}
```

### 改寫為MEX規格的C語言原始碼:
```c
//**************************************************************************
//   Name: Call_dll_example_mex.c v20171130a
//   Copyright:
//   Author: Hsiupo Yeh
//   Version: v20171130a
//   Description: Matlab mex-files source code by C language
//**************************************************************************
#include "mex.h"
#include <stdio.h>
#include <string.h>
#include <windows.h>
//-----------------------------------------------------------
//副程式 使用說明
void usage(void)
{
  printf("-------------------------------------------------\n");
  printf("Version: v20171130a\n");
  printf("Usages: \n");
  printf("  A=Call_dll_example_mex('example')\n");
  printf("-------------------------------------------------\n");
}
//-----------------------------------------------------------
//想像成C語言中的主程式main。
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  //=========================================================
  //---------------------------------------------------------
  //MATLAB部分要增加的宣告
  //---------------------------------------------------------
  //輸出結構體部分宣告
  //宣告輸出的MATLAB結構體有N個fieldnames，後面程式碼再填入其名稱。
  const char *fieldnames[3];
  //目前N=3。
  //宣告MATLAB結構體中第1個fieldnames要填的資料(MATLAB ARRAY)，是double類型。
  //以下兩個會被指到一起，這樣C語言就可以直接操作後者。
  mxArray *mxArray_return_code;
  double *mxArray_return_code_ptr;
  //宣告MATLAB結構體中第2個fieldnames要填的資料(MATLAB ARRAY)，是string類型(或稱char類型)。
  //C語言準備好內容後再用mxCreateString操作。
  mxArray *mxArray_version;
  //宣告MATLAB結構體中第3個fieldnames要填的資料(MATLAB ARRAY)，是string類型(或稱char類型)。
  //C語言準備好內容後再用mxCreateString操作。
  mxArray *mxArray_Error_Msg;
  //--------------------------------------------------------------------------
  //--------------------------------------------------------------------------
  //原本C語言主程式部分宣告，直接抄「宣告部分」過來
  //--------------------------------------------------------------------------
  // 	typedef int (WINAPI *pf_MessageBox)(HWND,LPCSTR,LPCSTR,UINT);
  //為什麼會有這行就是因為參考其函式定義:
  //int WINAPI MessageBox(
  //  _In_opt_ HWND    hWnd,
  //  _In_opt_ LPCTSTR lpText,
  //  _In_opt_ LPCTSTR lpCaption,
  //  _In_     UINT    uType
  //);
  //REF:https://msdn.microsoft.com/en-us/library/windows/desktop/ms645505(v=vs.85).aspx
  //其中，(*pf_MessageBox)就是一個函式指標，我們可以用自己喜歡的名字代替，讓程式碼可讀性更高。
  //所以如果是自己寫的dll，要按照dll定義的函數來修改這行。
  //--------------------------------------------------------------------------
  pf_MessageBox my_pf_MessageBoxA;
  HMODULE HMODULE_my_user32dll;
  int int_result;
  //--
  //追加的宣告
  char *input_str;
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //輸出結構體部分定義(預設值)
  //---------------------------------------------------------
  //填入MATLAB結構體各個fieldnames名稱
  fieldnames[0]=(char*)mxMalloc(20);
  fieldnames[1]=(char*)mxMalloc(20);
  fieldnames[2]=(char*)mxMalloc(20);
  memcpy(fieldnames[0],"Return_Code",sizeof("Return_Code"));
  memcpy(fieldnames[1],"Version", sizeof("Version"));
  memcpy(fieldnames[2],"Error_Msg", sizeof("Error_Msg"));
  //Allocate memory for the structure，指到輸出的記憶體
  plhs[0]=mxCreateStructMatrix(1,1,3,fieldnames);
  //Deallocate memory for the fieldnames
  mxFree(fieldnames[0]);
  mxFree(fieldnames[1]);
  mxFree(fieldnames[2]);
  //---------------------------------------------------------
  //填入MATLAB結構體中第1個fieldnames要填的資料(MATLAB ARRAY)，是double類型。
  //Allocate memory for the Double
  mxArray_return_code=mxCreateDoubleMatrix(1,1,mxREAL);
  mxArray_return_code_ptr=mxGetPr(mxArray_return_code);
  //填入資料
  mxArray_return_code_ptr[0]=0;
  //---------------------------------------------------------
  //填入MATLAB結構體中第2個fieldnames要填的資料(MATLAB ARRAY)，是string類型。
  //Allocate memory for the String
  mxArray_version=mxCreateString("v20171130a");
  //---------------------------------------------------------
  //填入MATLAB結構體中第2個fieldnames要填的資料(MATLAB ARRAY)，是string類型。
  //Allocate memory for the String
  mxArray_Error_Msg=mxCreateString("");
  //---------------------------------------------------------
  //=========================================================
  //=========================================================
  //---------------------------------------------------------
  //分析參數內容，開始。
  if (nrhs==1 && nlhs<=1 && mxIsChar(prhs[0])==1)
  {
    //printf("輸入數量nrhs=%d\n", nrhs);
    //printf("輸出數量nlhs=%d\n", nlhs);
    input_str=mxArrayToString(prhs[0]);
    //printf("input_str = %s\n", input_str);
    //檢查參數
    if (strcmp(input_str,"example")==0)
    {
      //printf("main: OK!\n");
    }
    else
    {
      //printf("main: Error! Input str is not correct!\n");
      usage();
      //填入要改變的MATLAB結構陣列的欄位值
      mxArray_return_code_ptr[0]=-1;
      mxArray_Error_Msg=mxCreateString("Error! Input str is not correct!");
      //值設置到輸出變數
      mxSetFieldByNumber(plhs[0],0,0,mxArray_return_code);
      mxSetFieldByNumber(plhs[0],0,1,mxArray_version);
      mxSetFieldByNumber(plhs[0],0,2,mxArray_Error_Msg);
      return;
    }
    //=====================================================
    //--------------------------------------------------------------------------
    //原本C語言主程式程式碼，修改自「主程式部分」
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //用LoadLibrary動態載入dll，回傳的模組位址是 HMODULE類型。
    HMODULE_my_user32dll=LoadLibrary("user32.dll");
    //有時候會用LoadLibraryA來載入ANSI的，用LoadLibraryW來載入Unicode的，我不太確
    //定什麼時候要用哪個，但用錯時編譯器可能會告訴我錯誤。
    //--
    if (HMODULE_my_user32dll==NULL)
    {
      //printf("動態載入user32.dll失敗，返回-1！\n");
      //填入要改變的MATLAB結構陣列的欄位值
      mxArray_return_code_ptr[0]=-1;
      mxArray_Error_Msg=mxCreateString("動態載入user32.dll失敗，返回-1！");
      //值設置到輸出變數
      mxSetFieldByNumber(plhs[0],0,0,mxArray_return_code);
      mxSetFieldByNumber(plhs[0],0,1,mxArray_version);
      mxSetFieldByNumber(plhs[0],0,2,mxArray_Error_Msg);
      return;
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //用GetProcAddress取得該dll中的某個函式的指標位置，查手冊知道有一個函數名稱為
    //"MessageBoxA"。
    my_pf_MessageBoxA=(pf_MessageBox)GetProcAddress(HMODULE_my_user32dll,"MessageBoxA");
    //前面已經定義過的型態這時候就很好用，程式碼變好寫也容易讀。
    //--
    if (my_pf_MessageBoxA==NULL)
    {
      //printf("取得MessageBoxA函數指標失敗，返回-1！\n");
      //填入要改變的MATLAB結構陣列的欄位值
      mxArray_return_code_ptr[0]=-1;
      mxArray_Error_Msg=mxCreateString("取得MessageBoxA函數指標失敗，返回-1！");
      //值設置到輸出變數
      mxSetFieldByNumber(plhs[0],0,0,mxArray_return_code);
      mxSetFieldByNumber(plhs[0],0,1,mxArray_version);
      mxSetFieldByNumber(plhs[0],0,2,mxArray_Error_Msg);
      return;
    }
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //呼叫這個函式
    int_result=my_pf_MessageBoxA(NULL,"這是內容", "這是標題", MB_OK);
    //printf("my_pf_MessageBoxA Return value = %d\n",int_result);
    //--------------------------------------------------------------------------
    //釋放DLL，實際上這個函式只是個計數器，釋放就是計數器的值-1，到0才會被真的釋放
    //。重複使用載入函數也不會重複載入，只是會增加計數器的值。
    FreeLibrary(HMODULE_my_user32dll);
    //--------------------------------------------------------------------------
    //填入要改變的MATLAB結構陣列的欄位值
    mxArray_return_code_ptr[0]=0;
    mxArray_Error_Msg=mxCreateString("");
    //值設置到輸出變數
    mxSetFieldByNumber(plhs[0],0,0,mxArray_return_code);
    mxSetFieldByNumber(plhs[0],0,1,mxArray_version);
    mxSetFieldByNumber(plhs[0],0,2,mxArray_Error_Msg);
    return;
  }
  else
  {
    //printf("main: Error! Option is not correct!\n");
    usage();
    //填入要改變的MATLAB結構陣列的欄位值
    mxArray_return_code_ptr[0]=-1;
    mxArray_Error_Msg=mxCreateString("Error! Option is not correct!");
    //值設置到輸出變數
    mxSetFieldByNumber(plhs[0],0,0,mxArray_return_code);
    mxSetFieldByNumber(plhs[0],0,1,mxArray_version);
    mxSetFieldByNumber(plhs[0],0,2,mxArray_Error_Msg);
    return;
  }
}
```

### 編譯命令(Matlab Script):
```matlab
%-----------------------------------------
%清除變數，清除螢幕。
clear;clc
%-----------------------------------------
%編譯mex檔案
mex Call_dll_example_mex.c
%-----------------------------------------
```

### 運行方式(Matlab Script):
```matlab
%----------------------------------------
%本範例的運行命令，不加分號可印出變數A的內容。
A=Call_dll_example_mex('example');
%----------------------------------------
```
