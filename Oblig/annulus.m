function annulus(varargin)
% ANNULUS Create annulus.
%
%   ANNULUS(r1, r2) creates an annulus with inner radius r1 and outer
%   radius r2 in the current axes. 
%
%   ANNULUS(..., 'color', c) set the fill color of the annulus to color c.
%
%   ANNULUS(..., 'edgecolor', c) set the edge color of the annulus to c.
%
%   ANNULUS(..., 'samples', n) specify the number of samples of the annulus
%   circles. 
%
%   ANNULUS(AX, ...) create the annulus in the specified axes.

p = inputParser;
p.FunctionName = "annulus";
p.addRequired("r1", ...
    @(r1) ...
    isscalar(r1) ...
    & isnumeric(r1) ...
    & isfinite(r1) ...
    & r1 > 0);
p.addRequired("r2", ...
    @(r2) ...
    isscalar(r2) ...
    & isnumeric(r2) ...
    & ~isnan(r2) ...
    & (r2 > 0 | isinf(r2)));
p.addParameter("color", [0.7, 0.7, 0.7], ...
    @(color) ...
    (isnumeric(color) ...
    & (length(color) == 3 | length(color) == 4) ...
    & color >= 0 ...
    & color <= 1) ...
    & contains(["y", "m", "c", "r", "g", "b", "w", "k"], color));
p.addParameter("edgecolor", [0, 0, 0], ...
    @(color) ...
    (isnumeric(color) ...
    & (length(color) == 3 | length(color) == 4) ...
    & color >= 0 ...
    & color <= 1) ...
    | contains(["y", "m", "c", "r", "g", "b", "w", "k"], color));
p.addParameter("samples", 50, ...
    @(samples) ...
    isscalar(samples) ...
    & isnumeric(samples) ...
    & samples == round(samples) ...
    & samples > 0);

ax = gca;
if nargin > 0
    first = varargin{1};
    if isa(first, 'matlab.graphics.axis.Axes')
        ax = first;
        p.parse(varargin{2:end});
    else
        p.parse(varargin{:});
    end
else
    p.parse(varargin{:});
end

r1 = p.Results.r1;
r2 = p.Results.r2;
color = p.Results.color;
edgecolor = p.Results.edgecolor;
samples = p.Results.samples;

omega = linspace(0, 2*pi, samples);
uc = exp(1j*omega);
x = real(uc);
y = imag(uc);

if r1 > r2
    error("r2 must be greater than or equal to r1");
end

holdstatus = "off";
if ishold(ax)
    holdstatus = "on";
else
    cla(ax);
end
hold(ax, "on");
if r2 == inf
    oldbgc = get(ax, 'color');
    set(ax, 'color', color);
    fill (ax, [0 * x, r1 * x], [0 * y, r1 *y], oldbgc, 'EdgeColor', 'none');
    plot (ax, r1*x, r1*y, 'color', edgecolor);
else
    fill (ax, [r1 * x, r2 * x], [r1 * y, r2 * y], color, 'EdgeColor', 'none');
    plot (ax, r1*x, r1*y, 'color', edgecolor);
    plot (ax, r2*x, r2*y, 'color', edgecolor);
end
hold(ax, holdstatus);

end