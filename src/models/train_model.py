import sys,os
sys.path.append(os.getcwd())
import joblib
import pandas as pd
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV

from config import final_model_name

import src.features.feature_pipe as features
import src.models.models as ml_models
import src.models as models
from src.utils import utils
from src.visualization import explainability, model_evaluation


model_type = 'regression'

datapath = 'data\processed\listings_with_address.csv'
columns = ['rooms', 'garages', 'useful_area', 'value', 'interior_quality', 'bairro']
df = pd.read_csv(datapath)[columns]
target = 'value'
X, y = df.drop(columns=target), df[target]

feature_pipe, feature_grid = features.features_pipeline()

model, param_grid = ml_models.LinearRegression()

pipeline = feature_pipe
pipeline.extend([("model", model)])
#boruta_selector = BorutaPy(model_, n_estimators='auto', verbose=2, random_state=1)
pipeline = Pipeline(pipeline)
#pipeline.fit(X, y)
#breakpoint()
cv_result = GridSearchCV(pipeline, feature_grid, cv=5)
cv_result.fit(X, y)

explainability.feature_importance(model='LinearRegression', cv_result=cv_result)
predict = cv_result.predict(X)
model_evaluation.evaluate_model(model_type=model_type, y_true=y, y_pred=predict)

# Save Model

joblib.dump(cv_result, f'models\{final_model_name}.pickle')