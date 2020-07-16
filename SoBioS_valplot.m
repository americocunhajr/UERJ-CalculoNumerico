% -----------------------------------------------------------------
%  SoBioS_valplot.m
% -----------------------------------------------------------------
%
%  This script is the plot file for the pCE validation.
% -----------------------------------------------------------------
%  programmer: Michel Tosin
%              michel.tosin@uerj.br
%
%  last update: March 20, 2020
% -----------------------------------------------------------------

function SoBioS_valplot(Ymod,Ypce,err_p,logerr)

close all

% Response match  
  for j = 1%:size(Ymod,2)

      %pause(5)
        
      figure
      gname  = ['Validation_',num2str(j)]; 
      plot(Ymod(:,j),Ypce(:,j),'o','Color','r') % samples

      hold on
      plot([min(Ymod(:,j)) max(Ymod(:,j))],...  % identity line
	   [min(Ymod(:,j)) max(Ymod(:,j))],...
	   '-','Color','b','linewidth',2)
      hold off

      set(gcf,'PaperPositionMode','auto');
      set(gcf,'Position',[50 50 950 700]);

      %title(['Component #',num2str(j)]);
      title(' ','FontSize',25,'FontName','Helvetica');
      grid on;

      set(gcf,'color','white');
      set(gca,'FontSize',30,'FontName','Helvetica');

      xlabel('computational model','color','k','FontSize',45,'FontName','Helvetica');
      ylabel('surrogate model','color','k','FontSize',45,'FontName','Helvetica');

      set(gca,'Box','on');                                  % box around graph
      set(gca,'XColor',[0 0 0],'YColor',[0 0 0]);     % color of the box outline
      set(gca,'TickDir','in','TickLength',[.02 .02]);      % tick settings
      set(gca,'XMinorTick','on','YMinorTick','on');
      set(gca,'XGrid','on','YGrid','on');

      xlim([min(Ymod(:,j)) max(Ymod(:,j))]);
      ylim([min(Ymod(:,j)) max(Ymod(:,j))]);

    % Settings for y axis tick labels and order of magnitude
      set(gca,'XTickMode','manual','YTickMode','manual')          % preserve tick values for all figure sizes
      set(gca,'XLimMode','manual','YLimMode','manual')            % preserve axis limits for all figure sizes
      yl = get(gca,'ylim');                                       
      set(gca,'yTick',linspace(yl(1),yl(2),4))                    % setting number of tick labels to display          
      BD = 2;                                                     % # of SF before the point in highest tick 
                                                                  %label (exception: if highest=1 use 0)
      OM = ceil(log10(yl(2)));                                    % ceiling order of magnitude
      ryt=get(gca,'ytick')/10^(OM-BD);                            % redefining tick labels
    % Formating new tick labels
      nyt=cell(size(ryt));
      for i=1:length(ryt)
          nyt{i}=sprintf('% 2.1f',ryt(i));
          % example: '% W.Xf' displays fixed-point notation with X
          % digits after the decimal point, minimum of W characters.
          % The space after the percent inserts a space before the
          % displayed value, giving the same size to + and - numbers. 
      end
      set(gca,'yticklabel',nyt);                                  % setting tick labels
    % Placing order of magnitude
      fs = get(gca,'fontsize');
      set(gca,'units','normalized');
      xl = xlim;
      %text(xl(1),yl(2),sprintf('\\times10^{%d}',OM-BD),'fontsize',fs,'VerticalAlignment','bottom');
                
                
    % Settings for x axis tick labels and order of magnitude
      xl = get(gca,'xlim');                                       
      set(gca,'xTick',linspace(xl(1),xl(2),4))                    % setting number of tick labels to display          
      BD = 2;                                                     % # of SF before the point in highest tick 
                                                                  % label (exception: if highest=1 use 0)
      OM = ceil(log10(xl(2)));                                    % ceiling order of magnitude
      rxt=get(gca,'xtick')/10^(OM-BD);                            % redefining tick labels
    % Formating new tick labels
      nxt=cell(size(rxt));
      for i=1:length(rxt)
          nxt{i}=sprintf('% 2.1f',rxt(i));
          % example: '% W.Xf' displays fixed-point notation with X
          % digits after the decimal point, minimum of W characters.
          % The space after the percent inserts a space before the
          % displayed value, giving the same size to + and - numbers. 
      end
      set(gca,'xticklabel',nxt);                                  % setting tick labels
    % Placing order of magnitude
      fs = get(gca,'fontsize');
      set(gca,'units','normalized');
      xl = xlim;
      %text(xl(2),yl(1),sprintf('\\times10^{%d}',OM-BD),'fontsize',fs,'VerticalAlignment','bottom');
      %text('Units','normalized','VerticalAlignment','bottom','FontSize',fs,'String',...
	%                        sprintf('\\times10^{%d}',OM-BD),'Position',[0.88 -0.35 0]);
                
      print(gcf,gname,'-dpdf','-r300','-bestfit');
      system(['pdfcrop',' ',gname,'.pdf',' ',gname,'.pdf'])
    
  end


