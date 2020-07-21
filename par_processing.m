
function result = par_processing(data, k)
    parfor x=[1 2 3 4 5 6 7]
        if (x ==3)
            disp(x)
        end
    end
    disp("x");
    disp(k);
result = data(1);