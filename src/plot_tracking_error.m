scatter(xr,yr)
hold on
plot(xr,yr,'--','LineWidth',2,'Color','k')
plot(xypsi.Data(:,1),xypsi.Data(:,2),'LineWidth',2,'Color','r')
legend('reference point','reference trajectory','actual trajectory','Location','best')