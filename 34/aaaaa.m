function createfigure(XData1, YData1, XData2, YData2, XData3, YData3, XData4, YData4)
%CREATEFIGURE(XDATA1, YDATA1, XDATA2, YDATA2, XDATA3, YDATA3, XDATA4, YDATA4)
%  XDATA1:  line xdata
%  YDATA1:  line ydata
%  XDATA2:  line xdata
%  YDATA2:  line ydata
%  XDATA3:  line xdata
%  YDATA3:  line ydata
%  XDATA4:  line xdata
%  YDATA4:  line ydata

%  由 MATLAB 于 10-Apr-2018 16:20:03 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
%% 取消注释以下行以保留轴的 X 极限
% xlim(axes1,[-100 100]);

% 创建 line
line(XData1,YData1,'Parent',axes1,'MarkerSize',5,'Marker','.',...
    'LineStyle','none',...
    'Color',[1 0 0],...
    'DisplayName','0,0,0,1');

% 创建 line
line(XData2,YData2,'Parent',axes1,'MarkerSize',5,'Marker','.',...
    'LineStyle','none',...
    'Color',[0.5 1 0],...
    'DisplayName','0,0,1,0');

% 创建 line
line(XData3,YData3,'Parent',axes1,'MarkerSize',5,'Marker','.',...
    'LineStyle','none',...
    'Color',[0 1 1],...
    'DisplayName','0,1,0,0');

% 创建 line
line(XData4,YData4,'Parent',axes1,'MarkerSize',5,'Marker','.',...
    'LineStyle','none',...
    'Color',[0.5 0 1],...
    'DisplayName','1,0,0,0');

% 创建 legend
legend(axes1,'show');

