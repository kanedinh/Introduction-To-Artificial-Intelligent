dong_vat_an_co(de).
dong_vat_hung_du(chosoi).
dong_vat_an_thit(X):-dong_vat_hung_du(X).
dong_vat(X):-dong_vat_an_co(X);dong_vat_an_thit(X).
an(X,thit):-dong_vat_an_thit(X).
an(X,co):-dong_vat_an_co(X).
an(X,Y):-dong_vat_an_thit(X),dong_vat_an_co(Y).
uong(X,nuoc):-dong_vat(X).
tieu_thu(X,Y):-dong_vat(X),(an(X,Y);uong(X,Y)).

/*
Cau 1:
Dinh nghia cac tri thuc:
- dong_vat(x): x la dong vat.
- dong_vat_an_co(x): x la dong vat an co.
- dong_vat_hung_du(x): x la dong vat hung du.
- dong_vat_an_thit(x): x la dong vat an thit.
- an(x,y): x an y.
- uong(x,y): x uong y.
- tieu_thu(x,y): x tieu thu y.

Su dung logic vi tu bieu dien cac phat bieu sau:
a. De la dong vat an co.
dong_vat_an_co(de).

b. Cho soi la dong vat hung du.
dong_vat_hung_du(chosoi).

c. Dong vat hung du la dong vat an thit(x):
Voi moi x, dong_vat_hung_du(x) → dong_vat_an_thit(x).

d. Dong vat an thit thi an thit.
Voi moi x, dong_vat_an_thit(x) → an(x,thit).

e. Dong vat an co thi an co.
Voi moi x, dong_vat_an_co(x) → an(x,co).

f. Dong vat an thit thi an cac dong vat an co.
Voi moi x, dong_vat_an_thit(x) → Ǝy,[dong_vat_an_co(y) and an(x,y)].

g. Dong vat an thit va dong vat an co deu uong nuoc.
Voi moi x, [dong_vat_an_thit(x) or dong_vat_an_co(x)] → dong_vat(x).
Voi moi x, dong_vat(x) → uong(x,nuoc).

h. Mot dong vat tieu thu cai ma no uong hoac cai ma no an.
Voi moi x,y, [dong_vat(x) and (uong(x,y) or an(x,y))] → tieu_thu(x,y).

Cau 2: chuyen cac logic vi tu sang Prolog va tra loi cau hoi: co dong
vat hung du khong va no tieu thu cai gi?
?- dong_vat_hung_du(X),tieu_thu(X,Y).
X = chosoi,
Y = thit ;
X = chosoi,
Y = de ;
X = chosoi,
Y = nuoc.
Tra loi: Co dong vat hung du la cho soi va no tieu thu thit, de, nuoc.
 */
