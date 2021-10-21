%**************************************************************************
%   Name: yeh_ini2struct_ansi.m v20211021a
%   Copyright:  
%   Author: HsiupoYeh 
%   Version: v20211021a
%   Description: Ū��INI�ɮת���ơAINI�ɮ׽s�X�ݬ�ANSI
%   �I�s��k: 
%       yeh_ini2struct('Config.ini');
%**************************************************************************
function IniFile = yeh_ini2struct_ansi(input_ini_file_name)
    %----------------------------------------------------------------------
    IniFile.Struct=[];
    IniFile.Error.String=[];
    %----------------------------------------------------------------------
    % �}���ɮ�    
    fid = fopen(input_ini_file_name,'r');  
    if fid<0
        disp(['�}���ɮץ���!return!�ɮצW��:',input_ini_file_name,'.'])
        EarthImagerOutFile.Error.String=['�}���ɮץ���!return!�ɮצW��:',input_ini_file_name,'.'];
        return
    end
    %--
    % �j��̧ǳv��Ū�������ɮ׵���
    while ~feof(fid)
        % Ū���@��
        temp_str=fgetl(fid);
        % �h���Y���ťզr��
        temp_str = strtrim(temp_str);        
        % �����ťզ�B�������ѡB���r������
        if isempty(temp_str) || temp_str(1)==';' || temp_str(1)=='#' 
            continue
        end
        % ��쥪���A����ܰ϶��_�I�A�إߤ@�ӵ��c��
        if temp_str(1)=='['
            % ��genvarname�Ӳ��ͦw�����ܼƦW��
            temp_section = genvarname(strtok(temp_str(2:end),']'));
            % ���c��u.()�v�̭��i�H��r���ܼƨӨ���
            % �Ytemp_section='abc'�A�hStruct.(temp_section)���P��Struct.abc
            IniFile.Struct.(temp_section) = [];            
            continue
        end
        % ��������e�P���᪺�r��C�Ҧp�uA="CD"�v�A��uA�v�M�u="CD"�v
        [temp_Key,temp_Value] = strtok(temp_str, '='); 
        % �h���������A���i��e��|���Ů�A�]�h����
        temp_Value = strtrim(temp_Value(2:end));
        % �P�_�Ȫ��i���: �Ū��ε��Ѫ��B���޸����B��޸���
        if isempty(temp_Value) || temp_Value(1)==';' || temp_Value(1)=='#' 
            temp_Value = [];
        elseif temp_Value(1)=='"'                    
            temp_Value = strtok(temp_Value, '"');
        elseif temp_Value(1)==''''                     
            temp_Value = strtok(temp_Value, '''');
        else
            % �U�@�᭱�٦����ѡA�u�����Ѥ��e��
            temp_Value = strtok(temp_Value, ';');
            temp_Value = strtok(temp_Value, '#'); 
            % �A���T�O�������r��S���ť�
            temp_Value = strtrim(temp_Value);
            % �����ഫ���Ʀr
            [temp_num, status] = str2num(temp_Value);      
            if status
                temp_Value = temp_num; 
            end   
        end
        % ���c����
        if ~exist('temp_section', 'var')             
            IniFile.Struct.(genvarname(temp_Key)) = temp_Value;
        else
            IniFile.Struct.(temp_section).(genvarname(temp_Key)) = temp_Value;
        end

    end
    %--
    % �����ɮ�
    fclose(fid);
    %---------------------------------------------------------------------- 
end



    
    