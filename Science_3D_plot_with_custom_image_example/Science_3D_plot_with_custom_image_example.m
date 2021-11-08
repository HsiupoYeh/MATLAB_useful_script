%**************************************************************************
%   Name: Science_3D_plot_with_custom_image_example.m v20211021a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20211108a
%   Description: 繪製科學資料圖在自訂圖片上。例如地圖之上。
%                在舊版的MATLAB(應該是MATLAB2014A之前，包含MATLAB2014A)，
%                整個figure會綁同一個colormap，之後才有分開的機制。為了相容
%                舊版，而且部分功能採用比較客製化的設定，因此範例只能一直建立
%                新的figure來展示效果。
%**************************************************************************
    clear;clc;close all
    %----------------------------------------------------------------------
    % 準備繪圖資料
    %--
% 科學數值資料
[Science_Data_XI,Science_Data_YI,Science_Data_ZI] = peaks(30); 
Science_Data_CI=Science_Data_ZI;
%--
% 指定colormap
ScienceTrueColorData_colormap=jet(256);
%--
% 指定顏色範圍
% 如果顏色資料存在超過指定顏色範圍的時候，可能會顯示為錯誤的顏色，所以要對顏色
% 資料先處理，注意，後續數值是被修改過的，只作為顯示目的。
%ScienceTrueColorData_Clim=[min(Science_Data_ZI(:)),max(Science_Data_ZI(:))];%[Clim,Cmax]
ScienceTrueColorData_Clim=[-10,5];%[Clim,Cmax]  
    %--
    % 修改超出顏色範圍的資料
    Science_Data_CI_modified=Science_Data_CI;
    Science_Data_CI_modified(Science_Data_CI_modified>ScienceTrueColorData_Clim(2))=ScienceTrueColorData_Clim(2);
    Science_Data_CI_modified(Science_Data_CI_modified<ScienceTrueColorData_Clim(1))=ScienceTrueColorData_Clim(1);
