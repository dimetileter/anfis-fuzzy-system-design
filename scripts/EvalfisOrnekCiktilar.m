clc; clear; close all;

dosya_test_verisi = 'BM_Test_Verisi.xlsx';
dosya_myfis       = 'BM_24_803_MyFis.fis';  
dosya_anfis       = 'BM_24_803_ANFIS.fis';  


test_data = readmatrix(dosya_test_verisi); 
x_test = test_data(:, 1:2);                
y_gercek = test_data(:, 3);                

my_fis = readfis(dosya_myfis);    
anfis_fis = readfis(dosya_anfis); 

% çıktılar
y_MyFis = evalfis(my_fis, x_test);      
y_Anfis = evalfis(anfis_fis, x_test);   

% tablo numaraları
No = (1:size(x_test, 1))'; 

Sonuc_Tablosu = table(No, x_test(:,1), x_test(:,2), y_gercek, y_MyFis, y_Anfis, ...
    'VariableNames', {'No', 'x1', 'x2', 'y_Gercek', 'y_MyFis', 'y_Anfis'});

disp(Sonuc_Tablosu);

% Tabloyu Excel'e Kaydet
writetable(Sonuc_Tablosu, 'BM_Final_Tablo.xlsx');

% MyFis R2
R2_MyFis = 1 - sum((y_gercek - y_MyFis).^2) / sum((y_gercek - mean(y_gercek)).^2);
% ANFIS R2
R2_Anfis = 1 - sum((y_gercek - y_Anfis).^2) / sum((y_gercek - mean(y_gercek)).^2);

% Grafik 1: MyFis
figure('Name', 'MyFis Performansı', 'Color', 'w');
scatter(y_gercek, y_MyFis, 'b', 'filled'); hold on;
plot([min(y_gercek) max(y_gercek)], [min(y_gercek) max(y_gercek)], 'r--', 'LineWidth', 2);
title(['MyFis Başarısı (R^2 = ' num2str(R2_MyFis, '%.4f') ')']);
xlabel('Gerçek Değerler'); ylabel('MyFis Tahminleri');
grid on;

% Grafik 2: ANFIS
figure('Name', 'ANFIS Performansı', 'Color', 'w');
scatter(y_gercek, y_Anfis, 'g', 'filled'); hold on;
plot([min(y_gercek) max(y_gercek)], [min(y_gercek) max(y_gercek)], 'r--', 'LineWidth', 2);
title(['ANFIS Başarısı (R^2 = ' num2str(R2_Anfis, '%.4f') ')']);
xlabel('Gerçek Değerler'); ylabel('ANFIS Tahminleri');
grid on;
