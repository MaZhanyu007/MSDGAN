%����ԭʼ�ź� s(n) �ɾ�����
%[y,Fs]=audioread('p232_003.wav');
[y,Fs]=audioread('clean.wav');
% sound(y,Fs);
n=length(y);
%���Ʋ���
figure(1);
plot(y);
xlabel('ʱ��');
ylabel('����');
title('ԭʼ�źŵĲ���');
grid on;

%�����۲��ź�x(n)=s(n)+v(n) 
%v(n)������ѡ�������
%v = wgn(n,1,0.2);
% sound(v,Fs);
% �����۲��ź�
%x=awgn(y,20);
[x,Fs]= audioread('5dB_noisy.wav');
%sound(x,Fs);
audiowrite('snp232_003.wav',x,Fs);
figure(2);
plot(x);
xlabel('ʱ��');
ylabel('����');
title('�۲��źŵĲ���');
grid on;

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
sound(ss,Fs);

%audiowrite('weina.wav',ss,Fs);
figure(3);
plot(ss);
xlabel('ʱ��');
ylabel('����');
title('�ָ�ԭʼ�źŵĲ���');
grid on;

%�������
figure(4);
t=(40000:44800);
plot(t,ss(40000:44800,1 ),'-',t,y(40000:44800,1),'-.');
ylabel('����');
xlabel('ʱ��');
legend('�ָ���ԭʼ�ź��ź�','ԭʼ�ź�');
title('�źűȽ�');
grid on;


