%**************************************************************************
%   Name: yeh_figure_save_demo_v20220920a.m 
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220920a
%   Description: 輸出圖片範例
%**************************************************************************
%--------------------------------------------------------------------------
% 輸出圖片的時候使用print功能，會重新渲染畫面，以至於不太好調整。故放棄使用。
% 替代方案則是使用getframe與imwrite函數，直接擷取視窗內畫面存成圖檔。
% 在MATLAB2009A時會有一個無法控制的問題，getframe會自動使figure可見，
% MATLAB2014以後不會有這個問題。
%--------------------------------------------------------------------------
clear;clc;close all
%--------------------------------------------------------------------------
% 設定想要的尺寸
figure_Width=1024;
figure_Height=768;
%--
% 建立預設的空白figure視窗
figure_handle=figure('Visible','off','Position',[0,0,figure_Width,figure_Height]);
movegui(gcf,'center')
%--
% 設定背景
set(gcf,'color',[1,1,1])
%--
% 繪圖
[X,Y,Z] = peaks(30);
surfc(X,Y,Z)
colormap hsv
axis([-3 3 -3 3 -10 10])
%--
% 嘗試擷取視窗顯示內容，若用MATLAB2009A會強迫顯示，MATLAB2004B以後不會強迫顯示
temp_frame=getframe(figure_handle);
% set(gcf,'Visible','off');若MATLAB2009A會強迫顯示時，可考慮手動隱藏，但是螢幕會閃一下。
%--
set(gcf,'Visible','on');%檢查圖片可開啟。
%--
% 印出目前figure尺寸
current_figure_Width=length(temp_frame.cdata(1,:,1));
current_figure_Height=length(temp_frame.cdata(:,1,1));
disp(['figure size (WxH) = ', ...
    num2str(current_figure_Width), ...
    'x',...
    num2str(current_figure_Height)
    ])
%--
% 將畫素資料存成圖檔
imwrite(temp_frame.cdata,['output.png']);
%--
% 關閉figure視窗
% close(figure_handle)
%--------------------------------------------------------------------------