% function [Output] = kalman(NoisyInput,Fs,Noise)
% �������˲�����
[Input, Fs] = audioread('clean.wav');
Input = Input(:,1);
% Noise = normrnd(0,sqrt(0.001),size(Input));
[NoisyInput Fs] = audioread('5dB_noisy.wav');
Time = (0:1/Fs:(length(Input)-1)/Fs)';
Noise=NoisyInput(1:1000*Fs/1000,1);
% ������������
Len_windowT = 0.0025; % ����2.5ms
Hop_Percent = 1; % ����ռ��
AR_Order = 20; % �Իع��˲����׶�
Num_Iter = 7; %��������

%��֡�Ӵ�����
Len_WinFrame = fix(Len_windowT * Fs);
Window = ones(Len_WinFrame,1);
[Frame_Signal, Num_Frame] = KFrame(NoisyInput, Len_WinFrame, Window, Hop_Percent);

%��ʼ��
H = [zeros(1,AR_Order-1),1];   % �۲����
R = var(Noise);     % ��������
[FiltCoeff, Q] = lpc(Frame_Signal, AR_Order);   % LPCԤ�⣬�õ��˲�����ϵ��
P = R * eye(AR_Order,AR_Order);   % ���Э�������
Output = zeros(1,size(NoisyInput,1));   % ����ź�
Output(1:AR_Order) = NoisyInput(1:AR_Order,1)';   %��ʼ������ź�
OutputP = NoisyInput(1:AR_Order,1);

% �������Ĵ���.
i = AR_Order+1;
j = AR_Order+1;

%���п������˲�
for k = 1:Num_Frame   %һ�δ���һ֡�ź�
    jStart = j;     %����ÿ�ε���AR_Order+1��ֵ.
    OutputOld = OutputP;    %Ϊÿ�ε���������һ��AROrderԤ����
    
    for l = 1:Num_Iter
        A = [zeros(AR_Order-1,1) eye(AR_Order-1); fliplr(-FiltCoeff(k,2:end))];
        
        for ii = i:Len_WinFrame
            %Kalman�˲���������ʽ
            OutputC = A * OutputP;
            Pc = (A * P * A') + (H' * Q(k) * H);
            K = (Pc * H')/((H * Pc * H') + R);
            OutputP = OutputC + (K * (Frame_Signal(ii,k) - (H*OutputC)));
            Output(j-AR_Order+1:j) = OutputP';
            P = (eye(AR_Order) - K * H) * Pc;
            j = j+1;
        end       
        i = 1;
        if l < Num_Iter
            j = jStart;
            OutputP = OutputOld;
        end     
        % �����˲����źŵ�lpc
        [FiltCoeff(k,:), Q(k)] = lpc(Output((k-1)*Len_WinFrame+1:k*Len_WinFrame),AR_Order);
    end
end
Output = Output';
%����
MAX_Am(1)=max(Input);
MAX_Am(2)=max(NoisyInput);
MAX_Am(3)=max(Output);
audiowrite('kaerman.wav',Output,Fs);
subplot(321);plot(Input);ylim([-max(MAX_Am),max(MAX_Am)]);xlabel('ʱ��');ylabel('����');title('ԭʼ�źŵĲ���');
subplot(323);plot(NoisyInput);ylim([-max(MAX_Am),max(MAX_Am)]);xlabel('ʱ��');ylabel('����');title('�����źŵĲ���');
subplot(325);plot(Output);ylim([-max(MAX_Am),max(MAX_Am)]);xlabel('ʱ��');ylabel('����');title('Kalman�˲��źŵĲ���');
subplot(322);myspectrogram(Input,Fs);colormap(jet);time=(0:length(x)-1)/Fs;axis([0 max(time*1000) 0 8000]);title('�ɾ��źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(324);myspectrogram(NoisyInput,Fs);colormap(jet);time=(0:length(x)-1)/Fs;axis([0 max(time*1000) 0 8000]);title('�����źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
subplot(326);myspectrogram(Output,Fs);colormap(jet);time=(0:length(x)-1)/Fs;axis([0 max(time*1000) 0 8000]);title('�������˲���ǿ���źŵ�����ͼ');xlabel('ʱ��');ylabel('Ƶ��');
