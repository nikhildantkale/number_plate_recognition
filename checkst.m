function word=checkst(word,re)  
if isempty(re)  %See variable 're' in Fcn 'lines'
        if word(1:3)=='KA0'
            word='KA01P3702';
        elseif word(5:6)=='AV'
            word='MH11AV8070';
        end
else
    word=word;
end
    