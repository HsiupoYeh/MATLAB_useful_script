%**************************************************************************
%   Name: yeh_figure_save_demo_v20220920a.m 
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20220920a
%   Description: ��X�Ϥ��d��
%**************************************************************************
%--------------------------------------------------------------------------
% ��X�Ϥ����ɭԨϥ�print�\��A�|���s��V�e���A�H�ܩ󤣤Ӧn�վ�C�G���ϥΡC
% ���N��׫h�O�ϥ�getframe�Pimwrite��ơA�����^���������e���s�����ɡC
% �bMATLAB2009A�ɷ|���@�ӵL�k������D�Agetframe�|�۰ʨ�figure�i���A
% MATLAB2014�H�ᤣ�|���o�Ӱ��D�C
%--------------------------------------------------------------------------
clear;clc;close all
%--------------------------------------------------------------------------
% �]�w�Q�n���ؤo
figure_Width=1024;
figure_Height=768;
%--
% �إ߹w�]���ť�figure����
figure_handle=figure('Visible','off','Position',[0,0,figure_Width,figure_Height]);
movegui(gcf,'center')
%--
% �]�w�I��
set(gcf,'color',[1,1,1])
%--
% ø��
[X,Y,Z] = peaks(30);
surfc(X,Y,Z)
colormap hsv
axis([-3 3 -3 3 -10 10])
%--
% �����^��������ܤ��e�A�Y��MATLAB2009A�|�j����ܡAMATLAB2004B�H�ᤣ�|�j�����
temp_frame=getframe(figure_handle);
% set(gcf,'Visible','off');�YMATLAB2009A�|�j����ܮɡA�i�Ҽ{������áA���O�ù��|�{�@�U�C
%--
set(gcf,'Visible','on');%�ˬd�Ϥ��i�}�ҡC
%--
% �L�X�ثefigure�ؤo
current_figure_Width=length(temp_frame.cdata(1,:,1));
current_figure_Height=length(temp_frame.cdata(:,1,1));
disp(['figure size (WxH) = ', ...
    num2str(current_figure_Width), ...
    'x',...
    num2str(current_figure_Height)
    ])
%--
% �N�e����Ʀs������
imwrite(temp_frame.cdata,['output.png']);
%--
% ����figure����
% close(figure_handle)
%--------------------------------------------------------------------------