%--
% 研究區域地圖網格資料建立
% 準備100等分的向量 經度X軸緯度Y軸對應寬(width)x高(height)
Study_Area_X_vector=linspace(-10,10,100);
Study_Area_Y_vector=linspace(-10,10,100);
% 建立網格資料
[Study_Area_XI,Study_Area_YI] = meshgrid(Study_Area_X_vector,Study_Area_Y_vector);
Study_Area_ZI=zeros(size(Study_Area_XI))-3;
%--
% 圖片檔案資料(用來把顏色填入網格中)
Study_Area_Index_Image = imread(['Taiwan.png']);
[Study_Area_Index_Image, Study_Area_colormap]=rgb2ind(Study_Area_Index_Image,256,'nodither');
    %----------------------------------------------------------------------    
    %----------------------------------------------------------------------
    % 開始進行繪圖
    %--
    % 繪圖#1
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    set(gca,'Clim',ScienceTrueColorData_Clim)
    colorbar
    %--
    title('繪圖#1 科學數值曲面圖，沒有調整colormap')    
    %----------------------------------------------------------------------
    % 繪圖#2
    figure
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    title('繪圖#2 研究區域地圖，沒有調整colormap')    
    %----------------------------------------------------------------------
    % 繪圖#3
    figure
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colormap(Study_Area_colormap)
    colorbar
    %--
    title('繪圖#3 研究區域地圖，調整colormap')    
    %----------------------------------------------------------------------
    % #1~#3單獨繪製，確認資料沒錯誤。從圖形位置、顏色來確定。
    %----------------------------------------------------------------------
    % 繪圖#4
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    title('繪圖#4 兩個圖硬擠上去，沒有調整colormap')
    %----------------------------------------------------------------------
    % 繪圖#5
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    colormap(ScienceTrueColorData_colormap)
    set(gca,'Clim',ScienceTrueColorData_Clim)
    %--
    title('繪圖#5 兩個圖硬擠上去，調整成科學資料用的colormap')
    %----------------------------------------------------------------------
    % 繪圖#6
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    colormap(Study_Area_colormap)
    %--
    title('繪圖#6 兩個圖硬擠上去，調整成貼上圖片的colormap')
    %----------------------------------------------------------------------
    % 繪圖#7
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];    
    %--
    colormap(Combined_colormap)    
    %--
    title({'繪圖#7 兩個圖硬擠上去，調整成合併的colormap','colorbar前半段是黑的，後半段是白的'})
    %--
    % 此時colorbar前半段是黑的，後半段是白的。 
    %----------------------------------------------------------------------
    % 繪圖#8
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];    
    % 填入顏色
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap)    
    %--
    title({'繪圖#8 兩個圖硬擠上去，調整成合併的colormap','colorbar前半段是科學資料，後半段是256色圖片資料'})
    %--
    % 此時colorbar前半段是科學資料(沒有資料的會保持黑)，後半段是256色圖片資料(沒有資料的會保持白)。    
    %----------------------------------------------------------------------
    % 繪圖#9
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % 填入顏色
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % 調整顏色範圍，使科學資料顏色正確
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    title({'繪圖#9 兩個圖硬擠上去，調整成合併的colormap','設定正確顏色數值範圍，使科學資料顏色正確'})
    %--
    % 此時colorbar對應科學資料數值已經正確。
    % 但是256色圖片使用的是colormap的index，目前是錯誤的。    
    %----------------------------------------------------------------------
    % 繪圖#10
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖    
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % 填入顏色
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % 平移圖片的index，不確定為什麼要+1，以後再去理解。
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    title({'繪圖#10 兩個圖硬擠上去，調整成合併的colormap','平移圖片CData，圖片色階已經正確'})
    %--
    % 此時colorbar對應256色圖片色階已經正確。
    %----------------------------------------------------------------------
    % 繪圖#11
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorbar;
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % 填入顏色
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % 調整顏色範圍，使科學資料顏色正確
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    % 平移圖片的index，不確定為什麼要+1，以後再去理解。
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    title({'繪圖#11 兩個圖硬擠上去，調整成合併的colormap','科學資料顏色正確，圖片顏色也正確'})
    %--
    % 此時科學資料顏色正確，圖片顏色也正確。
    %----------------------------------------------------------------------
    % 繪圖#12
    figure
    % 科學數值曲面圖   
    surf(Science_Data_XI,Science_Data_YI,Science_Data_ZI,Science_Data_CI_modified);
    %--
    hold on    
    %--
    % 研究區域地圖
    Study_Area_surf=surf(Study_Area_XI,Study_Area_YI,Study_Area_ZI);
    set(Study_Area_surf,'FaceAlpha',0.5,'EdgeColor','none')
    % 貼顏色
    set(Study_Area_surf,'CData',(flipud(Study_Area_Index_Image)),'FaceColor','texturemap','EdgeColor','none','CDataMapping','direct')
    set(Study_Area_surf,'FaceAlpha',0.9)
    colorba_handle=colorbar;
    %--
    % 以下是合併色階的特殊處理:
    %--
    % 計算兩個圖的colormap色階數量
    ScienceTrueColorData_colormap_count=length(ScienceTrueColorData_colormap(:,1));
    %disp(['ScienceTrueColorData_colormap_count=',num2str(ScienceTrueColorData_colormap_count)])
    Study_Area_colormap_count=length(Study_Area_colormap(:,1));
    %disp(['Study_Area_colormap_count=',num2str(Study_Area_colormap_count)])
    %--
    % 以科學資料色階基準量，產生新數量的色階，最少會變成原本的4倍
    % 例如科學資料色階64，圖片色階256，就產生數量64*4=256的色階填全0，放在前。
    % 另外數量64*4=256的色階填全1，放在後，共產生512個色階，也就是colormap矩陣。
    if ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)==1
        Combined_colormap_half_count=2*ScienceTrueColorData_colormap_count;
    else
        Combined_colormap_half_count=ceil(Study_Area_colormap_count/ScienceTrueColorData_colormap_count)*ScienceTrueColorData_colormap_count;
    end
    Combined_colormap=[zeros(Combined_colormap_half_count,3);ones(Combined_colormap_half_count,3)];  
    % 填入顏色
    Combined_colormap(1:ScienceTrueColorData_colormap_count,:)=ScienceTrueColorData_colormap(1:ScienceTrueColorData_colormap_count,:);
    Combined_colormap(ScienceTrueColorData_colormap_count+1,:)=ScienceTrueColorData_colormap(ScienceTrueColorData_colormap_count,:);
    Combined_colormap(Combined_colormap_half_count+1:Combined_colormap_half_count+Study_Area_colormap_count,:)=Study_Area_colormap(1:Study_Area_colormap_count,:);
    %--
    colormap(Combined_colormap) 
    %--
    % 調整顏色範圍，使科學資料顏色正確
    set(gca,'Clim',[ScienceTrueColorData_Clim(1),ScienceTrueColorData_Clim(1)+(ScienceTrueColorData_Clim(2)-ScienceTrueColorData_Clim(1))*(Combined_colormap_half_count/ScienceTrueColorData_colormap_count)*2])
    %--
    % 平移圖片的index，不確定為什麼要+1，以後再去理解。
    set(Study_Area_surf,'CData',double(flipud(Study_Area_Index_Image))+Combined_colormap_half_count+1)
    %--
    % 調整colorbar範圍，只保留想看到的科學資料範圍
    set(colorba_handle,'Ylim',ScienceTrueColorData_Clim)
    %--
    title({'繪圖#12 兩個圖硬擠上去，調整成合併的colormap','科學資料顏色正確，圖片顏色也正確'})
    %--
    % 此時科學資料顏色正確，圖片顏色也正確。
    %----------------------------------------------------------------------
    

    