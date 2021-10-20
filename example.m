n = 0:50;
N = 4;
x = sin(1/10 * pi * n);

%% Add noise , t h i s can be done in a simple way or in a complicated way .
% Noise i s noise .
sigma = std(x);
k = 1/4;
noise = k*sigma*randn(size(x));
x_noisy = x + noise;

%% Plot both s i g n a l s
figure;
hold on;
stem(n, x);
stem(n, x_noisy);
hold off;
title("Signal with and without noise");
xlabel("Normalized time (samples)");
ylabel("Amplitude");
legend("Signal", "Noisy signal", 'Location', 'southwest') ;

%% Create lowpass f i l t e r , c u t o f f 1/5∗ pi rad / sample
% Let ’ s also locate the c u t o f f in the p l o t
h = fir1(10, 1/5);
% p l o t impulse response
figure;
stem(0 : length(h) - 1, h) ;
title("Lowpass filter impulse response");
xlabel("Normalized time (samples)");
ylabel("Amplitude");

% compute frequency response and plot , with programatically found c u t o f f s
% ( c u t o f f s could also be found by hand )
omega = linspace(-pi, pi, 257);
H = freqz(h, 1, omega);
% Let ’ s find the indexes of the c u t o f f s . Cutoff i s defined as
% half −magnitude for FIR f i l t e r s . Or −3 dB for power conversion .
% For IIR f i l t e r the c u t o f f i s defined as half −power , or −3 dB for
% magnitude conversion .
[j, i] = mink(abs(H)-0.5, 2, 'ComparisonMethod', 'abs');
figure;
sgtitle("Lowpass filter frequency response");
subplot(2, 1, 1);
hold on;
plot(omega, pow2db(abs(H)));
xline(omega(i), '--', '\pm\omegac', 'LabelOrientation', 'horizontal', 'LabelVerticalAlignment', 'middle');
hold off;
xlim([-pi ,pi]);
