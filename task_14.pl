% 14. Дан алфавит. Дана буква. Дана длина слова. Построить все слова
% данного алфавита заданной длины, в которых данная буква встречается
% три раза, остальные буквы ровно 1 раз.
%
% Позиции данной буквы в словах определяем через сочетания без
% повторений. Остальные буквы также определяем через сочетания без
% повторений.

sochet([],0,_):-!.
sochet([H|Sub_set],K,[H|Set]):-K1 is K-1,sochet(Sub_set,K1,Set).
sochet(Sub_set,K,[_|Set]):-sochet(Sub_set,K,Set).
pr_sochet:-read_str(A,_),read(K),sochet(B,K,A),write_str(B),nl,fail.

diff([],_,[]) :-!.
diff([H|T],List,Diff) :-diff(T,List,Diff1),
    member(H,List),Diff=Diff1,!.
diff([H|T],List,Diff) :-diff(T,List,Diff1),
		Diff=[H|Diff1].

fill(Length,List):-fill1(0,Length,[],List).
fill1(Length,Length,List,List):-!.
fill1(I,Length,List1,List):-append(List1,[I],List2),
		I1 is I+1,fill1(I1,Length,List2,List).

replaceBySymbol(Word,_A,[],Word):-!.
replaceBySymbol(CurWord,A,[H|T],Word):-
		replace(CurWord,A,H,CurWord1),
		replaceBySymbol(CurWord1,A,T,Word).

replace([_|T],Elem,0,[Elem|T]).
replace([H|T],Elem,I,[H|T1]):-I>0,I1 is I-1,replace(T,Elem,I1,T1),!.
replace(List,_,_,List).

replaceByElems(Word,_,[],Word):-!.
replaceByElems(CurWord,[H|T],[H1|T1],Word):-
		replace(CurWord,H,H1,CurWord1),
		replaceByElems(CurWord1,T,T1,Word).

remove(A,[A|T],T):-!.
remove(A,[H|T],[H|T1]):-remove(A,T,T1).

createEmpty([],0):-!.
createEmpty(Word,Length):-createEmpty1(Word,[],Length).
createEmpty1(Word,Word,0):-!.
createEmpty1(Word,Word1,Length):-append(Word1,[''],Word2),
		Length1 is Length-1,
		createEmpty1(Word,Word2,Length1).

input(Alphabet,A,Length):-
		%writeln("Введите алфавит:"),read_str(Alph1),
		Alph1=['a','b','c','d','e','f'],
		%writeln("Введите букву: "),get_char(A),
		A='a',
		remove(A,Alph1,Alphabet),
		%считывание натурального числа никак не работало
		%writeln("Введите длину: "),readint(Length).
		Length is 6.

output(Word):-output1(Word,Word).
output1([],Word):-writeln(Word),!.
output1([H|_],_Word):-H='',!.
output1([_|T],Word):-output1(T,Word).

task_14:-input(Alphabet,A,Length),createSet(Alphabet,A,Length).
createSet(Alphabet,A,Length):-fill(Length,MainSet),
		sochet(AIndexes,3,MainSet),
		diff(MainSet,AIndexes,OstIndexes),
		length(OstIndexes,OstLength),
		sochet(OstWord,OstLength,Alphabet),
		createEmpty(EmptyWord,Length),
		replaceBySymbol(EmptyWord,A,AIndexes,Word),
		replaceByElems(Word,OstWord,OstIndexes,FinalWord),
		output(FinalWord),fail.
