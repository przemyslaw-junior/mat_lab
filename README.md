Ekstremum funkcji jednej zmiennej.
Metody poszukiwań:
metoda połowienia, aproksymacji sześciennej, metoda Newtona.
Badanie czasu obliczeń. Porównanie działania metod.

Metoda połowienia
Mając dane dwa punkty a i b wyznaczamy środek przedłziau jako xm = (a+b)/2
Następnie wyznaczamy dwa punkty leżące w środkach przedziałów [a, xm]: x1 = a + 0.25 · L oraz [xm, b]: x2 = b − 0.25 · L, gdzie L = b − a.
W kolejnym kroku metody należy odrzucić dwa punkty:
po lewej stronie przedziału, po prawej stronie przedziału lub po jednym z każdego końca.
Decyzję o tym, które z punktów należy odrzucić podejmuje się na podstawie wartości funkcji w tychże punktach - odrzucamy te o największych wartościach funkcji.
Następnie obliczamy nowe L oraz dwa punkty x1, x2 i powtarzamy procedurę.
Warto zauważyć, że w kazdym kroku trzeba obliczyć wartości funkcji tylko w dwóch nowych punktach.
Poszukiwanie minimum należy zakończyć, gdy spełniony zostanie warunek b − a < epsilon

Aproksymacja sześcienna - algorytm Davidona
Mając dane dwa punkty a i b obliczamy punkt xm zgodnie ze wzorem: 
xm = b − ((f'(b)+Q−Z)/f'(b)−f'(a)+2Q) * (b−a), gdzie
Q = sqrt(Z^2 − f'(a) · f'(b))
Z = (3(f(a)−f(b))) / (b−a) + f'(a) + f'(b)
Następnie należy zwęzić przedział poszukiwań do [a, xm] lub [xm, b] badając znak pochodnej w xm.
Jeżli f'(xm) > 0, to zawężamy przedział do [a, xm], w przeciwnym wypadku do [xm, b].
Poszukiwanie minimum należy zakończyć, gdy spełniony zostanie warunek x3 − x1 < epsilon

Metoda Newtona
Metoda bazuje na wyznaczaniu wartości pierwszej i drugiej pochodnej funkcji f.
Początkowy punkt x1 powinien znajdować się odpowiednio blisko szukanego minimum.
Wtedy, kolejny punkt wyznacza się zgodnie ze wzorem: xk+1 = xk − f'(xk) / f''(xk) .
Poszukiwanie minimum należy zakończyć, gdy spełniony zostanie warunek |f'(xk)| < epsilon.
Numeryczne liczenie pochodnych w punkcie x
f'(x) = (f(x + h) − f(x − h)) / 2h
f''(x) = (f(x + h) − 2f(x) + f(x − h)) / h2
gdzie h to mała wartość, np. 10^−5
