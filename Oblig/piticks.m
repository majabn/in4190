function piticks(varargin)
% PITICKS Format axis ticks and ticklabels in terms of pi.
%   PITICKS sets the ticks and ticklabels on the x-axis in terms of pi.
%
%   PITICKS(steps) sets the number of ticks.
%
%   PITICKS(..., 'axis', ac) sets the ticks and ticklabels on the axis
%   specified by ac. ac can take the values 'x', 'y', 'z' and 'c'.
%
%   PITICKS(..., 'fractions', bool) sets wether the ticklabels are in
%   fractions or decimals. Give bool as true for fractions or false for
%   decimals.
%
%   PITICKS(..., 'digits', d) sets the number of decimal digits if
%   fractions are turned off
%
%   PITICKS(AX, ...) modifies the axes handler specified by AX instead of
%   the current axes.

p = inputParser;
p.FunctionName = "piticks";
p.addOptional('steps', 11, ...
    @(steps) ...
    isnumeric(steps) ...
    & isscalar(steps) ...
    & isfinite(steps) ...
    & steps == round(steps) ...
    & steps > 0);
p.addParameter('axis', 'x', ...
    @(axis) ...
    isscalar(axis) ...
    & isletter(axis) ...
    & contains(['x', 'y', 'z', 'c'], axis));
p.addParameter('fractions', true, ...
    @(fractions) ...
    isscalar(fractions) ...
    & islogical(fractions));
p.addParameter('digits', 2, ...
    @(digits) ...
    isscalar(digits) ...
    & isnumeric(digits) ...
    & isfinite(digits) ...
    & digits == round(digits) ...
    & digits > 0);

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

steps = p.Results.steps;
axis_ = p.Results.axis;
fractions = p.Results.fractions;
digits = p.Results.digits;

switch axis_
    case 'x'
        axisObj = ax.XAxis;
    case 'y'
        axisObj = ax.YAxis;
    case 'z'
        axisObj = ax.ZAxis;
    case 'c'
        axisObj = ax.Colorbar;
end

limits = axisObj.Limits;
normalizedvalues = linspace(limits(1)/pi, limits(2)/pi, steps);
newticklabels = string(zeros([1, length(normalizedvalues)]));
for i = 1:length(newticklabels)
   if fractions
       newticklabels(i) = strcat("$", ...
           latex(sym(normalizedvalues(i))), ...
           "\,\pi$");
   else
       newticklabels(i) = strcat("$", ...
           latex(vpa(sym(normalizedvalues(i)), digits)), ...
           "\,\pi$");
   end
end

axisObj.TickLabelInterpreter = 'latex';
if isa(axisObj, 'matlab.graphics.axis.decorator.NumericRuler')
    axisObj.TickValues = normalizedvalues*pi;
elseif isa(axisObj, 'matlab.graphics.illustration.ColorBar')
    axisObj.Ticks = normalizedvalues*pi;
end
axisObj.TickLabels = newticklabels;

end