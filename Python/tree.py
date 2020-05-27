#%%
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn import tree

challengerDataframe = pd.read_csv("../../datasets/TFT_Challenger_MatchData.csv")
grandMasterDataframe = pd.read_csv("../../datasets/TFT_GrandMaster_MatchData.csv")
masterDataframe = pd.read_csv("../../datasets/TFT_Master_MatchData.csv")

challengerInputs = challengerDataframe.drop(['gameId', 'gameDuration', 'Ranked', 'ingameDuration'], axis='columns')
grandMasterInputs = grandMasterDataframe.drop(['gameId', 'gameDuration', 'Ranked', 'ingameDuration'], axis='columns')
masterInputs = masterDataframe.drop(['gameId', 'gameDuration', 'Ranked', 'ingameDuration'], axis='columns')

challengerTarget = challengerDataframe['Ranked']
grandMasterTarget = grandMasterDataframe['Ranked']
masterTarget = masterDataframe['Ranked']

labelCombination = LabelEncoder()
labelChampion = LabelEncoder()

challengerInputs['combination'] = labelCombination.fit_transform(challengerInputs['combination'])
challengerInputs['champion'] = labelChampion.fit_transform(challengerInputs['champion'])

grandMasterInputs['combination'] = labelCombination.fit_transform(grandMasterInputs['combination'])
grandMasterInputs['champion'] = labelChampion.fit_transform(grandMasterInputs['champion'])

masterInputs['combination'] = labelCombination.fit_transform(masterInputs['combination'])
masterInputs['champion'] = labelChampion.fit_transform(masterInputs['champion'])

#challenger training
model = tree.DecisionTreeClassifier()
model.fit(challengerInputs, challengerTarget)

print("Challenger score = ", model.score(challengerInputs, challengerTarget))
print("Grand Master score = ", model.score(grandMasterInputs, grandMasterTarget))
print("Master score = ", model.score(masterInputs, masterTarget))
print()

#grandMaster training
model = tree.DecisionTreeClassifier()
model.fit(grandMasterInputs, grandMasterTarget)

print("Challenger score = ", model.score(challengerInputs, challengerTarget))
print("Grand Master score = ", model.score(grandMasterInputs, grandMasterTarget))
print("Master score = ", model.score(masterInputs, masterTarget))
print()

#master training
model = tree.DecisionTreeClassifier()
model.fit(masterInputs, masterTarget)

print("Challenger score = ", model.score(challengerInputs, challengerTarget))
print("Grand Master score = ", model.score(grandMasterInputs, grandMasterTarget))
print("Master score = ", model.score(masterInputs, masterTarget))


# %%
