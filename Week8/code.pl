% Dieu kien dung: x hoac y dat gia tri z.
solve(Vx, Vy, Z, X, Y, Visited, Steps) :-
    (X =:= Z ; Y =:= Z), !,
    reverse(Steps, Result),
    write('Cach dong nuoc va trang thai cua cac binh\n'),
    print_steps(Result).

% Do day binh Y khi no rong.
solve(Vx, Vy, Z, X, 0, Visited, Steps) :-
    \+ member((X, Vy), Visited),
    solve(Vx, Vy, Z, X, Vy, [(X, Vy) | Visited], [fill_y(X, Vy) | Steps]).

% Do day binh X khi no rong.
solve(Vx, Vy, Z, 0, Y, Visited, Steps) :-
    \+ member((Vx, Y), Visited),
    solve(Vx, Vy, Z, Vx, Y, [(Vx, Y) | Visited], [fill_x(Vx, Y) | Steps]).

% Do het nuoc trong binh X khi no day.
solve(Vx, Vy, Z, Vx, Y, Visited, Steps) :-
    \+ member((0, Y), Visited),
    solve(Vx, Vy, Z, 0, Y, [(0, Y) | Visited], [empty_x(0, Y) | Steps]).

% Do het nuoc trong binh Y khi no day.
solve(Vx, Vy, Z, X, Vy, Visited, Steps) :-
    \+ member((X, 0), Visited),
    solve(Vx, Vy, Z, X, 0, [(X, 0) | Visited], [empty_y(X, 0) | Steps]).

% Do nuoc tu binh Y sang binh X.
solve(Vx, Vy, Z, X, Y, Visited, Steps) :-
    X < Vx, Y > 0,
    K is min(Y, Vx - X),
    X1 is X + K,
    Y1 is Y - K,
    \+ member((X1, Y1), Visited),
    solve(Vx, Vy, Z, X1, Y1, [(X1, Y1) | Visited], [pour_y_to_x(X1, Y1) | Steps]).

% Do nuoc tu binh X sang binh Y.
solve(Vx, Vy, Z, X, Y, Visited, Steps) :-
    Y < Vy, X > 0,
    K is min(X, Vy - Y),
    X1 is X - K,
    Y1 is Y + K,
    \+ member((X1, Y1), Visited),
    solve(Vx, Vy, Z, X1, Y1, [(X1, Y1) | Visited], [pour_x_to_y(X1, Y1) | Steps]).

% In các bước thực hiện và trạng thái của các bình.
print_steps([]).
print_steps([Step | Rest]) :-
    (Step = fill_y(X, Y) -> format('Do day binh Y. Trang thai: X = ~w, Y = ~w\n', [X, Y]);
     Step = fill_x(X, Y) -> format('Do day binh X. Trang thai: X = ~w, Y = ~w\n', [X, Y]);
     Step = empty_x(X, Y) -> format('Do het nuoc trong binh X. Trang thai: X = ~w, Y = ~w\n', [X, Y]);
     Step = empty_y(X, Y) -> format('Do het nuoc trong binh Y. Trang thai: X = ~w, Y = ~w\n', [X, Y]);
     Step = pour_y_to_x(X, Y) -> format('Do nuoc tu binh Y sang binh X. Trang thai: X = ~w, Y = ~w\n', [X, Y]);
     Step = pour_x_to_y(X, Y) -> format('Do nuoc tu binh X sang binh Y. Trang thai: X = ~w, Y = ~w\n', [X, Y])),
    print_steps(Rest).

% Ham chay
start(Vx, Vy, X, Y, Z) :-
    % Tinh GCD cua Vx va Vy
    gcd(Vx, Vy, GCD),

    % Kiem tra dieu kien kha thi
    (Z > Vx, Z > Vy ->
        write('Khong the dong nuoc vi Z vuot qua the tich cua ca 2 binh.\n');
     Z mod GCD =:= 0 ->
        solve(Vx, Vy, Z, X, Y, [(X, Y)], []);
     write('Khong the dong nuoc vi Z khong phai boi so chung cua Vx va Vy.\n')
    ).

% Tinh uoc chung lon nhat cua Vx, Vy.
gcd(A, 0, A).
gcd(A, B, GCD) :-
    B > 0,
    R is A mod B,
    gcd(B, R, GCD).

