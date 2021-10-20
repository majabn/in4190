n = 0:10;
x = (n>=0);

b = 1;
a = [1,-3/4,1/8];

s_analysis = (1/3)*(1/4).^n .*(n>=0) - 2*(1/2).^n .* (n>=0) + (8/3) .*(n>=0);
s_numeric = filter(b, a, x);

figure;
subplot(2, 1, 1);
stem(n, s_analysis);
title("Response from analysis: s(n)");
xlabel("Normalized time (samples)");
ylabel("Amplitude");

subplot(2, 1, 2);
stem(n, s_numeric);
title("Response from numeric computation");
xlabel("Normalized time (samples)");
ylabel("Amplitude");
