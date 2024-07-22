function varargout = eyediagram_qa(x, n, period, offset, plotstring, h)

error(nargchk(2,6,nargin));
error(nargoutchk(0,1,nargout));
if nargin < 3
    period = 1;
end;

if nargin < 4
    offset = 0;
end;

if nargin < 5
    plotstring = 'b-';
end;

if nargin < 6
    h = [];
end;

[r, c] = size(x);
if r * c == 0
    error('Input variable X is empty.')
end;
% don't allow t to be zero or negative
if (period <= 0)
    error('PERIOD must be a positive number.')
end

% don't allow n to be noninteger or less than or equal zero
if ((floor(n) ~= n) | (n <= 1))
    error('N must be an integer greater than 1.')
end

% don't allow offset to be outside of the range 0 <= offset < n
if ((floor(offset) ~= offset) | (offset < 0) | (offset >= n))
    error('OFFSET must be a integer in the range 0 <= OFFSET < N.')
end

% flatten input
if r == 1
    x = x(:);
end;

% Complex number processing
if ~isreal(x) > 0
    x = [real(x), imag(x)];
end;
maxAll = max(max(abs(x)));

% generate normalized time values
[len_x, wid_x]=size(x);
t = rem([0 : (len_x-1)]/n, 1)';

% wrap right half of time values around to the left
tmp = find(t > rem((offset/n+0.5),1) + eps^(2/3));
t(tmp) = t(tmp) - 1;

% if t = zero is at an edge, make it the left edge
if(max(t)<=0)
    t = t + 1;
end;


% determine the right-hand edge points
% for zero offset, the index value of the first edge is floor(n/2)+1
index = fliplr([1+rem(offset+floor(n/2),n) : n : len_x]);

% for plotting, insert NaN values into both x and t after each edge point
% to define the left edge,after the NaNs repeat the ith value of x
% and insert a value that is (period/n) less than the (i+1)th value of t
NN = ones(1, wid_x) * NaN;
for ii = 1 : length(index)
    i = index(ii);
    if i < len_x
        x = [x(1:i,:);   NN;     x(i,:); x(i+1:size(x, 1),:)];
        t = [t(1:i);    NaN; t(i+1)-1/n; t(i+1:size(t, 1))  ];
    end;
end;

% adjust the time values to ensure that the x axis remains fixed
half_n = n/2-1;
modoffset = rem(offset+half_n,n)-half_n;
t = rem(t-modoffset/n,1);

% scale time values by period
t = t*period;

% Create new figure or reuse existing handle

strName = 'Eye Diagram designed by NVD';
% strName = ('BiÓu ®å m¾t','fontname','.Vntime');
if(~isempty(h))
    if(~ishandle(h) | ~strcmp(get(h,'Type'),'figure'))
        warning('comm:eyediagram:invalidHandle', ...
                'Ignoring invalid handle H. Creating a new eye diagram.')
        h = figure('visible','off');
        isNewFig = 1;
    else
        if(~strcmp(get(h,'Tag'),strName))
            strErr = sprintf(['Figure is not an existing eye diagram.\n' ...
                'Use an existing eye diagram or do not use a figure ' ...
                'handle as an input']);
            error(strErr);
        end
        h = figure(h);
        isNewFig = 0;
    end
else
    h = figure('visible','off');
    isNewFig = 1;
end

% setup for the eye diagram
limFact = 1.05;
% % sigName = {'for In-Phase Signal', 'for Quadrature Signal'};
sigName = {'Cho tÝn hiÖu ®ång pha','Cho tÝn hiÖu vu«ng pha','fontname','.vntime'};
pos = get(h,'position');
sizPlotC = [460   360];
sizPlotR = [460   540];

% plot one figure or two, based on the number of columns in x
switch size(x, 2)
case 1
    % Real Signal Procesing
    if(isNewFig)        
        set(h,'position',[pos(1:2)-sizPlotC(1:2)/2  sizPlotC(1:2)], ...
            'Name',strName,'Tag',strName, 'visible','on', ...
            'DoubleBuffer','on','fontname','.vntime');        
    else
        clf;
        if(pos(3:4) == [460   540])
            set(h,'position',[pos(1:2)+[0 (sizPlotR(2)-sizPlotC(2))]  sizPlotC(1:2)]);
        end
    end
    plotEye(t, x, plotstring, '');
    axo = axis;
    yLimits = maxAll * limFact;
    axx=[min(t), max(t), min(-yLimits,min(axo(3))), max(yLimits,max(axo(4)))];
    axis(axx);
case 2
    % Complex Signal Procesing
    if(isNewFig)        
        set(h,'position',[pos(1:2)-sizPlotR(1:2)/2  sizPlotR(1:2)], ...
            'Name',strName,'Tag',strName, 'visible','on', ...
            'DoubleBuffer','on');
    else
        clf;
        if(pos(3:4) == [460   360])
            set(h,'position',[pos(1:2)+[0 (sizPlotC(2)-sizPlotR(2))]  sizPlotR(1:2)]);
        end
    end
    for idx = [1,2]
    	ha(idx) = subplot(2,1,idx);
    	plotEye(t, x(:,idx), plotstring, char(sigName(idx)));
        axo(idx,:) = axis;
    end
    yLimits = maxAll * limFact;
    axx=[min(t), max(t), min(-yLimits,min(axo(:,3))), max(yLimits,max(axo(:,4)))];
    for idx = [1,2]
        axis(ha(idx),axx);
    end

otherwise
    error('Number of columns in the input data, X, cannot exceed 2.')
end
set(h,'nextplot','replacechildren');

if(nargout == 1)
    varargout(1) = {h};
end
%=====================================================
function plotEye(t,x, plotstring, strSubTitle)
% plotEye does the plotting, and labeling for the eye diagram

plot(t, x, plotstring);
xlabel('Thêi gian','fontname','.vntime');
ylabel('Biªn ®é','fontname','.vntime');
title(['BiÓu ®å m¾t: ' strSubTitle],'fontname','.vntime','color','r');