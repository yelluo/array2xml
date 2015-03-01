variablename = 'identify';
nodename = 'face'; % node name of root

eval(['mat=' variablename ';']); % mat = identify;
filename = [variablename '.xml'];
fop = fopen(filename, 'w');
fprintf(fop, ['<?xml version="1.0" encoding="gb2312"?>\n<' variablename '>\n']);
fclose( fop );
mat2xml(mat, filename, nodename);
fop = fopen(filename, 'a');
fprintf(fop, ['</' variablename '>']);
fclose( fop );
