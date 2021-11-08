%**************************************************************************
%   Name: Science_3D_plot_with_custom_image_example.m v20211021a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20211108a
%   Description: ø�s��Ǹ�ƹϦb�ۭq�Ϥ��W�C�Ҧp�a�Ϥ��W�C
%                �b�ª���MATLAB(���ӬOMATLAB2014A���e�A�]�tMATLAB2014A)�A
%                ���figure�|�j�P�@��colormap�A����~�����}������C���F�ۮe
%                �ª��A�ӥB�����\��ĥΤ���Ȼs�ƪ��]�w�A�]���d�ҥu��@���إ�
%                �s��figure�Ӯi�ܮĪG�C
%**************************************************************************
    clear;clc;close all
    %----------------------------------------------------------------------
    % �ǳ�ø�ϸ��
    %--
% ��Ǽƭȸ��
[Science_Data_XI,Science_Data_YI,Science_Data_ZI] = peaks(30); 
Science_Data_CI=Science_Data_ZI;
%--
% ���wcolormap
ScienceTrueColorData_colormap=jet(256);
%--
% ���w�C��d��
% �p�G�C���Ʀs�b�W�L���w�C��d�򪺮ɭԡA�i��|��ܬ����~���C��A�ҥH�n���C��
% ��ƥ��B�z�A�`�N�A����ƭȬO�Q�ק�L���A�u�@����ܥت��C
%ScienceTrueColorData_Clim=[min(Science_Data_ZI(:)),max(Science_Data_ZI(:))];%[Clim,Cmax]
ScienceTrueColorData_Clim=[-10,5];%[Clim,Cmax]  
    %--
    % �ק�W�X�C��d�򪺸��
    Science_Data_CI_modified=Science_Data_CI;
    Science_Data_CI_modified(Science_Data_CI_modified>ScienceTrueColorData_Clim(2))=ScienceTrueColorData_Clim(2);
    Science_Data_CI_modified(Science_Data_CI_modified<ScienceTrueColorData_Clim(1))=ScienceTrueColorData_Clim(1);
%--
% ��s�ϰ�a�Ϻ����ƫإ�
% �ǳ�100�������V�q �g��X�b�n��Y�b�����e(width)x��(height)
Study_Area_X_vector=linspace(-10,10,100);
Study_Area_Y_vector=linspace(-10,10,100);
% �إߺ�����
[Study_Area_XI,Study_Area_YI] = meshgrid(Study_Area_X_vector,Study_Area_Y_vector);
Study_Area_ZI=zeros(size(Study_Area_XI))-3;
%--
% �Ϥ��ɮ׸��(�Ψӧ��C���J���椤)
Study_Area_Index_Image = imread(['Taiwan.png']);
[Study_Area_Index_Image, Study_Area_colormap]=rgb2ind(Study_Area_Index_Image,256,'nodither');
    %----------------------------------------------------------------------    
    %----------------------------------------------------------------------
    % �}�l�i��ø��
    %--
    % ø��#1
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    set(gca,'Clim',ScienceTrueColorData_Clim)
    colorbar
    %--
    title('ø��#1 ��ǼƭȦ����ϡA�S���վ�colormap')    
    %----------------------------------------------------------------------
    % ø��#2
    figure
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    title('ø��#2 ��s�ϰ�a�ϡA�S���վ�colormap')    
    %----------------------------------------------------------------------
    % ø��#3
    figure
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colormap(Study_Area_colormap)
    colorbar
    %--
    title('ø��#3 ��s�ϰ�a�ϡA�վ�colormap')    
    %----------------------------------------------------------------------
    % #1~#3��Wø�s�A�T�{��ƨS���~�C�q�ϧΦ�m�B�C��ӽT�w�C
    %----------------------------------------------------------------------
    % ø��#4
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    title('ø��#4 ��ӹϵw���W�h�A�S���վ�colormap')
    %----------------------------------------------------------------------
    % ø��#5
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    colormap(ScienceTrueColorData_colormap)
    set(gca,'Clim',ScienceTrueColorData_Clim)
    %--
    title('ø��#5 ��ӹϵw���W�h�A�վ㦨��Ǹ�ƥΪ�colormap')
    %----------------------------------------------------------------------
    % ø��#6
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    colormap(Study_Area_colormap)
    %--
    title('ø��#6 ��ӹϵw���W�h�A�վ㦨�K�W�Ϥ���colormap')
    %----------------------------------------------------------------------
    % ø��#7
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];    
    %--
    colormap(Combined_colormap)    
    %--
    title({'ø��#7 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','colorbar�e�b�q�O�ª��A��b�q�O�ժ�'})
    %--
    % ����colorbar�e�b�q�O�ª��A��b�q�O�ժ��C 
    %----------------------------------------------------------------------
    % ø��#8
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];    
    % ��J�C��
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap)    
    %--
    title({'ø��#8 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','colorbar�e�b�q�O��Ǹ�ơA��b�q�O256��Ϥ����'})
    %--
    % ����colorbar�e�b�q�O��Ǹ��(�S����ƪ��|�O����)�A��b�q�O256��Ϥ����(�S����ƪ��|�O����)�C    
    %----------------------------------------------------------------------
    % ø��#9
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % ��J�C��
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % �վ��C��d��A�Ϭ�Ǹ���C�⥿�T
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    title({'ø��#9 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','�]�w���T�C��ƭȽd��A�Ϭ�Ǹ���C�⥿�T'})
    %--
    % ����colorbar������Ǹ�ƼƭȤw�g���T�C
    % ���O256��Ϥ��ϥΪ��Ocolormap��index�A�ثe�O���~���C    
    %----------------------------------------------------------------------
    % ø��#10
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��    
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % ��J�C��
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % �����Ϥ���index�A���T�w������n+1�A�H��A�h�z�ѡC
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    title({'ø��#10 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','�����Ϥ�CData�A�Ϥ��ⶥ�w�g���T'})
    %--
    % ����colorbar����256��Ϥ��ⶥ�w�g���T�C
    %----------------------------------------------------------------------
    % ø��#11
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar;
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % ��J�C��
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % �վ��C��d��A�Ϭ�Ǹ���C�⥿�T
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    % �����Ϥ���index�A���T�w������n+1�A�H��A�h�z�ѡC
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    title({'ø��#11 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','��Ǹ���C�⥿�T�A�Ϥ��C��]���T'})
    %--
    % ���ɬ�Ǹ���C�⥿�T�A�Ϥ��C��]���T�C
    %----------------------------------------------------------------------
    % ø��#12
    figure
    % ��ǼƭȦ�����   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % ��s�ϰ�a��
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % �K�C��
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorba_handle=colorbar;
    %--
    % �H�U�O�X�֦ⶥ���S��B�z:
    %--
    % �p���ӹϪ�colormap�ⶥ�ƶq
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % �H��Ǹ�Ʀⶥ��Ƕq�A���ͷs�ƶq���ⶥ�A�ַ̤|�ܦ��쥻��4��
    % �Ҧp��Ǹ�Ʀⶥ64�A�Ϥ��ⶥ256�A�N���ͼƶq64*4=256���ⶥ���0�A��b�e�C
    % �t�~�ƶq64*4=256���ⶥ���1�A��b��A�@����512�Ӧⶥ�A�]�N�Ocolormap�x�}�C
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % ��J�C��
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % �վ��C��d��A�Ϭ�Ǹ���C�⥿�T
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    % �����Ϥ���index�A���T�w������n+1�A�H��A�h�z�ѡC
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    % �վ�colorbar�d��A�u�O�d�Q�ݨ쪺��Ǹ�ƽd��
    set(colorba_handle,'Ylim',ScienceTrueColorData_Clim)
    %--
    title({'ø��#12 ��ӹϵw���W�h�A�վ㦨�X�֪�colormap','��Ǹ���C�⥿�T�A�Ϥ��C��]���T'})
    %--
    % ���ɬ�Ǹ���C�⥿�T�A�Ϥ��C��]���T�C
    %----------------------------------------------------------------------
    

    