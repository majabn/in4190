function rot = sdrot(p)

[m, n] = size(p);
C = compan(p);
tol = 0.1*10^(-5);
xvals = [];
muvals = [];
x = randi(10, n-1, 1);
numtimes = 100;

for r = 1 : numtimes
    x = C*x;
    
    [maxval, maxnr] = max(abs(x));
    mu = x(maxnr);
    x = (1/mu)*x;
    
    
    muvals = [muvals mu];
    xvals = [xvals x];
    
    error = max(abs(C*x-mu*x));
    if error < tol
        break;
    end
end

rot = muvals(end);
if (error >= tol)
    fprintf('Finnes ingen dominante egenverdier')
end

end