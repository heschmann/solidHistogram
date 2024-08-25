function out = solidHistogram(data,X)
% Hannes Eschmann, 19.03.2021
% creates a layered histogramm of N data series of the same length M, such
% that no bin is covered. Dimension of data is [N M].
% the resulting series [N^2 M] can be plotted row by row from top to bottom
% to archive the desired effect.

N = size(data,1);
out = zeros(N^2,size(data,2)); %check each row against each row
%% sort
[sortVals, Idx] = sort(data,1,'descend'); % largest to smallest
%% assemble dataset
for k = 1:N
    for j = 1:N
        % assign output from top row to bottom row
        % first N rows contain the largest values of the input data
        % The order of the input data is preserved, meaning that the first
        % row of out contains data from the first row of data, the secon
        % row of out contains data of the second row of data and so on.
        % This is importatnt for coloring of the bars later.
        out(N*(k-1)+j,Idx(k,:)==j) = sortVals(k,Idx(k,:)==j);
    end
end
%% plot
cols = jet(N);
hold on
for i = 1:size(out,1)
    if nargin == 1
        bar(1:size(data,2),out(i,:),'Facecolor',cols(mod(i,N)+1,:));
    else
        bar(X(1:end-1),out(i,:),'Facecolor',cols(mod(i,N)+1,:));
    end
end