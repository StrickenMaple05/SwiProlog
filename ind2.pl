% Для введённого списка положительных чисел построить список всех
% положительных делителей элементов списка без повторений

poz_del([H|T]):-write('1'), List is [H|T], findMax(List,List,H).
findMax([],List,Max):-poz_del1(List,List,2,Max).
findMax([H|T],List,Max):-H>Max,Max is H, findMax(T,List,Max).
findMax([_|T],List,Max):-findMax(T,List,Max).
poz_del1([H|_],List,Del,Max):-H mod Del is 0,
    write(' ' + Del),Del1 is Del+1,
    Del1 =< Max/2, poz_del1(List,List,Del1,Max).
poz_del1([_|T],List,Del,Max):-poz_del1(T,List,Del,Max).
poz_del1([],List,Del,Max):-Del1 is Del+1,
    Del1 =< Max/2, poz_del1(List,List,Del1,Max).
