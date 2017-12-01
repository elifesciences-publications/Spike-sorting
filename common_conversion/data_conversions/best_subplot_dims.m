function [Cs Rs] = best_subplot_dims(N);

switch N
    case {1,2,3}
        Cs = 1;
        Rs = N;
    case 4
        Cs = 2;
        Rs = 2;
    case {5,6}
        Cs = 3;
        Rs = 2;
    case {7,8}
        Cs = 4;
        Rs = 2;
    case 9 
        Cs = 3;
        Rs = 3;
    case {10,11,12}
        Cs = 4;
        Rs = 3;
    case {13,14,15,16}
        Cs = 4;
        Rs = 4;
    case {17,18,19,20}
        Cs = 5;
        Rs = 4;
    case {21,22,23,24}
        Cs = 6;
        Rs = 4;
    case {25,26,27,28,29,30}
        Cs = 6
        Rs = 5;
    otherwise
        Cs = 6;
        Rs = 6;
end

