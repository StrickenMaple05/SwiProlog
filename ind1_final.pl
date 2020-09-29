% Сколько различных членов в последовательности, сгенерированной a^b для
% 2<=a<=n и 2<=b<=m? Задача должна быть решена без использования списков

%                  1 2 3 4  5  6
ind1(N,M,X):-count(2,2,N,M,0.0,X),!.

% 1. Параметр внешнего цикла a
% 2. Параметр внешнего цикла b
% 3. Верхняя граница для a
% 4. Верхняя граница для b
% 5. Текущий результат
% 6. Результат

count(_,B,_,M,Count,X):-B>M,X is Count,!.
count(A,B,N,M,Count,X):-A>N,B1 is B+1,count(2,B1,N,M,Count,X).
count(A,B,N,M,Count,X):-pow(A,B,Elem),
    cur_count(Elem,2,2,A,B,N,M,0,Count,X).
%              1   2 3 4 5 6 7 8   9  10

% 1. Текущий элемент для сравнения
% 2. Параметр внутреннего цикла a
% 3. Параметр внутреннего цикла b
% 4. Параметр внешнего цикла a
% 5. Параметр внешнего цикла b
% 6. Верхняя граница для a
% 7. Верхняя граница для b
% 8. Счётчик повторений для текущего элемента
% 9. Общий счётчик, передаваемый в count
% 10.Результат

cur_count(_,_,B,AA,BB,N,M,C,CC,X):-B>M,CC1 is CC+1/C,
    AA1 is AA+1,count(AA1,BB,N,M,CC1,X).
cur_count(Elem,A,B,AA,BB,N,M,C,CC,X):-A>N,B1 is B+1,
    cur_count(Elem,2,B1,AA,BB,N,M,C,CC,X).
cur_count(Elem,A,B,AA,BB,N,M,C,CC,X):-pow(A,B,Cur),
    Elem=Cur,C1 is C+1,A1 is A+1,cur_count(Elem,A1,B,AA,BB,N,M,C1,CC,X).
cur_count(Elem,A,B,AA,BB,N,M,C,CC,X):-A1 is A+1,
    cur_count(Elem,A1,B,AA,BB,N,M,C,CC,X).
