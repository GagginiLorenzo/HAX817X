# HAX817X : Projets M1 
- Sujet : L'importance des variables dans les environnements à haute dimension nécessite une regroupement. (Ahmad Chamma, Bertrand Thirion, Denis Engemann)
- Par : Lorenzo Gaggini, Zakaria KHODRI.
- Encadré par : Joseph Salmon.

## Plan du travail :
- Introduction et mise en contexte: 
- Formulation de la problématique
- Explication de la méthode de BCPI (Block-Based Conditional Permutation Importance :
  - Partie Mathématique.
  - Partie technique/Algorithmique 
- Exemples d'application et simulations des résultats obtenus.
- Benchmarking des trois variantes de la méthode BCPI : 
  - BPI-DNN
  - BCPI-DNN
  - BCPI-RF

- avec d'autre méthodes :
   - Marginal effects
   - Leave-One-Group-In
   - Leave-One-Group-Out
   - Group Only Permutation Feature Importance
   - Group Permutation Feature Importance

- Résultats et Conclusion.
- -----
## Interpretable Machine learning :
- Understanding the outcome of a prediction is crucial : we do not only care about the outcome of a prediction but we should also why the prediction was made. it can help us understand more about the problem in especially in high risk environment.
- Why do we need interpretability ? : 
    - Human curiosity and learning
    - Gain more knowledge in different fields of science.
    - Ensure safety measures and testing in real-world task models.
    - Detecting biases in machine-learning models.
    - Manage social acceptance of machine-learning and AI.
    - Debugging of ML models.
- We have two ways of looking at interpretabilty : 
  - Interpretable methods : The easiest way to achieve interpretability is to use only a subset of algorithms that create interpretable models. Linear regression, logistic regression and the decision tree are commonly used interpretable models whichoften has the big disadvantage that predictive performance is lost compared to other machine learning models and you limit yourself to one type of model.
  
  - Model agnostic methods : where we separate the explanation from the machine learning model and it's structure ( treating the model as a black box), we get to make explanations by by perturbing and mutating (eg. Deleting or permuting )the input data and obtaining the sensitivity of performance of these mutations with respect to the original data performance.
- Model agnostic methods has two types : 
  - Global Model-Agnostic Methods : Global methods describe the average behavior of a machine learning model and they are are often expressed as expected values based on the distribution of the data.
  - Local Model-Agnostic Methods : Local interpretation methods explain individual predictions.
- In our case we'll dive deep in the Global model-agnostic Methods :
  - Marginal effects : effect one of a feature have on the predicted outcome of a machine learning model.
  - LOCO (leave one co-variate out) : removing variable of interest then refit the model to calculate the LOCO importance which is difference between the error after removing the variable of interest and the error in presence of all features. 
  - Permutation Feature importance : Permutation feature importance measures the increase in the prediction error of the model after we permuted the feature’s values, which breaks the relationship between the feature and the true outcome.
- These methods show misleading results in presence of high correlation between variables.
- Group based analysis can offer a remedy to this problem simply by grouping variables either by: knowledge driven grouping or data driven grouping.
  - LOGO (leave one group out): (similar to LOCO) removing a group of features then refit the learner, it provides the contribution of a group in the presence of other groups.
  - LOGI (leave one group in ): (similar to marginal effects) : it evaluates the contribution of one group of features only.
  - GPFI (Group Permutation Feature Importance): joint permutation of all features in the group in the presence of other groups too.
  - GOPFI (Group Only Permutation Feature Importance): joint permutation of all features except the group in interest : measure the contribution of groups in model's performance.
---
Resources : 
- https://christophm.github.io/interpretable-ml-book/
- https://slds-lmu.github.io/iml_methods_limitations/
- Grouped Feature Importance and Combined Features,Effect Plot,Quay Au*,· Julia Herbinger*· Clemens Stachl · Bernd Bischl · Giuseppe Casalicchio.
- Model-Agnostic Interpretability of Machine Learning, Marco Tulio, Ribeiro Sameer, Singh,Carlos Guestrin.
- Conditional variable importance for random forests
Carolin Strobl, Anne-Laure Boulesteix, Thomas Kneib, Thomas Augustin
and Achim Zeileis.