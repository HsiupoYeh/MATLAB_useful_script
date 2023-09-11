clear;clc;close all
Input_EDI_file_name='LRN01_edit.edi';
%==========================================================================
% �N�ɮפ��e�������J��O���餤 �}�l
%--------------------------------------------------------------------------
% �}���ɮ�
f1=fopen(Input_EDI_file_name,'rt');
if (f1<0)
    disp('�}���ɮץ���!return!')
    return
end
%--
% ��fread�������J�ӥ[�ָ��J�ɮ׳t��
temp_data=fread(f1);
%--------------------------------------------------------------------------
% �����ɮ�
fclose(f1);
%--------------------------------------------------------------------------
% �N�ɮפ��e�������J��O���餤 ����
%==========================================================================
%==========================================================================
% ��m�}�C�ϸ�Ʀ����@��C�A�Y�}�C�j�p<1xN>�A���ର�r����
edi_char_data=char(temp_data');
edi_char_data_count=length(edi_char_data);
disp(['��EDI�ɮפj�p = ',num2str(edi_char_data_count)])
%--
% MATLAB ���W��F��
% �ھ�EDI���A6.23���`�AEDI�榡���Ҧ����e��ANSI�s�X�C�o��ܩҦ����e�O�����\����
% �媺�C����ڤW�A�\�h�n�餴���ըϥβ{�b�y�檺ANSI��UTF-8�榡���x�s�A�o�Ǯ榡���\
% �x�s���P�y�t����r�A����s�X���P�bŪ���W�n�S�O�p�ߡA�����B���OANSI�s�X�b���P��
% ���U���O�ۦP���A�]���Ĩī��ӭ�W���ϥ�ASCII�ӳB�z�O��²�檺�C�@��Ө��A���n����
% ����짡���^�Ʀr�A�Ȧ������Φa�W�H�W�����إi��|���ҥ~�r���C
%--
% ���骺���AEDI���A6.23���`�A�W�w�F�i�Ϊ��s�X:
% 0x00 -> ����ĳ�ΡA�����ɭԥi�ऴ���H�n�γo�ӨӶ�R�ƾڡC�Щ����L�C
% 0x01 ~ 0x09 -> �T�ΡA���i���r��
% 0x0A -> �i�H�ΡA����A���i���r��
% 0x0B ~ 0x0C -> �T�ΡA���i���r��
% 0x0D -> �i�H�ΡA�^���A���i���r��
% 0x0E ~ 0x1F -> �T�ΡA���i���r��
% 0x20 ~ 0x7E -> �i�H�ΡA�i���r��
% 0x7F -> �T�ΡA���i���r��
% 0x80 ~ 0xFE-> �S�W�w����ΡA�����n����ưϰ쳣���|�Ψ�A�i���r��
% 0xFF -> �T�ΡA���i���r��
% ��X�H�W�A���F�m�ߥ��W��F���A�ڭ̲{�b�N�O���\�Ҧ��i���r���B����H�Φ^���C
%--
disp('--')
%--
disp('�G�N�g���d��:')
% ���W��F��:�d�ߦ��h�֭�0x00
input_regexp_str=edi_char_data;
input_regexp_expression='[\x00]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x00�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x0A
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0A]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x0A�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x0B~0x0C
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0B-\x0C]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x0B~0x0C�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x0D
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0D]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x0D�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x0E~0x1F
input_regexp_str=edi_char_data;
input_regexp_expression='[\x0E-\x1F]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x0E~0x1F�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x20~0x7E
input_regexp_str=edi_char_data;
input_regexp_expression='[\x20-\x7E]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x20~0x7E�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x7F
input_regexp_str=edi_char_data;
input_regexp_expression='[\x7F]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x7F�C'])
%--
% ���W��F��:�d�ߦ��h�֭�0x80 ~ 0xFE
input_regexp_str=edi_char_data;
input_regexp_expression='[\x80-\xFE]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0x80~0xFE�C'])
% ���W��F��:�d�ߦ��h�֭�0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'��0xFF�C'])
%--
disp('--')
%--
disp('������Ϊ�����:')
% ����EDI�ɮפ��A���X�k�r�����ƶq
% ���W��F��:�d�ߦ��h�֭�0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[\x00\x01-\x09\x0B\x0C\x0E-\x1F\x7F\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'�Ӥ��X�k�r���C'])
%--
% ����EDI�ɮפ��A�X�k�r�����ƶq
% ���W��F��:�d�ߦ��h�֭�0xFF
input_regexp_str=edi_char_data;
input_regexp_expression='[^\x00\x01-\x09\x0B\x0C\x0E-\x1F\x7F\xFF]';
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
temp_count=length(out_regexp_match);
disp(['��EDI���e��',num2str(temp_count),'�ӦX�k�r���C'])
%--
disp('--')
%--