% Outlier residual error
  for j = 1%:size(Ymod,2)

      figure
      gname  = ['Error_',num2str(j)]; 
      stem(err_p(:,j),'filled','LineStyle','none')

      set(gcf,'PaperPositionMode','auto');
      set(gcf,'Position',[50 50 950 700]);

      %title(['Component #',num2str(j)]);
      title(' ','FontSize',25,'FontName','Helvetica');
      grid on;

      set(gcf,'color','white');
      set(gca,'FontSize',30,'FontName','Helvetica');

      xlabel('simulations','color','k','FontSize',45,'FontName','Helvetica');
      ylabel('error','color','k','FontSize',45,'FontName','Helvetica');

      set(gca,'Box','on');                                  % box around graph
      set(gca,'XColor',[0 0 0],'YColor',[0 0 0]);     % color of the box outline
      set(gca,'TickDir','in','TickLength',[.02 .02]);      % tick settings
      set(gca,'XMinorTick','on','YMinorTick','on');
      set(gca,'XGrid','on','YGrid','on');

    % Settings for y axis tick labels and order of magnitude
      set(gca,'XTickMode','manual','YTickMode','manual')          % preserve tick values for all figure sizes
      set(gca,'XLimMode','manual','YLimMode','manual')            % preserve axis limits for all figure sizes
      yl = get(gca,'ylim');                                       
      set(gca,'yTick',linspace(yl(1),yl(2),5))                    % setting number of tick labels to display          
      BD = 1;                                                     % # of SF before the point in highest tick 
                                                                  %label (exception: if highest=1 use 0)
      OM = ceil(log10(yl(2)));                                    % ceiling order of magnitude
      ryt=get(gca,'ytick')/10^(OM-BD);                            % redefining tick labels
    % Formating new tick labels
      nyt=cell(size(ryt));
      for i=1:length(ryt)
          nyt{i}=sprintf('% 1.2f',ryt(i));
          % example: '% W.Xf' displays fixed-point notation with X
          % digits after the decimal point, minimum of W characters.
          % The space after the percent inserts a space before the
          % displayed value, giving the same size to + and - numbers. 
      end
      set(gca,'yticklabel',nyt);                                  % setting tick labels
    % Placing order of magnitude
      fs = get(gca,'fontsize');
      set(gca,'units','normalized');
      xl = xlim;
      %text(xl(1),yl(2),sprintf('\\times10^{%d}',OM-BD),'fontsize',fs,'VerticalAlignment','bottom');
                
                
    % Settings for x axis tick labels and order of magnitude
      xl = get(gca,'xlim');                                       
      set(gca,'xTick',linspace(xl(1),xl(2),5))                    % setting number of tick labels to display          
      BD = 1;                                                     % # of SF before the point in highest tick 
                                                                  % label (exception: if highest=1 use 0)
      OM = ceil(log10(xl(2)));                                    % ceiling order of magnitude
      rxt=get(gca,'xtick')/10^(OM-BD);                            % redefining tick labels
    % Formating new tick labels
      nxt=cell(size(rxt));
      for i=1:length(rxt)
          nxt{i}=sprintf('% 3.1f',rxt(i));
          % example: '% W.Xf' displays fixed-point notation with X
          % digits after the decimal point, minimum of W characters.
          % The space after the percent inserts a space before the
          % displayed value, giving the same size to + and - numbers. 
      end
      set(gca,'xticklabel',nxt);                                  % setting tick labels
    % Placing order of magnitude
      fs = get(gca,'fontsize');
      set(gca,'units','normalized');
      xl = xlim;
      %text(xl(2),yl(1),sprintf('\\times10^{%d}',OM-BD),'fontsize',fs,'VerticalAlignment','bottom');
      text('Units','normalized','VerticalAlignment','bottom','FontSize',fs,'String',...
	                        sprintf('\\times10^{%d}',OM-BD),'Position',[0.85 -0.35 0]);
                
      print(gcf,gname,'-dpdf','-r300','-bestfit');
      system(['pdfcrop',' ',gname,'.pdf',' ',gname,'.pdf'])
    
  end





  close all

end
