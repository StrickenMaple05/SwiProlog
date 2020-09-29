% Для введённого списка построить два списка L1 и L2, где элементы L1
% - это неповторяющиеся элементы исходного списка, а элемент списка L2 с
% номером i показывает, сколько раз элемент списка L1 с таким номером
% повторяется в исходном.
%
% for (int i=0; i<n; ++i) {
%   k=0;
%   for (int j=0; j<n; ++j) {
%     if (a[i]==a[j]) ++k;
%     if (k>1) break; }

ind2([],_,_):-write("Список пуст"),!.

ind2([H|T],[H1|T1],[H2|T2]):-
    p(H,0,[H|T],T,[H|T],[lll],[lll],[H1|T1],[H2|T2]).
%     1 2   3   4   5     6     7      8       9

% Передаём предикату p1 все необходимое для составления списка L1:
% 1. Elem - элемент, для которого считается количество повторов
% 2. Freq - число раз, сколько Elem встретился в списке
% 3. Внутренний цикл для подсчета Freq для Elem
% 4. Внешний цикл для прохода по исходному списку и составления L1
% 5. Исходный список, проходящий сквозь все действия предиката
% 6. L1 | передаю атом, потому что, передавая пустой список,
% 7. L2 | вместе со списком получал в выводе адрес головы
% 8. Сюда передастся L1
% 9. Сюда передастся L2

p(_,Freq,[],[],_,[H1|T1],[H2|T2],[H1|T1],[H2|T2]):-Freq>1,
    writeln([H1|T1]),writeln([H2|T2]),break,!.
p(Elem,Freq,[],[],_,[H1|T1],[H2|T2],_,_):-Freq=1,
    append([H1|T1],[Elem],List1),append([H2|T2],[Freq],List2),
    p(Elem,2,[],[],[_],List1,List2,List1,List2).
% Если количество превысило 1, то переходим на новый элемент цикла
p(_,Freq,[_],[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    Freq>1,p(H2,0,[H|T],T2,[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).
% Если элемент снова встретился, увеличиваем Freq
p(Elem,Freq,[H1|T1],[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    Elem=H1,Freq1 is Freq+1,p(Elem,Freq1,T1,[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).
% Иначе ничего не трогаем
p(Elem,Freq,[_|T1],[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    p(Elem,Freq,T1,[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).
% Если элемент встречается в списке один раз, изменяем L1 и L2 и
% переходим к следующему элементу внешнего цикла
p(Elem,Freq,[],[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    Freq<2,append([Hl1|Tl1],[Elem],List1),append([Hl2|Tl2],[Freq],List2),
    p(H2,0,[H|T],T2,[H|T],List1,List2,[HH1|TT1],[HH2|TT2]).
p(_,_,[],[H2|T2],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
  p(H2,0,[H|T],T2,[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).

% Прописываем отдельно случай для последнего элемента списка (издержки
% реализации, предикат отказывается обрабатывать случай, когда внешний
% цикл на последней итерации)

p(_,Freq,[_],[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    Freq>1,p(nil,0,[],[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).
% Если элемент снова встретился, увеличиваем Freq
p(Elem,Freq,[H1|T1],[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    Elem=H1,Freq1 is Freq+1,p(Elem,Freq1,T1,[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).
% Иначе ничего не трогаем
p(Elem,Freq,[_|T1],[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]):-
    p(Elem,Freq,T1,[],[H|T],[Hl1|Tl1],[Hl2|Tl2],[HH1|TT1],[HH2|TT2]).