[y,fs]=audioread('clean.wav');
[x,fs]=audioread('5dB_noisy.wav');
[s,fs]=audioread('enhanced_5dB_noisy.wav');
subplot(321);plot(y);xlabel('ʱ��');ylabel('����');title('ԭʼ�źŵĲ���');
subplot(323);plot(x);xlabel('ʱ��');ylabel('����');title('�۲��źŵĲ���');
subplot(325);plot(s);xlabel('ʱ��');ylabel('����');title('SEGAN��ǿ�źŵĲ���');
subplot(322);myspectrogram(y,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�ɾ��źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(324);myspectrogram(x,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�����źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(326);myspectrogram(s,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('SEGAN��ǿ���źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
