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
% �D�g���Ҧ���X�ּ̤ƶq�N��ŦX��F�����r��C
% �u.*?? ����:���N�r���o�ͤ@���H�W���̵u����
% 
input_regexp_str=edi_char_data;
temp_start_keyword='>HEAD';
temp_end_keyword='>';
input_regexp_expression=[temp_start_keyword,'.*?',temp_end_keyword];
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
EDI.HEAD.String=out_regexp_match{1}(1:end-1);
disp(EDI.HEAD.String)
%--
disp('--')
input_regexp_str=EDI.HEAD.String;
temp_start_keyword='LAT=';
temp_end_keyword='\n';
input_regexp_expression=[temp_start_keyword,'.*?',temp_end_keyword];
out_regexp_match=regexp(input_regexp_str,input_regexp_expression,'match');
EDI.HEAD.LAT.String=out_regexp_match{1}(1+length(temp_start_keyword):end-1);
disp(EDI.HEAD.LAT.String)
%--

