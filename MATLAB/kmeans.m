load('aaaa.mat')

emptySpots = strcmp('EMPTY',genes);
yeastvalues(emptySpots,:) = [];
genes(emptySpots) = [];
numel(genes)

nanIndices = any(isnan(yeastvalues),2);
yeastvalues(nanIndices,:) = [];
genes(nanIndices) = [];
numel(genes)

mask = genevarfilter(yeastvalues);

yeastvalues = yeastvalues(mask,:);
genes = genes(mask);
numel(genes)

[mask,yeastvalues,genes] = genelowvalfilter(yeastvalues,genes,'absval',log2(3));
numel(genes)

[mask,yeastvalues,genes] = geneentropyfilter(yeastvalues,genes,'prctile',15);
numel(genes)

corrDist = pdist(yeastvalues,'corr');
clusterTree = linkage(corrDist,'average');
    
numc=4;
clusters = cluster(clusterTree,'maxclust',numc);

figure
for c = 1:numc
    subplot(4,4,c);
    plot(1:79,yeastvalues((clusters == c),:)');
    axis tight
end
suptitle('Hierarchical Clustering of Profiles');


figure
for c = 1:4
    subplot(4,4,c);
    plot(1:79,yeastvalues(c,:)');
    axis tight
    axis off
end

suptitle('K-Means Clustering of Profiles');


silhouette(yeastvalues,clusters)
[silh5,h] =silhouette(yeastvalues,clusters,'Euclidean');
Silhouette = mean(silh5);


E_sil = mean(silh5)
E_db = evalclusters(yeastvalues,'gmdistribution','DaviesBouldin','klist',1:4)
E_mi = mutualInformation(clusters)




