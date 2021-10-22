function obligin3190()
    h1 = [0.0002, 0.0001, -0.0001, -0.0005, -0.0011, -0.0017, -0.0019, ...
        -0.0016, -0.0005, 0.0015, 0.0040, 0.0064, 0.0079, 0.0075, 0.0046, ...
        -0.0009, -0.0084, -0.0164, -0.0227, -0.0248, -0.0203, -0.0079, ...
        0.0127, 0.0400, 0.0712, 0.1021, 0.1284, 0.1461, 0.1523, 0.1461, ...
        0.1284, 0.1021, 0.0712, 0.0400, 0.0127, -0.0079, -0.0203, -0.0248, ...
        -0.0227, -0.0164, -0.0084, -0.0009, 0.0046, 0.0075, 0.0079, 0.0064, ...
        0.0040, 0.0015, -0.0005, -0.0016, -0.0019, -0.0017, -0.0011, ...
        -0.0005, -0.0001, 0.0001, 0.0002];

    h2 = [-0.0002, -0.0001, 0.0003, 0.0005, -0.0001, -0.0009, -0.0007, ...
        0.0007, 0.0018, 0.0005, -0.0021, -0.0027, 0.0004, 0.0042, 0.0031, ...
        -0.0028, -0.0067, -0.0023, 0.0069, 0.0091, -0.0010, -0.0127, ...
        -0.0100, 0.0077, 0.0198, 0.0075, -0.0193, -0.0272, 0.0014, 0.0386, ...
        0.0338, -0.0246, -0.0771, -0.0384, 0.1128, 0.2929, 0.3734, 0.2929, ...
        0.1128, -0.0384, -0.0771, -0.0246, 0.0338, 0.0386, 0.0014, -0.0272, ...
        -0.0193, 0.0075, 0.0198, 0.0077, -0.0100, -0.0127, -0.0010, 0.0091, ...
        0.0069, -0.0023, -0.0067, -0.0028, 0.0031, 0.0042, 0.0004, -0.0027, ...
        -0.0021, 0.0005, 0.0018, 0.0007, -0.0007, -0.0009, -0.0001, 0.0005, ...
        0.0003, -0.0001, -0.0002];
    %oppgave_1();
    %oppgave_2(h1, h2);
    %oppgave_3(h1, h2);
    %oppgave_4(h1, h2);
    %oppgave_5(h1, h2);
    %oppgave_6(h1, h2);
    oppgave_7(h1, h2);
    %konvin3190([1,1,1], [1, 2, 3, 4, 5, 6, 7], 0)
    %conv([1, 2, 3, 4, 5, 6 ,7], [1,1,1],"same")
end


function oppgave_1()
    %% Oppgave 1c
    fs = 100;
    N = fs * 5;
    t = linspace(0, 5, N);
    f1 = 10;
    f2 = 20;
    
    x = sin(2*pi*f1*t) + sin(2*pi*f2*t);

    kmax = 4;
    n = -1:100; %Velger at length(h) = 102
    h = 0;
    for k = 0:kmax
        h = h + (1/5) * (n == k);
    end
    length(h)
    
    y = konvin3190(h, x, 1);
    [X, f] = frekspekin3190(x, N, fs);
    [H, fh] = frekspekin3190(h, length(h), fs);
    [Y, fy] = frekspekin3190(y, length(y), fs);

    figure;
    sgtitle("Frequency response: H");
    subplot(2,1,1);
    plot(fh, (abs(H)));
    xlabel("Frequency (Hz)");
    ylabel("Magnitude");
    
    figure;
    hold on;
    plot(f, (abs(X)));
    plot(fy, (abs(Y)));
    hold off;
    title("Frequency response");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude");
    legend("X", "Y", 'Location', 'southwest') ;
end

