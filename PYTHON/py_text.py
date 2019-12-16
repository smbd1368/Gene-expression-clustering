import csv
from time import time
import numpy as np

from matplotlib import pyplot

from sklearn import metrics
from sklearn import cluster
from sklearn.cluster import KMeans
from sklearn.datasets import load_digits
from sklearn.decomposition import PCA
from sklearn.metrics import silhouette_score
from sklearn.preprocessing import scale

def load_clean_yeast_data():
	with open('SC_gene_expression.txt') as f:
		reader = csv.reader(f, delimiter="\t")
		d = list(reader)
	# Now, clean your data by
	d2 = d[1:]
	data_matrix = []
	for row in d2:
		data_matrix.append(row[2:5])
	#data_matrix = d[1:-1][2:19]
	print (len(data_matrix))
	print (len(data_matrix[8]))
	#print len(d)
	#print len(d[1])
	#print d[1][0:5]
	print (data_matrix)
	return np.array(data_matrix)


data = load_clean_yeast_data()
sklearn_pca = PCA(2)
processed_data = data

k = 4 # for the 384 gene yeast dataset
kmeans = cluster.KMeans(n_clusters=k)
cluster_labels=kmeans.fit_predict(processed_data)

print(cluster_labels)

# Extract labels and centroids
labels = kmeans.labels_
centroids = kmeans.cluster_centers_



# Plot the data
for i in range(k):
    # select only data observations with cluster label == i
    ds = processed_data[np.where(labels==i)]
    # plot the data observations
    pyplot.plot(ds[:,0],ds[:,1],'o')

    # plot the centroids
    lines = pyplot.plot(centroids[i,0],centroids[i,1],'kx')
    # make the centroid x's bigger
    pyplot.setp(lines,ms=15.0)
    pyplot.setp(lines,mew=2.0)

pyplot.show()
print(centroids[i,0])

print(kmeans.cluster_centers_)
silhouette_avg = silhouette_score(processed_data, cluster_labels)
print("For no of clusters =", 4,
	  " The average silhouette_score is :", silhouette_avg)



