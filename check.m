function word=checkst(word,re)  
if isempty(re)  %See variable 're' in Fcn 'lines'
        if word=='KA01P372'
            word='KA01P3702';
        elseif word(1:3)=='X3X'
            word='M31DD3568';
        end
end  