%����ԭʼ�ź� s(n) �ɾ�����
[y,Fs]=audioread('clean.wav');
% sound(y,Fs);
n=length(y);
%�����۲��ź�x(n)=s(n)+v(n) 
%v(n)������ѡ�������
%v = wgn(n,1,0.2);
% sound(v,Fs);
% �����۲��ź�
%x=awgn(y,20);
[x,Fs]= audioread('5dB_noisy.wav');
%sound(x,Fs);
% audiowrite('snp232_003.wav',x,Fs);
%ά���˲���Ƶ������ʵ��
Rxx=xcorr(x);
Gxx=fft(Rxx,n);
Rxy=xcorr(x,y);
Gxs=fft(Rxy,n);
H=Gxs./Gxx;
Ps=fftn(y);
S=H.*Ps;
ss=real(ifft(S));
ss=ss(1:n);
%sound(ss,Fs);
%audiowrite('weina.wav',ss,Fs);
% %�������
% 
% figure(4);
% t=(40000:44800);
% plot(t,ss(40000:44800,1 ),'-',t,y(40000:44800,1),'-.');
% ylabel('����');
% xlabel('ʱ��');
% legend('�ָ���ԭʼ�ź��ź�','ԭʼ�ź�');
% title('�źűȽ�');
% grid on;
audiowrite('weinafaend.wav',ss,fs);
subplot(321);plot(y);xlabel('ʱ��');ylabel('����');title('ԭʼ�źŵĲ���');
subplot(323);plot(x);xlabel('ʱ��');ylabel('����');title('�۲��źŵĲ���');
subplot(325);plot(ss);xlabel('ʱ��');ylabel('����');title('ά���˲��ָ�ԭʼ�źŵĲ���');
subplot(322);myspectrogram(y,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�ɾ��źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(324);myspectrogram(x,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('�����źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(326);myspectrogram(ss,fs);colormap(jet);time=(0:length(x)-1)/fs;axis([0 max(time*1000) 0 8000]);title('ά���˲���ǿ���źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');

