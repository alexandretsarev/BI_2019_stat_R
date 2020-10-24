import pandas as pd
import numpy 
import seaborn as sns
import matplotlib.pyplot as plt

from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV  
from sklearn import metrics
from sklearn.metrics import accuracy_score, roc_auc_score, roc_curve, auc
from sklearn.linear_model import LogisticRegression


def get_roc_auc(estimator, y_test, X_test):
    probs = estimator.predict_proba(X_test)
    preds = probs[:,1]
    fpr, tpr, threshold = roc_curve(y_test, preds)
    roc_auc = auc(fpr, tpr)
    plt.figure(figsize=(8,5)) 
    plt.title('Receiver Operating Characteristic',fontsize=18)
    plt.plot(fpr, tpr, 'b', label = 'AUC = %f' % roc_auc,color='darkorange')
    plt.legend(loc = 'lower right',fontsize=14)
    plt.plot([0, 1], [0, 1],linestyle='--')
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    plt.show()
               
               
def corr_plot(data,method='pearson'):
    corr = data.corr(method=method)
    mask = numpy.triu(numpy.ones_like(corr, dtype=numpy.bool))
    f, ax = plt.subplots(figsize=(11, 9))
    cmap = sns.diverging_palette(220, 10, as_cmap=True)
    sns.heatmap(corr, mask=mask, cmap=cmap, vmax=.3, center=0,
            square=True, linewidths=.5, cbar_kws={"shrink": .5})
    plt.title('Correlation plot',fontsize=18)