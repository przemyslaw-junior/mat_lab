% zad 13
% Skrypt porównujący metody polowienia, Nevtona i 
% Aproksymacja sześcienna( algorytm Davidona) dla różnych funkcji
clc
close all
clear all

wybor = 1;

switch wybor
    case 1
        f = @(x) x.^2 - x;
        a = (1/4);
        b = (3/4);
    case 2
        f = @(x) ((1/3)*x.^2) - ((13/7)*x)  + 11;
        a = -10;
        b = 10;
    case 3
        f = @(x) x.^4 - 12*(x.^3) + x + 4;
        a = -2;
        b = 2;
    case 4
        f = @(x) -x.^3 + 3*x.^2 -3*x;
        a = -2;
        b = -1;
    otherwise
        error('Nieprawidłowy wybór.');
end

eps = 1e-4;

% do zmierzenia czasu wykorzystaj polecenia tic i toc
tic;
[xp, np] = polowienia(f, a, b, eps);
czas_polowienia = toc;

% do zmierzenia czasu wykorzystaj polecenia tic i toc
tic;
[xn, nn] = nevton(f,(a+b)/2, eps);
czas_nevton = toc;

% % do zmierzenia czasu wykorzystaj polecenie tic toc
tic;
[xd, nd] = davidona(f, a, b, eps);
czas_davidona = toc;
% rysowanie wykresu funkcji f na przedzial [a,b] i zaznaczenie na nich znalezionych miejsc zerowych
t = a:0.01:b;
plot(t, f(t))
hold on;
plot(xp, f(xp), 'ro')
plot(xn, f(xn), 'rx')
plot(xd, f(xd), 'r^')


xlabel('x')
ylabel('f(x)')
title('Wykres funkcji oraz miejsca zerowe')

legend('f(x)', 'Metoda Polowienia', 'Metoda Nevtona', 'Metoda Davidona', 'Location', 'Best')
grid on;

% Funkcja Polowienia
function [x, n] = polowienia(f, a, b, eps)
    n = 0;
   while (b-a) >= eps
    x = (a + b) / 2;
    L = (b - a);
    x1 = a + 0.25 * L;
    x2 = a - 0.25 * L;
        if f(x1) < f(x) && f(x1) < f(x2)
            b = x;
        elseif f(x2) < f(x) && f(x2) < f(x1)
            a = x;
        else
            if f(x1) < f(x2)
                b = x1;
            else
                a = x2;
            end
        end
        n = n + 1;
   end

    fprintf('Metoda Polowienia: x = %.6f, liczba iteracji = %d, czas wykonania = %.6f s\n', x, n, eps);
end

% Funkcja Nevtona
function [x, n] = nevton(f, xk, eps)
    n = 0;
    x = xk;
    h = 1e-5;

    while abs(gradient(f, x)) >= eps
        x = x - (gradient(f, x) / hessian(f, x));
        n = n + 1;
    end  
 
     fprintf('Metoda Nevtona: x = %.6f, liczba iteracji = %d, czas wykonania = %.6f s\n', x, n, eps);
 end
 
 
% Funkcja Davidona
function [x, n] = davidona(f, a, b, eps)
    n = 0;
    x = (a + b) / 2;
    while (b - a ) >= eps
    Z = ((3*(f(a) - f(b))) / (b - a)) + gradient(f, a) + gradient(f, b);
    
    Q = (Z^2 - (gradient(f, a) * gradient(f, b)))*(1/2);
    
    xm = b - (((gradient(f, b) + Q -Z) / (gradient(f, b) - gradient(f, a) + (2 * Q)))) * (b - a);

        if gradient(f, xm) > 0
            a = xm;
        else
            b = xm;
        end
       
        n = n + 1;
    end

    fprintf('Metoda Davidona: x = %.6f, liczba iteracji = %d, czas wykonania = %.6f s\n', xm, n, eps);
end
% Funkcja obliczajaca pierwsza pochodną "gradient"
function poch_jeden = gradient(f, x)
         h = 1e-5;
        poch_jeden = (f(x + h) - f(x - h)) / (2 * h);
 end
% Funkcja obliczajaca drugą pochodną "hessian" 
 function poch_dwa = hessian(f, x)
         h = 1e-5;
        poch_dwa = (f(x + h) - (2 * f(x)) + f(x - h)) / h.^2;
 end
