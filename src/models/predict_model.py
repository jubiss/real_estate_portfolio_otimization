import sys,os
sys.path.append(os.getcwd())
import joblib

from config import final_model_name

final_model = joblib.load(f'models/{final_model_name}.pickle')


