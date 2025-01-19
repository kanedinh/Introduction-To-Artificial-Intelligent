parent(marry,bill).
parent(tom,bill).
parent(tom,liz).
parent(bill, ann).
parent(bill, sue).
parent(sue,jim).

/*
Cau 1:
a.
?- parent(jim,X).
false.
Tra loi: Jim khong co con.

b.
?- parent(X,jim).
X = sue.
Tra loi: Sue la cha me cua Jim.

c.
?- parent(marry,X),parent(X,part).
false.
Tra loi: Marry khong co con la cha me cua Part.

d.
?- parent(marry,X),parent(X,Y),parent(Y,jim).
X = bill,
Y = sue.
Tra loi: Marry la cha me cua Bill, Bill la cha me cua Sue, Sue la cha me
cua Jim.

Cau 2:
a. Ai la cha me cua Bill?
?- parent(X,bill).
X = marry ;
X = tom.
Tra loi: Marry va Tom la cha me cua Bill.

b. Marry co con khong?
?- parent(marry,X).
X = bill.
Tra loi: Marry co con ten la Bill.

c. Ai la ong ba (grandparent) cua Sue?
?- parent(X,Y),parent(Y,sue).
X = marry,
Y = bill ;
X = tom,
Y = bill ;
false.
Tra loi: Marry va Tom la ong ba cua Sue.
*/
