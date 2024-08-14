%**************************************************************************
%   Name: yeh_FileisUTF8noBOM_load_all.m v20240814a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20240814a
%   Description: �˴��ɮפ��e�O�_���LBOM��UTF8�C
%   �I�s��k: 
%        FileisUTF8noBOM=yeh_FileisUTF8noBOM_load_all('File.txt');
%**************************************************************************
function FileisUTF8noBOM=yeh_FileisUTF8noBOM_load_all(Input_file_name)
%----------------------------------------------------------------------
%  REF:
%    http://www.unicode.org/versions/Unicode7.0.0/UnicodeStandard-7.0.pdf
%    page 124, 3.9 "Unicode Encoding Forms", "UTF-8"
% 
% 
%   Table 3-7. Well-Formed UTF-8 Byte Sequences
%----------------------------------------------------------------------
%   |  Code Points        | First Byte | Second Byte | Third Byte | Fourth Byte |
%   |  U+0000..U+007F     |     00..7F |             |            |             |
%   |  U+0080..U+07FF     |     C2..DF |      80..BF |            |             |
%   |  U+0800..U+0FFF     |         E0 |      A0..BF |     80..BF |             |
%   |  U+1000..U+CFFF     |     E1..EC |      80..BF |     80..BF |             |
%   |  U+D000..U+D7FF     |         ED |      80..9F |     80..BF |             |
%   |  U+E000..U+FFFF     |     EE..EF |      80..BF |     80..BF |             |
%   |  U+10000..U+3FFFF   |         F0 |      90..BF |     80..BF |      80..BF |
%   |  U+40000..U+FFFFF   |     F1..F3 |      80..BF |     80..BF |      80..BF |
%   |  U+100000..U+10FFFF |         F4 |      80..8F |     80..BF |      80..BF |
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% ��l�q���O�LBOM��UTF-8�s�X
FileisUTF8noBOM.isUTF8noBOM=1;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
FileisUTF8noBOM.Description='���ɮפ��e�ŦX�LBOM��UTF-8�s�X�A�����O�ҽT��O�Φ��s�X�C';
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% �N�ɮץ������J�O���餤�A���IO�[�t�B��ɶ��A���i�ण�A�X�W�j�ɮסC
%----------------------------------------------------------------------
% �}���ɮ�    
fid = fopen(Input_file_name,'r');
if fid<0
    FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
    FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�}���ɮץ���!';
    disp(['�˴����G��:�_�C��]:�}���ɮץ���!return!'])
    return
end
%--
% �������J�O���餤�A�B�ϥΤQ�i��ƭ��x�s�C
str_vector = fread(fid)';
%--
% �����ɮ�
fclose(fid);
%----------------------------------------------------------------------
% BOM �ˬd
if (str_vector(1) ==239 && str_vector(2) <=187 && str_vector(3) ==191)% 0xEF(239), 0xBB(187), 0xBF(191)
    FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
    FileisUTF8noBOM.Description='�˴����G��:�_�C��]:���ɮ׬O��BOM��UTF-8�s�X!';
    disp(['�˴����G��:�_�C��]:���ɮ׬O��BOM��UTF-8�s�X!return!'])
    return
end
%----------------------------------------------------------------------

