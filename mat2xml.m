function mat2xml(mat, filename, nodename)
%export cell array or structure array of Matlab to xml file 
% 将Matlab中的元胞数组或结构数组导出到xml文件
% Yelluo, 2005-3-1    
    if iscell(mat)
       len = length(mat);
       for i = 1:len
           fop = fopen(filename, 'a');
           if len > 1           
               fprintf(fop, '<%s id="%d">\n', nodename, i);
           else
               fprintf(fop, '<%s>\n', nodename);
           end
           fclose( fop );
           content = mat{i};
           mat2xml(content, filename, nodename);
           fop = fopen(filename, 'a');
           fprintf(fop, '</%s>\n', nodename);
           fclose( fop );
       end
    else        
        if isstruct(mat)
            len = length(mat);
            names = fieldnames(mat);
            namesnum = length(names);
            for i = 1:len                
                if len > 1
                    fop = fopen(filename, 'a');
                    fprintf(fop, '<%s id="%d">\n', nodename, i);
                    fclose( fop );
                end                
                for j = 1:namesnum
                    fop = fopen(filename, 'a');
                    fprintf(fop, '<%s>', names{j});
                    fclose( fop );
                    content = getfield(mat(i), names{j});
                    mat2xml(content, filename, [names{j}, 'node']);
                    fop = fopen(filename, 'a');
                    fprintf(fop, '</%s>\n', names{j});
                    fclose( fop );
                end
                if len > 1
                    fop = fopen(filename, 'a');
                    fprintf(fop, '</%s>\n', nodename);
                    fclose( fop );
                end
            end
        else
            fop = fopen(filename, 'a');
            if ischar(mat)
                fprintf(fop, '%s', mat);
            elseif ismatrix(mat)
                for i = 1:length(mat)
                    fprintf(fop, '<%s>%g</%s>\n', nodename, mat(i), nodename);
                end
            elseif isfloat(mat) || isdouble(mat)
                fprintf(fop, '%g', mat);            
            else
                fprintf(fop, 'Unknown content.\n');
            end
            fclose( fop );
        end        
    end    
end