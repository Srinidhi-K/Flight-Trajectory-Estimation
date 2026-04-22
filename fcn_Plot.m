function fcnPlot(plotData, label)

persistent labels;
labels{end+1} = label;
x = plotData(:, 1);
y = plotData(:, 2);
t = plotData(:, 3);

f = figure(1);
subplot(2, 1, 1)
plot(x, t)
xlim([0 91])
ylim([0 12])
ylabel('Time (in s)')
xlabel('Horizontal Distance (in m)')
legend(labels);
hold on
grid on

subplot(2, 1, 2)
plot(x, y)
xlim([0 15])
ylim([0.25 0.7])
xlabel('Horizontal Distance (in m)')
ylabel('Vertical Height (in m)')
xline(2.4, 'r', "Platform end")
hold on
grid on
legend(labels);
end