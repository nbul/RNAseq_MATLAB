clc;
clear all;

IPIs = table2array(readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/IPIs2.xlsx'));
Map = table2array(readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/list.xlsx'));


result(:,1) = Map(ismember(Map, IPIs(:,1)),1);
result(:,2) = Map(ismember(Map, IPIs(:,1)),4);

result2 = array2table(result);

writetable(result2, '/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/mapped2.xlsx');

names = table2array(readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/names2.xlsx'));

names2 = array2table(unique(strtok(names)));

writetable(names2, '/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/genenames2.xlsx');

%% wing vs D17
wing = readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/wing.xlsx');
D17 = readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/D17.xlsx');


result2 = innerjoin(wing, D17);
subplot(1,2,1);
scatter(table2array(result2(:,2)), table2array(result2(:,3)));

result3 = table2array(result2(:,2:3));
result3(any(isnan(result3), 2), :) = [];
result3( all(~result3,2), : ) = [];

[R1,P1] = corr(result3(:,1), result3(:,2));

mdl = fitlm(result3(:,1),result3(:,2));
anova(mdl,'summary')

%scatter(result3(:,1),result3(:,2),15, 'filled');

h = plot(mdl);
h(1).Marker = '.';
h(2).LineWidth = 3;
hold on
xlim([10 1000000])
ylim([10 10000])
set(gca,'fontsize',14)
text(15,1500, {'r^2 = ',R1}, 'fontsize', 14);
xlabel('Wing');
ylabel('D17');
title('');
set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log')

%% wing vs brain
wing = readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/wing.xlsx');
brain = readtable('/Users/nataliabulgakova/Documents/Grants/2023_BBSRC_apoptosis/brain.xlsx');


result4 = innerjoin(wing, brain);
subplot(1,2,2);
scatter(table2array(result4(:,2)), table2array(result4(:,3)));

result5 = table2array(result4(:,2:3));
result5(any(isnan(result5), 2), :) = [];
result5( all(~result5,2), : ) = [];

[R2,P2] = corr(result5(:,1), result5(:,2));

mdl2 = fitlm(result5(:,1),result5(:,2));
anova(mdl2,'summary')

%scatter(result3(:,1),result3(:,2),15, 'filled');

h2 = plot(mdl2);
h2(1).Marker = '.';
h2(2).LineWidth = 3;
hold on
xlim([10 1000000])
ylim([10 10000])
set(gca,'fontsize',14)
text(15,1500, {'r^2 = ',R2}, 'fontsize', 14);
xlabel('Wing');
ylabel('Brain');
title('');
set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log')

