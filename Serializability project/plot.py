import matplotlib.pyplot as plt
import numpy as np

data_to_plot = [[0.61,0.62,0.6,0.62,0.64,0.63,0.61,0.6,0.57,0.62,0.6,0.62,0.6,0.64,0.61,0.6,0.64,0.58,0.6,0.62],
                [0.66,0.63,0.63,0.64,0.62,0.67,0.62,0.68,0.58,0.64,0.6,0.64,0.57,0.63,0.59,0.64,0.61,0.58,0.63,0.67],
                [0.6,0.58,0.59,0.6,0.61,0.57,0.63,0.6,0.57,0.6,0.6,0.6,0.61,0.59,0.59,0.59,0.64,0.59,0.58,0.62],
                [0.84,0.77,0.83,0.84,0.76,0.74,0.81,0.8,0.83,0.74,0.82,0.8,0.8,0.78,0.81,0.73,0.79,0.8,0.74,0.69]]

positions = np.arange(4) + 1

bp = plt.boxplot(data_to_plot,
                 showmeans=True,
                 positions=positions,
                 labels=['ReadUnCommit','ReadCommit','RepeatableRead','Serializable'])

means = [np.mean(data) for data in data_to_plot]
above_dev = [np.mean(data)+np.std(data) for data in data_to_plot]
under_dev = [np.mean(data)-np.std(data) for data in data_to_plot]
maxV = [np.max(data) for data in data_to_plot]
minV = [np.min(data) for data in data_to_plot]
plt.plot(positions, above_dev, 'rs')
plt.plot(positions, under_dev, 'bs')
plt.plot(positions, maxV, 'ks')
plt.plot(positions, minV, 'ys')
plt.xlabel("isolation level")
plt.ylabel("average execution time")
plt.title('S=100,E=20,P=100')

plt.show()
