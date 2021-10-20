function H = clabel(varargin)
% CLABEL Colorbar-axis label.
%   CLABEL('text') adds text beside the colorbar-axis on the current axis.
%
%   CLABEL(AX, ...) adds the clabel to the specified axes.
%
%   H = clabel(...) returns the handle to the text object used as the
%   label.
    ax = gca;
    switch nargin
        case 0
            error("Invalid number of arguments to 'ctickformat', print usage with 'help ctickformat'");
        case 1
            txt = varargin{1};
        otherwise
            ax = varargin{1};
            txt = varargin{2};
    end
    c = get(ax, 'colorbar');
    c.Label.String = txt;
    H = c.Label;
end

