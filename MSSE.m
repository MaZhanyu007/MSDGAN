clear all;
%-----------------���������ļ�------------------------
[speech,fs,nbits]=wavread('5dB_noisy.wav');
%------------------��������-----------------------------
%------------------��������-----------------------------
winsize=256; %����
n=0.04; %����ˮƽ
size=length(speech); %��������
numofwin=floor(size/winsize); %֡��
ham=hamming(winsize)'; %����������
hanwin=zeros(1,size); %���庺�����ĳ���
enhanced=zeros(1,size); %������ǿ�����ĳ���
clean=zeros(1,winsize);
x=speech'+n*randn(1,size); %���������ź�
noisy=n*randn(1,winsize);
N=fft(noisy); %����������Ҷ�任
nmag=abs(N); %����������
%-------------------��֡-------------------------
for q=1:2*numofwin-1
frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2);
%-------------------�Դ�������֡���ص�һ��ȡֵ--------------------
hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;
%-------------------�Ӵ�----------------------------------
y=fft(frame.*ham); %�Դ�����������Ҷ�任
mag=abs(y); %��������������
phase=angle(y); %����������λ
%-------------------�����׼�---------------------------------------------------
for i=1:winsize
    if mag(i)-nmag*(i)>0
        clean(i)=mag(i)-nmag(i);
    else
        clean(i)=0;
    end
end
%-----------------��Ƶ�������ºϳ�����---------------------------------------------
spectral=clean.*exp(1i*phase);
%-----------------������Ҷ�任���ص����----------------------------------------
enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral))

end

%------------------��ȥ���������������--------------------------------------

for i=1:size
    if hanwin(i)==0
    enhanced(i)=0
    else
    enhanced(i)=enhanced(i)/hanwin(i);
    end
end

%������ǿǰ��������
%SNR1=10*log10(var(speech')/var(noisy));
%�������������
%SNR2=10*log10(var(speech')/var(enhanced-speech'));
%��ǿ���������
wavwrite(x,fs,nbits,'noisy.wav');
%�����ǿ�ź�
wavwrite(enhanced,fs,nbits,'enhanced.wav')
%�����ǿ�ź�
%---------------������
figure(1);
subplot(3,1,1);plot(speech');title('yuanshiyuyinboxing');xlabel('yangdianshu');ylabel('fudu');axis([0 2.5*10^4-0.3 0.3]);
subplot(3,1,2);plot(x);title('jiazaoyuyinboxing');xlabel('yangdianshu');ylabel('fudu');axis([0 2.5*10^4-0.3 0.3]);
subplot(3,1,3);plot(enhanced);title('zengqiangyuyinboxing');xlabel('yangdianshu');ylabel('fudu');axis([0 2.5*10^4-0.3 0.3]);

