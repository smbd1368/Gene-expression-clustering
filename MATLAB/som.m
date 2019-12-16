load('aaaa.mat')

emptySpots = strcmp('EMPTY',genes);
yeastvalues(emptySpots,:) = [];
genes(emptySpots) = [];
numel(genes)

nanIndices = any(isnan(yeastvalues),2);
yeastvalues(nanIndices,:) = [];
genes(nanIndices) = [];
numel(genes)

inputs = yeastvalues;
dimension1 = 10;
dimension2 = 10;
net = selforgmap([dimension1 dimension2]);

% Train the Network
[net,tr] = train(net,inputs);

% Test the Network
outputs = net(inputs);
figure, plotsomtop(net)

plotsomhits(net,yeastvalues)
plotsomplanes(net)

plotsomnd(net)
% View the Network
view(net)



E_sil = mean(silh5)
E_db = evalclusters(yeastvalues,'gmdistribution','DaviesBouldin','klist',1:4)
E_mi = mutualInformation(clusters)

