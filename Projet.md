# PROJET HAX817X
- Le but de ce projet est de rédiger un rapport écrit limité à 25 pages  (hors annexe) sur le sujet :  **"Variable Importance in High-Dimensional Settings Requires Grouping"** : **"L'importance des variables dans les environnements à haute
dimension nécessite un regroupement"** par Ahmad Chamma, Bertrand Thirion, Denis Engemann publié en décembre 2023. Ce projet est réalisé par **KHODRI Zakaria et Lorenzo Gaggini** et encadré par **Joseph Salmon**.

## 1- Introduction
Dans ce projet on se retrouve globalement dans le cadre de l'interprétabilité des modèles d'apprentissage automatique supervisé (supervised Machine learning algorithms):

- L’apprentissage automatique supervisé est un ensemble de méthodes que les ordinateurs utilisent pour faire des prédictions ou des décision basés sur des données : où on tient/connaît une variable d'intérêt (réponse) et des plusieurs variables prédictives et on cherche à apprendre à un modèle prédectif la structure des données pour prédire une ou plusieurs valeurs de la variable d'intérêt, **par exemple** : prédire la valeur du prix d'une maison (variable d'intérêt) à partir des variables qui peut expliquer le prix : superficie, eplacement, type de la maison...

L’algorithme d’apprentissage automatique apprend un modèle en estimant les paramètres (comme les poids) ou les structures d’apprentissage (comme les arbres de décision).

L’algorithme est guidé par une fonction de score ou de perte qu'on essaie à minimiser.
Dans l’exemple de la valeur du prix de la maison, on minimise la différence entre le prix estimé de la maison et le prix prévu. Un modèle d’apprentissage automatique entièrement entraîné peut ensuite être utilisé pour faire des prédictions pour de nouvelles instances.

l'un des défis ou des inconvénients d'apprentissage automatique est que l'information sur les données et les décisions prises par les algorithmes sont cachées dans des modèles de plus en plus complexes qui rend l'interprétabilité des décision difficile surtout lorsqu'on s'intéresse sur le performance du modèle.

- Dans la prochaine section on aborde plus sur le sujet et on essaie de répondre à ces question :
  - **C'est quoi l'interprétabilité d'un modèle ?**
  - **Quelle est son importance ?**
  - **Quelle sont les différents types d'interprétabilité ?**
  - **Cadre d'interprétabilité**

## 2- Interpprétabilité
### 2-1- Définition de l'interprétabilité
- Définir **l'interprétabilité** mathématiquement est déficile, une définition non mathématique donnée par Miller[[1](https://arxiv.org/abs/1706.07269)] :  **L’interprétabilité est la mesure dans laquelle un humain peut comprendre la cause d’une décision d'un modèle d'apprentissage automatique**.

Plus un modèle d'apprentissage automatique est interprétable plus est facile à l'être humain de comprendre les résultats de certain décisions ou des prédiction, où on essaie d'extraire des connaissance pertinentes à partir d'un modèle concernant les relatuons contenues dans les données ou apprises par le modèle.

### 2-2- Pourquoi l'interprétabilité ?
Dans la modélisation prédictive, on doit faire un compromis entre la prédiction d'une valuer (on pose la question : **quelle est la valeur** trouvée avec une certaine précision) ou de comprendre **pourquoi** on a trouvé cette valeur.

**Par exemple** : prédire la probabilité qu'un client désabonne (Customer chrun) à l'aide d'un modèle, on peut s'occuper aussi à pourquoi le modèle a donné cette valeur pour mieux comprendre le problème et les données.

Dans certain cas on a pas besion d'explications parce qu'ils sont utilisés dans un environnement à faible risque, ce qui signifie qu'une erreur n'aura pas de conséquences graves (**par exemple : un système de recommandation de films**) ou que la méthode a déja fait l'objet d'études et d'évaluation approfondies et nous faison confiance au résultat du système.

