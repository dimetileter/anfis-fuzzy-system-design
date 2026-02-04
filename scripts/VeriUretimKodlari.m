clc; clear; close all;

% Fonksiyon Sınırları
alt_sinir = -100; 
ust_sinir = 100;

% Veri Sayıları
egitim_sayisi = 75;
test_sayisi = 50;


% 1. Rastgele giriş değerleri (x1 ve x2) üret
egitim_girisleri = alt_sinir + (ust_sinir - alt_sinir) * rand(egitim_sayisi, 2);

% 2. Çıkış değerlerini hesaplama
egitim_cikislari = zeros(egitim_sayisi, 1); % Hız için hafızada yer aç

for k = 1:egitim_sayisi
    x1 = egitim_girisleri(k, 1);
    x2 = egitim_girisleri(k, 2);
    
    % f(x1,x2) = x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2) + 0.7
    sonuc = x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2) + 0.7;
    egitim_cikislari(k, 1) = sonuc;

end

% 3. ANFIS İçin Eğitim Setini Birleştirme [x1 x2 y]
egitim_seti = [egitim_girisleri, egitim_cikislari];


% 1. Test girişleri üret
test_girisleri = alt_sinir + (ust_sinir - alt_sinir) * rand(test_sayisi, 2);

% 2. Çıkış Değerlerini Hesaplama
test_cikislari = zeros(test_sayisi, 1);

for k = 1:test_sayisi
    x1_t = test_girisleri(k, 1);
    x2_t = test_girisleri(k, 2);
    
    % Aynı fonksiyonu test verisi için hesapla
    sonuc_t = x1_t^2 + 2*x2_t^2 - 0.3*cos(3*pi*x1_t) - 0.4*cos(4*pi*x2_t) + 0.7;
    test_cikislari(k, 1) = sonuc_t;
end

% 3. Test Setini Birleştirme
test_seti = [test_girisleri, test_cikislari];


% Workspace'e de kaydet
save('BM_VeriSetleri.mat', 'egitim_seti', 'test_seti');
