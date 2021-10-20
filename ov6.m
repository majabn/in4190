function ov6()
run_it(4);
run_it(9);
end

function run_it(N)
b1 = 1/N * ones(N,1);
a1 = 1;

b2 = 2/(N*(N+1)) * flip(linspace(0,N-1,N));
a2 = 1;

alpha = (N-1)/(N+1);
b3 = 1-alpha;
a3 = [1;-alpha];

freq_mag(b1, a1, N, 1);
freq_mag(b2, a2, N, 2);
freq_mag(b3, a3, N, 3);

noisy(b1, a1, N, 1);
noisy(b2, a2, N, 2);
noisy(b3, a3, N, 3);
end

function noisy(b, a, N, i)
n = 0:300;
x = 1-0.6.^n;
sigma = std(x);
k = 1/4;
noise = k*sigma*randn(size(x));

x_noisy = x + noise;

y = filter(b, a, x_noisy);
figure;
hold on;
plot(n, x_noisy);
plot(n, y);
hold off;
title(sprintf("Filtered noisy signal: Filter %i, N=%i", i,N));
xlabel("Normalized time (samples)");
ylabel("Amplitude");
legend("Noisy input", "Output", 'Location', 'southwest');
end

function freq_mag(b, a, N, i)
omega = linspace(-pi, pi, 257);
H = freqz(b, a, omega);
figure;
sgtitle(sprintf("Frequency response: Filter %i, N=%i", i,N));
subplot(2,1,1);
plot(omega, db(abs(H)));
xlim([-pi,pi]);
piticks(5, 'axis','x');
xlabel("Normalized frequency (rad/sample)");
ylabel("Magnitude (dB)");
f = true;
end