%----------------------------------------------------------------------
% �v�Ӧ줸�˴����e�O�_�ŦXUTF-8�s�X�W�d
%--
% �ؼ��ˬd�줸����
str_vector_index=1;
% �̤j�ˬd�줸����
max_str_vector_index=length(str_vector);
%--
% �v���ˬd
while(1)
    %--
    if str_vector(str_vector_index)<=127% 00..7F(0~127) �A�o�O1��Byte��ܤ@�Ӧr��
        %----------------------------------------------------------------------
        %disp(['1Byte: ',native2unicode(str_vector(str_vector_index),'UTF-8')])
        str_vector_index=str_vector_index+1;
        %----------------------------------------------------------------------
    elseif (str_vector(str_vector_index) >=194 && str_vector(str_vector_index) <=223)%  C2..DF(194~223) 80..BF(128~191)�A�o�O2��Byte��ܤ@�Ӧr��
        %----------------------------------------------------------------------
        if (str_vector_index+1 <= max_str_vector_index) %�T�{��2��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191)%  C2..DF(194~223) 80..BF(128~191)�A�o�O2��Byte��ܤ@�Ӧr��
                %disp(['2Byte[C2~DF]: ',native2unicode(str_vector(str_vector_index:str_vector_index+1),'UTF-8')])
                str_vector_index=str_vector_index+2;                
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������2Byte (|C2..DF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������2Byte (|C2..DF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��2Byte (|C2..DF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��2Byte (|C2..DF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------
	elseif (str_vector(str_vector_index) ==224)% E0(224) A0..BF(160~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %�T�{��3��Byte
            if (str_vector(str_vector_index+1) >=160 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% E0(224) A0..BF(160~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��
                %disp(['3Byte[E0]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������3Byte (|E0|A0..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������3Byte (|E0|A0..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|E0|A0..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|E0|A0..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------
    elseif (str_vector(str_vector_index) >=225 && str_vector(str_vector_index) <=236)% E1..EC(225~236) 80..BF(128~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��    
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %�T�{��3��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% E1..EC(225~236) 80..BF(128~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��    
                %disp(['3Byte[E1~EC]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������3Byte (|E1..EC|80..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������3Byte (|E1..EC|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|E1..EC|80..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|E1..EC|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------       
 elseif (str_vector(str_vector_index) ==237)% ED(237) 80..9F(128~159) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %�T�{��3��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=159 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)%  ED(237) 80..9F(128~159) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��
                %disp(['3Byte[ED]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������3Byte (|ED|80..9F|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������3Byte (|ED|80..9F|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|ED|80..9F|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|ED|80..9F|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------
     elseif (str_vector(str_vector_index) >=238 && str_vector(str_vector_index) <=239)% EE..EF(238~239) 80..BF(128~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��    
        %----------------------------------------------------------------------
        if (str_vector_index+2 <= max_str_vector_index) %�T�{��3��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191)% EE..EF(238~239) 80..BF(128~191) 80..BF(128~191)�A�o�O3��Byte��ܤ@�Ӧr��    
                %disp(['3Byte[EE~EF]: ',native2unicode(str_vector(str_vector_index:str_vector_index+2),'UTF-8')])
                str_vector_index=str_vector_index+3;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������3Byte (|EE..EF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������3Byte (|EE..EF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|EE..EF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��3Byte (|EE..EF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------          
     elseif (str_vector(str_vector_index) ==240)% F0(240) 90..BF(144~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %�T�{��4��Byte
            if (str_vector(str_vector_index+1) >=144 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F0(240) 90..BF(144~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��    
                %disp(['4Byte[F0]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������4Byte (|F0|90..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������4Byte (|F0|90..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F0|90..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F0|90..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------         
     elseif (str_vector(str_vector_index) >=241 && str_vector(str_vector_index) <=243)% F1..F3(241~243) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %�T�{��4��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F1..F3(241~243) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��    
                %disp(['4Byte[F1~F3]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������4Byte (|F1..F3|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������4Byte (|F1..F3|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F1..F3|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F1..F3|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------    
     elseif (str_vector(str_vector_index) ==244)% F4(244) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��    
        %----------------------------------------------------------------------
        if (str_vector_index+3 <= max_str_vector_index) %�T�{��4��Byte
            if (str_vector(str_vector_index+1) >=128 && str_vector(str_vector_index+1) <=191 && str_vector(str_vector_index+2) >=128 && str_vector(str_vector_index+2) <=191 && str_vector(str_vector_index+3) >=128 && str_vector(str_vector_index+3) <=191)% F4(244) 80..BF(128~191) 80..BF(128~191) 80..BF(128~191)�A�o�O4��Byte��ܤ@�Ӧr��        
                %disp(['4Byte[F4]: ',native2unicode(str_vector(str_vector_index:str_vector_index+3),'UTF-8')])
                str_vector_index=str_vector_index+4;
            else
                FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
                FileisUTF8noBOM.Description='�˴����G��:�_�C��]:������4Byte (|F4|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
                disp(['�˴����G��:�_�C��]:������4Byte (|F4|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
                return
            end
        else
            FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
            FileisUTF8noBOM.Description='�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F4|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!';
            disp(['�˴����G��:�_�C��]:�ƶq�ꤣ��4Byte (|F4|80..BF|80..BF|80..BF|)��UTF-8�s�X�W�h!return!'])
            return
        end
        %----------------------------------------------------------------------       
    else
        %----------------------------------------------------------------------
        FileisUTF8noBOM.isUTF8noBOM=0;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
        FileisUTF8noBOM.Description='�˴����G��:�_�C��]:���s�b��UTF-8�s�X�W�h!';
        disp(['�˴����G��:�_�C��]:��]:���s�b��UTF-8�s�X�W�h!return!'])
        return
        %----------------------------------------------------------------------
    end    
    %--
    if str_vector_index>=max_str_vector_index
        FileisUTF8noBOM.isUTF8noBOM=1;%0=���O�A1=�O�LBOM��UTF-8�s�X�C
        FileisUTF8noBOM.Description='���ɮפ��e�ŦX�LBOM��UTF-8�s�X�A�����O�ҽT��O�Φ��s�X�C';
        disp(['�˴����G��:�O�C��]:���ɮפ��e�ŦX�LBOM��UTF-8�s�X�A�����O�ҽT��O�Φ��s�X�C'])
        return
    end  
    %--
end