Le besion d'interprétabilité découle d'une icomplétude dans la formalisation des problèmes (Doshi-Velez et Kim 2017)[[2](http://arxiv.org/abs/1702.08608)] : on essaie de controller l'incertitude dans les modèles et réduire le biais de confirmation on comprenant les prédictions et les décision des modèles.

On peut citer plusieurs raisons pour la nécessité de l'interprétabilité :
- **Connaissance scientifique** : Le modèle peut devenir une source des connaissances pour les scientifiques et les chercheurs dans plusieurs disciplines qui appliquent les méthodes quantitatives (biologie, psychologie, sciences sociales... ) qui essaient d'extraire plus d'informations captées par les modèles.

- **La sécurité** : L'interprétation des modèles qui s'appliquent dans la vraie vie assure leurs sécurités surtout dans les environnements qui ont un risque levé, **par exemple:** Imaginons une voiture autonome qui détecte automatiquement les cyclistes grâce à un système d'apprentissage profond. Tu veux être certain à 100 % que l'abstraction que le système a apprise est exempte d'erreurs, car renverser des cyclistes est très grave. Une explication pourrait révéler que la caractéristique d'apprentissage la plus importante est de reconnaître les deux roues d'un vélo, et cette explication t'aide à réfléchir à des cas particuliers comme les vélos avec des sacoches latérales qui couvrent partiellement les roues.

- **Ethique** : l'interprétabilité peut aussi vue comme une bonne utile de débogage pour détecter les biais appris par le modèle par défaut. **par exemple:** discrimination contre une certaine minorité qui a été historiquement privée de ses droits.

- **Acceptation sociale** : Le processus d'intégration des machines et des algorithmes dans notre vie quotidienne nécessite de l'interprétabilité pour accroître l'acceptation sociale. Pour qu'une machine puisse interagir avec nous, elle peut avoir besoin de façonner nos émotions et nos croyances. Les machines doivent nous "persuader" afin qu'elles puissent atteindre leur objectif prévu, et ce processus de persuasion se produit en comprenant le comportement de la machine avec l'interprétabilité.
- **Le débogage et vérification** : l'interprétation est précieuse aussi bien dans la phase de recherche et développement même après le déploiement. Plus tard, lorsqu'un modèle est utilisé en production, des choses peuvent mal tourner. Une interprétation pour une prédiction erronée aide à comprendre la cause de l'erreur.

### 2-3- Les Méthodes d'interprétabilité d'apprentissage automatique
#### 2-3-1- Locale ou globale ?
Une méthode **d'interprétation locale** explique une prédiction individuelle(un résultat) selon un input donné. A contrario lorsque la méthode d'interprétation concerne le fonctionnement global de l'algorithme tous inputs confondus, on dira que **la méthode est globale**.
#### 2-3-2- Modèles spécifique ou modèle agnostique ?
**Interprétation spécifié par un modèle :** cette méthode est limitée à une certaine classe des modèles transparents (régression linéaire, régression logistique, modèle linéaire généralisé,modèle additif généralisé, arbre de décision...) qui donnent des résultats interprétables à certain niveaux de difficulté. L’inconvénient de cette méthode est qu’elle vous lie également à un type de modèle et il sera difficile de passer à un autre modèle.

**Modèle agnostique type d'interprétation :**  est la séparation des explications du modèle en le traitant comme une boite noir *black-box* où on essaie d'extraire post-hoc explications par la perturbation et/ou mutation (**par exemple: permutation et/ou supression**) des valeurs entrées et obtenir une sensibilité du performance par rapport au performance des données originales.
Les aspects souhaitables d’un modèle d’explication agnostique sont (Ribeiro, Singh et Guestrin, 2016)[[3](https://arxiv.org/abs/1602.04938)] :
- **Flexibilité du modèle** :La méthode d'interprétation peut fonctionner avec n'importe quel modèle d'apprentissage automatique, tel que les forêts aléatoires et les réseaux neuronaux profonds.
- **Flexibilité d’explication** : On n'est pas limité à une certaine forme d'explication. Dans certains cas, il peut être utile d'avoir une formule linéaire, dans d'autres cas, un graphique avec l'importance des variables.
- **Flexibilité de la représentation**: Le système d'explication devrait être capable d'utiliser une représentation de variable différente de celle du modèle à expliquer. Pour un classificateur de texte qui utilise des vecteurs d'embedding de mots abstraits, il pourrait être préférable d'utiliser la présence de mots individuels pour l'explication.

Les méthodes d'interprétation indépendantes du modèle peuvent être encore distinguées en méthodes locales et globales. **Les méthodes globales** décrivent comment les caractéristiques affectent la prédiction en moyenne. En revanche, **les méthodes locales** visent à expliquer les prédictions individuelle
- Dans la prochaine section on s'occupera des méthodes modèle-agnostique globales.
## 3 - Méthodes de modèle-agnostique globale :

- Dans ce projet on évoquera que les méthodes modèle agnostique globale dans les prochaines sectionns.
## 4- Application des méthodes de modèle agnostique globale sur les groupes des variables :
### 4-1- Préparation des données :
### 4-2- Apllication des méthodes Permutation :
###