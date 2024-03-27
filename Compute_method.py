import sklearn
import pandas as pd 
from sklearn.model_selection import train_test_split 
from sklearn.linear_model import TweedieRegressor
from sklearn.metrics import r2_score

#init data 
data=pd.read_csv("rho_0/1.csv")
x=data.drop('y',axis=1)
y=data['y']
#init group
ngroup = 10
tgroup = 5
nvar = ngroup*tgroup
group_list_test = []
group_list_train = []
score=0
#regression for each group
x_train,x_test, y_train, y_test = train_test_split( 
    x, y, test_size=0.2, random_state=1)
for i in range(0, ngroup*tgroup, tgroup):
    group_list_train.append(x_train.iloc[:, i:i+tgroup])
    group_list_test.append(x_test.iloc[:, i:i+tgroup])

for i in range(0,ngroup):
    #creating train and test sets
    gx_train=group_list_train[i]
    gx_test=group_list_test[i]
    #GML
    model = TweedieRegressor()
    model.fit(gx_train,y_train)
    predictions = model.predict(gx_test)
    score+=model.score(gx_test,y_test)
    coef=model.coef_
    print("GLM détailler du groupe",i,":",coef)
    print("Total du groupe",i,":",sum(coef))
    print("R2 cumule: ",score)
    print("______")
print("")    
print("R2 par variable: ", score/nvar)
