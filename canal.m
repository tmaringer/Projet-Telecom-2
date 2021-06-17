function f = canal(tabsig)
    setting
    tau = [];
    for n = 1:N
        taun = rand*Tb;
        tau = [tau;round(taun*bet*gamm)];
    end
    %disp(size(tau))
    maxtau = max(tau);
    %disp(maxtau)
    tabsig1 = zeros(N,(length(tabsig(1,:))+maxtau));
    for n = 1:N
        zero = zeros(1,tau(n));
        zero1 = zeros(1,(maxtau-tau(n)));
        tabsig1(n,:) = cat(2,cat(2,zero,tabsig(n,:)),zero1);
    end
    %disp(size(tabsig));
    figure();
    t = tiledlayout(N/Lar,Lar);
    t.Padding = 'compact';
    t.TileSpacing = 'compact';
    for n = 1:N
        %plot(1:length(tabsig(n,:)),tabsig(n,:));
        %hold on
        nexttile
        plot(1:length(tabsig1(n,:)),tabsig1(n,:));
%         NFFT=1024;      
%         X=fftshift(fft(tabsig(n,:),NFFT));         
%         fVals=(1/Ta)*(-NFFT/2:NFFT/2-1)/NFFT;        
%         plot(fVals,abs(X),'b');
        hold on
    end
    hold on
    %disp(size(tabsig));
    tabsig = tabsig1*alphan;
    %plot(1:length(tabsig(1,:)),tabsig(1,:));
    %hold on
    %plot(1:length(tabsig2(1,:)),tabsig2(1,:));
    %hold on
    Eb = Pt*((alphan^2))*Tb;
    B = 1/(2*Ta);
    No = Eb/SNR;
    variance = (No/2)*B;
    AWGNoise = sqrt(variance)*randn(1,length(tabsig(1,:)));
    %disp(size(AWGNoise));
    signal = sum(tabsig) + AWGNoise;
    hold off
    %plot(1:length(signal),signal)
    %hold off
    %plot(1:length(signal), signal)
f = signal;
end

