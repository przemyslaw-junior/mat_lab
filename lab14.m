function [] = lab14()
    clc
    close
    clear
    
    wybor = 3;
    
    switch wybor
        case 1
            f = @(x1, x2) x1.^2 + x2.^2;
            x1p = -10;
            x1k = 10;
            x2p = -10;
            x2k = 10;
            xpocz = 8;
            ypocz = -10;
            krok = 1;
        case 2
            f = @(x1, x2) -cos(x1) * cos(x2) * exp(-((x1-pi)^2 + (x2 - pi)^2));

            x1p = 2;
            x1k = 4;
            x2p = 2;
            x2k = 4;
            xpocz = 2;
            ypocz = 2;
            krok = 0.1;
        case 3
            f = @(x1, x2) (1 - 8*x1 + 7*(x1.^2) - (7/3)*(x1.^3) + (1/4)*(x1.^4)).* ((x2.^2) .* exp(-x2));
            x1p = 0;
            x1k = 5;
            x2p = 0;
            x2k = 5;
            xpocz = 5;
            ypocz = 5;
            krok = 0.2;
        otherwise
            error('Nieprawidłowy wybór.');
    end
    
    eps = 1e-6;
    
    [x1, x2, dx1, dx2, it] = sww(f, xpocz, ypocz, krok, eps, x1p, x1k, x2p, x2k);
    
    % Wykres 3D funkcji
    subplot(2, 1, 1);
    [x, y] = meshgrid(x1p:0.1:x1k, x2p:0.1:x2k);
    z = f(x, y);
    mesh(x, y, z);
    hold on;
    plot3(xpocz, ypocz, f(xpocz, ypocz), 'r*', 'MarkerSize', 10);
    plot3(x1, x2, f(x1, x2), 'g*', 'MarkerSize', 10);
    title('Funkcja 3D i ścieżka minimalizacji');
    xlabel('x1');
    ylabel('x2');
    zlabel('f(x1, x2)');
    
    % Wykres poziomicowy
    subplot(2, 1, 2);
    [C, h] = contour(x, y, z, 20);
    clabel(C, h);
    hold on;
    plot(xpocz, ypocz, 'r*', 'MarkerSize', 10);
    plot(x1, x2, 'g*', 'MarkerSize', 10);
    title('Wykres poziomicowy');
    xlabel('x1');
    ylabel('x2');
    
    % Narysowanie ścieżki
    for i = 1:length(dx1) - 1
        line([dx1(i), dx1(i + 1)], [dx2(i), dx2(i + 1)], 'Color', 'k', 'LineWidth', 1);
        contour(x, y, z, [f(dx1(i), dx2(i)), f(dx1(i + 1), dx2(i + 1))]);
    end
end

function [x1, x2, dx1, dx2, it] = sww(f, xpocz, ypocz, krok, eps, x1p, x1k, x2p, x2k)
    x1 = xpocz;
    x2 = ypocz;
    dx1 = [x1];
    dx2 = [x2];
    it = 0;
    
    while true
        % Obliczenia gradientu dla x1
        df_dx1 = (f(x1 + krok, x2) - f(x1 - krok, x2)) / (2 * krok);
        
        % Obliczenia gradientu dla x2
        df_dx2 = (f(x1, x2 + krok) - f(x1, x2 - krok)) / (2 * krok);
        
        % Aktualizacja punktu
        x1 = x1 - krok * df_dx1;
        x2 = x2 - krok * df_dx2;
        
        % Zapisanie punktu do wektorów
        dx1 = [dx1, x1];
        dx2 = [dx2, x2];
        
        it = it + 1;
        
        % Sprawdzenie warunku stopu
        if sqrt(df_dx1^2 + df_dx2^2) < eps || it > 1000
            break;
        end
    end
end