function ctickformat(varargin)
% CTICKFORMAT Set colorbar-axis tick label format.
%   CTICKFORMAT(fmt) specifies fmt as 'percentage', 'degrees' or a custom
%   numeric format. For example specify fmt as 'degrees' to display the
%   labels as degrees, or '%.g' to display commas in the thousandth place.
%
%   CTICKFORMAT(AX, ...) uses the axes specified by AX instead of the
%   current axes.
    ax = gca;
    switch nargin
        case 0
            error("Invalid number of arguments to 'ctickformat', print usage with 'help ctickformat'");
        case 1
            FormatSpec = varargin{1};
        otherwise
            ax = varargin{1};
            FormatSpec = varargin{2};
    end
    c = get(ax, 'colorbar');
    c.TickLabels = compose(FormatSpec, c.Ticks);
end

