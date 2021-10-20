function F = dtfourier(varargin)
% DTFOURIER Discrete-time Fourier transform.
%   F = dtfourier(f) is the discrete-time Fourier transform of the sym
%   f with the default independent variable n. The default return is a
%   function of omega. 
%
%   F = dtfourier(f, w) makes F a function of the sym w instead of the
%   default omega.
%
%   F = dtfourier(f, k ,w) takes f to be a function of the sym variable k.
%
%   If an explicit expression is not found the return is in terms of the
%   ztrans function. 


transVar = sym("omega");
var = sym("n");

switch nargin
    case 1
        f = varargin{1};
    case 2
        f = varargin{1};
        transVar = varargin{2};
    case 3
        f = varargin{1};
        var = varargin{2};
        transVar = varargin{3};
    otherwise
        f = 0;
end

F = ztrans(f, var, exp(1j*transVar));

end