/*
1. Xay dung co so tri thuc de giai quyet bai toan.
- Mien gia tri:
    1. Vx, Vy: the tich cua 2 binh (cac so nguyen duong).
    2. z: luong nuoc can dong (so nguyen duong nho hon hoac bang
    max(Vx,Vy)).
    3. x,y: luong nuoc hien tai trong binh X va Y (gia tri tu 0->Vx,Vy).
- Trang thai: duoc bieu dien duoi cap (x,y), trong do:
    1. x: luong nuoc trong binh X hien tai.
    2. y: luong nuoc trong binh Y hien tai.
- Hanh dong:
    1. Do day binh:
        - Do day binh X: (x,y) -> (Vx,y).
        - Do day binh Y: (x,y) -> (x,Vx).
    2. Do het nuoc trong binh:
        - Do het nuoc trong binh X: (x,y) -> (0,y).
        - Do het nuoc trong binh Y: (x,y) -> (x,0).
    3. Chuyen nuoc giua 2 binh:
        - Chuyen nuoc tu binh X sang Y:
            - Neu x+y <= Vy: (x,y) -> (0,x+y).
            - Neu x+y >  Vy: (x,y) -> (x-(Vy-y),Vy).
        - Chuyen nuoc tu binh Y sang X:
            - Neu x+y <= Vx: (x,y) -> (x+y,0).
            - Neu x+y >  Vx: (x,y) -> (Vx,y-(Vx-x)).
- Trang thai muc tieu: (x,y) thoa man khi x == z hoac y == z.
- Dieu kien kha thi: bai toan co nghien khi va chi khi z la boi so cua
UCLN(Vx,Vy) va z <= max(Vx,Vy).

2,3. Cai dat tri thuc va viet chuong trinh minh hoa de giai bai toan.
?- start(5,3,0,0,4).
Cach dong nuoc va trang thai cua cac binh
Do day binh Y. Trang thai: X = 0, Y = 3
Do day binh X. Trang thai: X = 5, Y = 3
Do het nuoc trong binh Y. Trang thai: X = 5, Y = 0
Do nuoc tu binh X sang binh Y. Trang thai: X = 2, Y = 3
Do het nuoc trong binh Y. Trang thai: X = 2, Y = 0
Do nuoc tu binh X sang binh Y. Trang thai: X = 0, Y = 2
Do day binh X. Trang thai: X = 5, Y = 2
Do nuoc tu binh X sang binh Y. Trang thai: X = 4, Y = 3
true ;
Cach dong nuoc va trang thai cua cac binh
Do day binh Y. Trang thai: X = 0, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 3, Y = 0
Do day binh Y. Trang thai: X = 3, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 5, Y = 1
Do het nuoc trong binh X. Trang thai: X = 0, Y = 1
Do nuoc tu binh Y sang binh X. Trang thai: X = 1, Y = 0
Do day binh Y. Trang thai: X = 1, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 4, Y = 0
true ;
Cach dong nuoc va trang thai cua cac binh
Do day binh X. Trang thai: X = 5, Y = 0
Do day binh Y. Trang thai: X = 5, Y = 3
Do het nuoc trong binh X. Trang thai: X = 0, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 3, Y = 0
Do day binh Y. Trang thai: X = 3, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 5, Y = 1
Do het nuoc trong binh X. Trang thai: X = 0, Y = 1
Do nuoc tu binh Y sang binh X. Trang thai: X = 1, Y = 0
Do day binh Y. Trang thai: X = 1, Y = 3
Do nuoc tu binh Y sang binh X. Trang thai: X = 4, Y = 0
true ;
Cach dong nuoc va trang thai cua cac binh
Do day binh X. Trang thai: X = 5, Y = 0
Do nuoc tu binh X sang binh Y. Trang thai: X = 2, Y = 3
Do het nuoc trong binh Y. Trang thai: X = 2, Y = 0
Do nuoc tu binh X sang binh Y. Trang thai: X = 0, Y = 2
Do day binh X. Trang thai: X = 5, Y = 2
Do nuoc tu binh X sang binh Y. Trang thai: X = 4, Y = 3
true ;
false.
 */