function oppgave_2(h1, h2)
    load('majabni.mat')
    %% Oppgave 2a
    
    figure;
    hold on;
    stem(1:length(h1), h1);
    stem(1:length(h2), h2);
    hold off;
    title("Filters h1 and h2");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    legend("h1", "h2", 'Location', 'southwest') ;
    
    fs = 100;
    [H1, f1] = frekspekin3190(h1, length(h1), fs);
    [H2, f2] = frekspekin3190(h2, length(h2), fs);
    
    figure;
    hold on;
    plot(f1, db(abs(H1)));
    plot(f2, db(abs(H2)));
    hold off;
    title("Frequency response");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude (dB)");
    legend("H1", "H2", 'Location', 'southwest');
    
   
    %% Oppgave 2b
    x = seismogram1(:,1);
    W = tukeywin(length(x), 0.8);
    figure;
    hold on;
    plot(1:length(x), x);
    plot(1:length(x), W .* x);
    hold off;
    title("Seismogram1 nærtrase");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    legend("x", "x_{window}", 'Location', 'southwest') ;
    
    
    fs = 1/(t(2)-t(1));
    [X, f] = frekspekin3190(x, length(x), fs);
    [X_window, f_window] = frekspekin3190(W .* x, length(x), fs);
    
    figure;
    hold on;
    plot(f, db(abs(X)));
    plot(f_window, db(abs(X_window)));
    hold off;
    title("Frequency response");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude (dB)");
    hold off;
    legend("X", "X_{window}", 'Location', 'southwest');
    
    %% Oppgave 2c
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    
    figure;
    sgtitle("Seismogram1 filtrert");
    subplot(1,2,1)
    imagesc(offset1, t*1000,y1);
    title("Filter h1");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    colormap(gray)
    subplot(1,2,2)
    imagesc(offset1, t*1000,y2);
    title("Filter h2");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    colormap(gray)
    
    figure;
    sgtitle("Seismogram1 konvolvert med filtrene h1 og h2, trase 1");
    subplot(1,2,1)
    plot(1:length(y1(:,1)), y1(:,1));
    title("Filter h1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    subplot(1,2,2)
    plot(1:length(y2(:,1)), y2(:,1));
    title("Filter h2");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
end

function oppgave_3(h1, h2)
    load('majabni.mat')
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    %% Oppgave 3a
    figure;
    x = filtered_seismogram1(:,1);
    plot(1:length(x), x);
    xlim([30,100]);
    title("Valgt trase 1: direkte ankomst");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    fs = 1/(t(2)-t(1));
    
    [X, f] = frekspekin3190(x, length(x), fs);
    figure;
    plot(f, db(abs(X)));
    title("Frekvensspekter trase 1: direkte ankomst");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude (dB)");
    
    %% Oppgave 3b
    W = tukeywin(length(x), 0.8);
    [X_window, f_window] = frekspekin3190(W .* x, length(x), fs);
    
    figure;
    hold on;
    plot(f, db(abs(X)));
    plot(f_window, db(abs(X_window)));
    hold off;
    title("Frequency response");
    xlabel("Frequency (Hz)");
    ylabel("Magnitude (dB)");
    legend("X", "X_{window}", 'Location', 'southwest');
    
    %% Oppgave 3c
    lambda = 3000 / 15;
    opplosning = 1/8 * lambda
    
end

function oppgave_4(h1, h2)
    load('majabni.mat')
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    %% Oppgave 4a
    
    x = filtered_seismogram1(:,1);
    figure;
    hold on;
    plot(1:length(x), x);
    plot(220, 0,'x', 'MarkerSize',10, 'LineWidth',2);
    plot(2*220, 0,'o', 'MarkerSize',10, 'LineWidth',2);
    plot(3*220,0,'o', 'MarkerSize',10, 'LineWidth',2);
    plot(4*220,0,'o', 'MarkerSize',10, 'LineWidth',2);
    hold off;
    title("Seismogram1, trase 1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    figure;
    hold on;
    imagesc(offset1, t*1000,filtered_seismogram1);
    colormap(gray);
    plot(1,t(220)*1000,'x', 'MarkerSize',10, 'LineWidth',2);
    plot(1,t(2*220)*1000, 'o', 'MarkerSize',10, 'LineWidth',2);
    plot(1,t(3*220)*1000,'o', 'MarkerSize',10, 'LineWidth',2);
    plot(1,t(4*220)*1000,'o', 'MarkerSize',10, 'LineWidth',2);
    hold off;
    title("Seismogram1 (refleksjoner i havbunn)");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    
    %% Oppgave 4b
    x = filtered_seismogram1(:,1);
    figure;
    hold on;
    plot(1:length(x), x);
    plot(613, 0,'x', 'MarkerSize',10, 'LineWidth',2);
    plot(848, 0,'o', 'MarkerSize',10, 'LineWidth',2);
    plot(613+2*(848-613),0,'o', 'MarkerSize',10, 'LineWidth',2);
    hold off;
    title("Seismogram1, trase 1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    figure;
    hold on;
    imagesc(offset1, t*1000,filtered_seismogram1);
    colormap(gray);
    plot(1,t(613)*1000, 'x', 'MarkerSize',10, 'LineWidth',2);
    plot(1,t(848)*1000,'o', 'MarkerSize',10, 'LineWidth',2);
    plot(1,t(613+2*(848-613))*1000,'o', 'MarkerSize',10, 'LineWidth',2);
    hold off;
    title("Seismogram1 (refleksjoner i dypeste sedimentærlag)");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    
    
end

function oppgave_5(h1, h2)
    load('majabni.mat')
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    %% Oppgave 5
    figure;
    sgtitle("Seismogram1 direkte ankomst");
    subplot(1,2,1);
    x = filtered_seismogram1(:,1);
    plot(1:length(x), abs(x));
    xlim([30,100]);
    title("Chosen trase 1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    subplot(1,2,2);
    x = filtered_seismogram1(:,75);
    plot(1:length(x), abs(x));
    xlim([150,210]);
    title("Chosen trase 75");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    s = offset1(75) - offset1(1);
    t = (t(154) - t(36));
    v=s/t
end

function oppgave_6(h1, h2)
    load('majabni.mat')
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    
    %% Oppgave 6a
    v_1 = 1500;
    v_2 = 1400;
    v_3 = 1600;
    vnmo1 = v_1 * ones(size(t));
    vnmo2 = v_2 * ones(size(t));
    vnmo3 = v_3 * ones(size(t));
    seisnmo1 = nmocorrection2(t,t(2)-t(1),offset1,filtered_seismogram1,vnmo1);
    seisnmo2 = nmocorrection2(t,t(2)-t(1),offset1,filtered_seismogram1,vnmo2);
    seisnmo3 = nmocorrection2(t,t(2)-t(1),offset1,filtered_seismogram1,vnmo3);
    
    figure;
    sgtitle("Seismogram1 med NMO (havdybde)");
    subplot(1,3,1);
    imagesc(offset1, t*1000,seisnmo1);
    colormap(gray);
    title("vmno=1500");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    
    subplot(1,3,2);
    imagesc(offset1, t*1000,seisnmo2);
    colormap(gray);
    title("vnmo=1400");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    
    subplot(1,3,3);
    imagesc(offset1, t*1000,seisnmo3);
    colormap(gray);
    title("vnmo=1600");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    
    %% Oppgave 6b
    v_1 = 1500;
    v_2 = 1800;
    I = round(length(t)/2)-200;
    vnmo = v_1 * ones(size(t));
    vnmo(I+1:end) = v_2;
    vnmo(I - 30:I + 30) = linspace(v_1, v_2, 61)';
    seisnmo = nmocorrection2(t,t(2)-t(1),offset1,filtered_seismogram1,vnmo);
    
    figure;
    imagesc(offset1, t*1000,seisnmo);
    colormap(gray);
    title("Seismogram1 med NMO (grunneste sentimentærlag)");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
end

function oppgave_7(h1, h2)
    load('majabni.mat')
    y1 = zeros(size(seismogram1));
    y2 = zeros(size(seismogram1));
    
    for i = 1:length(offset1)
        y1(:,i) = konvin3190(h1, seismogram1(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram1(:,i), 0);
    end
    filtered_seismogram1 = y1;
    
    %% Oppgave 7a
    figure;
    imagesc(filtered_seismogram1);
    colormap(gray);
    
    figure;
    sgtitle("Seismogram1 direkte ankomst");
    subplot(1,2,1);
    x = filtered_seismogram1(:,230);
    plot(1:length(x), abs(x));
    xlim([350,450]);
    title("Chosen trase 230");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    subplot(1,2,2);
    x = filtered_seismogram1(:,280);
    plot(1:length(x), abs(x));
    xlim([400,500]);
    title("Chosen trase 280");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    s = offset1(280) - offset1(230);
    t_ = (t(455) - t(410));
    v=s/t_
    
    %% Oppgave 7b
    figure;
    sgtitle("Seismogram1 direkte ankomst");
    subplot(1,2,1);
    x = filtered_seismogram1(:,1);
    plot(1:length(x), abs(x));
    xlim([610,650]);
    title("Chosen trase 1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    subplot(1,2,2);
    x = filtered_seismogram1(:,200);
    plot(1:length(x), abs(x));
    xlim([640,700]);
    title("Chosen trase 200");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    s = offset1(200) - offset1(1);
    t_ = t(666) - t(628);
    v=s/t_
    
    %% Oppgave 7c
    y1 = zeros(size(seismogram2));
    y2 = zeros(size(seismogram2));
    
    for i = 1:length(offset2)
        y1(:,i) = konvin3190(h1, seismogram2(:,i), 0);
        y2(:,i) = konvin3190(h2, seismogram2(:,i), 0);
    end
    filtered_seismogram2 = y1;
    
    figure;
    subplot(1,2,1);
    imagesc(filtered_seismogram1);
    title("Seismogram1");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    colormap(gray);
    subplot(1,2,2);
    imagesc(filtered_seismogram2);
    title("Seismogram2");
    xlabel("Offset (m)");
    ylabel("Tid (ms)");
    colormap(gray);
    
    figure;
    sgtitle("Seismogram2 direkte ankomst");
    subplot(1,2,1);
    x = filtered_seismogram2(:,1);
    plot(1:length(x), abs(x));
    xlim([610,650]);
    title("Chosen trase 1");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    
    subplot(1,2,2);
    x = filtered_seismogram2(:,200);
    plot(1:length(x), abs(x));
    xlim([640,700]);
    title("Chosen trase 200");
    xlabel("Normalized time (samples)");
    ylabel("Amplitude");
    s = offset2(200) - offset2(1);
    t_ = t(666) - t(628);
    v=s/t_
    
end


function y = konvin3190(h, x, ylen)
    %% Oppgave 1a
    h = h(:);
    x = x(:);
    y = zeros(length(x) + length(h) - 1,1);

    for i = 1:length(x) + length(h) - 1
        for j = max(1, i - length(x) + 1):min(length(h), i)
            y(i) = y(i) + h(j) * x(i + 1 - j);
        end
    end
    
    if ylen == 0 % Klipper arrayet hvis lengden til y er lik lengden til x
        center = round(length(y)/2);
        % Klipper fra halvparten av størrelsen fra midten
        start_i = center - ceil(length(x)/2) + 1;
        end_i = center + floor(length(x)/2); 
        y = y(start_i:end_i);
    end
end

function [X, f] = frekspekin3190(x, N, fs)
    %% Oppgave 1b
    X = zeros(N,1);
    omega = linspace(-pi, pi, N);
    
    for k = 1:N
        for l = 1:N
            % Legger til summen i hver X(k)
            X(k) = X(k) + x(l) * exp(-1j*omega(k) * l);
        end
    end
    f = omega / (2*pi) * fs;
end
