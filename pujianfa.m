clc;
clear all;
 % ѡ��ɾ�ԭʼ��Ƶ�ļ�
[x fs]=audioread('clean.wav'); 
N=length(x);
x = x(1:N,1);     % �����˫������ȡ��ͨ��
max_x = max(x);

% ��Ӻ�������
[y fs]=audioread('5dB_noisy.wav');
%sound(y,fs);
noise_estimated = y(1:1000*fs/1000,1);  %ȡǰ1����Ϊ��������ȥ��

fft_y = fft(y);
fft_n = fft(noise_estimated);
E_noise = sum(abs(fft_n)) /length(noise_estimated);
mag_y = abs(fft_y);
phase_y = angle(fft_y);   % ������λ��Ϣ
mag_s = mag_y - E_noise;
mag_s(mag_s<0)=0;
 
% �ָ�
fft_s = mag_s .* exp(1i.*phase_y);
s = ifft(fft_s);
%sound(s,fs);
audiowrite('pujian.wav',s,fs);
subplot(321);plot(x);ylim([-1.5,1.5]);title('ԭʼ�ɾ��ź�');xlabel('ʱ��');ylabel('����');
subplot(323);plot(y);ylim([-1.5,1.5]);title('�����ź�');xlabel('ʱ��');ylabel('����');
subplot(325);plot(real(s));ylim([-1.5,1.5]);title('�׼���ȥ����ź�');xlabel('ʱ��');ylabel('����');
subplot(322);myspectrogram(x,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�ɾ��źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(324);myspectrogram(y,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�����źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(326);myspectrogram(s,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�׼�����ǿ���źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
