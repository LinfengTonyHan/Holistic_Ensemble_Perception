# -*- coding: utf-8 -*-
"""
@author: Mandy
"""
import numpy as np
import csv
import glob
import os
import math
import re
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from itertools import combinations
import random

def loadData(dataPath, conditionName, meanName, ratingType, timeResolution,printLoaded):
    # load data from csv files
    # this can do individual ratings and mean ratings. Just set flag 'loadMeanIndex'
    # to 0 for individual and 1 for mean ratings
    filenames = sorted(glob.glob(os.path.join(dataPath,'*.csv')))

    # get video numbers
    videoNumList = []
    for filename in filenames:
        videoNumList.append(filename[-(len(timeResolution)+4+3):-(len(timeResolution)+4)])
    videoNumList = sorted(Remove(videoNumList))
    numVideos = len(videoNumList)

    datafile = []
    for video_id in np.arange(numVideos):
        for filename in filenames:
            data_temp =[]
            video_id_tmp = videoNumList[video_id]
            video_num_name = filename[-(len(timeResolution)+4+3):-(len(timeResolution)+4)]
            condition_index = filename.find(conditionName)
            time_index = filename.find(timeResolution)
            type_index = filename.find(ratingType)
            mean_index = filename.find(meanName)
            if video_id_tmp == video_num_name and type_index > 0 and mean_index > 0 and condition_index>0 and time_index>0:
                if printLoaded:
                    print(filename)
                data_temp=pd.read_csv(filename, sep=',',header=None)
                datafile.append(data_temp.values)
    return datafile

def alightMeanRatings(globalNames, variablesToAlign,expNames):
    for expName in expNames:

        # get number of videos
        variablesSelected = []
        for variableName in variablesToAlign:
            if variableName[:len(expName)] == expName:
                variablesSelected.append(variableName)
        numVideos = len(globalNames[variablesSelected[0]])

        # get maximum length
        length_ratings = np.zeros([numVideos,len(variablesSelected)])
        max_length = []
        for video_id in np.arange(numVideos):
            for variable_id, variableName in enumerate(variablesSelected):
                length_ratings[video_id,variable_id] = globalNames[variableName][video_id].shape[0]
            max_length.append(np.amax(length_ratings[video_id,:]))

        # # align ratings
        for video_id in np.arange(numVideos):
            for variable_id, variableName in enumerate(variablesSelected):
                globalNames[variableName][video_id] = alignLength(globalNames[variableName][video_id],max_length[video_id])
        
        #updated length
        for video_id in np.arange(numVideos):
            for variable_id, variableName in enumerate(variablesSelected):
                length_ratings[video_id,variable_id] = globalNames[variableName][video_id].shape[0]
        
    return length_ratings

def concatenateRatings(globalNames, variablesToAlign,crossCondition,ratingType,printLoaded):
    allRatings = []
    for variableName in variablesToAlign:
        type_index = variableName.find(ratingType)
        condition_index = variableName.find(crossCondition)
        if (condition_index>0 and type_index>0):
            print(variableName)
            for videoFile in globalNames[variableName]:
                allRatings.append(videoFile)
    return allRatings

def concatenateMeanRatings(globalNames, variablesToAlign,crossCondition,ratingType,printLoaded):
    allRatings = []
    for variableName in variablesToAlign:
        type_index = variableName.find(ratingType)
        condition_index = variableName.find(crossCondition)
        if (condition_index>0 and type_index>0):
            print(variableName)
            for videoFile in globalNames[variableName]:
                allRatings.append(videoFile)
    return allRatings

def correlationPair(individualData):
    num_videos = len(individualData)
    correlations_clips = []
    correlations_mean= []

    for video_id in np.arange(num_videos):
        print('processing video : '+ str(video_id))
        
        num_subjects = individualData[video_id].shape[1]
        combs = combinations(np.arange(1,num_subjects),2)
        correlation_list = []
        
        for comb in combs:
            data_1 = individualData[video_id][:,comb[0]]
            data_2 = individualData[video_id][:,comb[1]]
            if ~sum(np.isnan(data_1)) and ~sum(np.isnan(data_2)):
                correlation = np.corrcoef(data_1,data_2)[0,1]
                correlation_list.append(correlation)
                
        # get mean and bootstrap stats
        correlations_mean.append(np.tanh(np.nanmean(np.arctanh(correlation_list))))
        correlations_clips.append(correlation_list)
        
    return correlations_clips, correlations_mean

def getRSquared(model, X, y):
    # computer R squared and adjusted R squared for linear regression models
    yhat = model.predict(X)
    SS_Residual = sum((y-yhat)**2)
    SS_Total = sum((y-np.mean(y))**2)
    r_squared = 1 - (float(SS_Residual))/SS_Total
    adjusted_r_squared = 1 - (1-r_squared)*(len(y)-1)/(len(y)-X.shape[1]-1)
    return r_squared, adjusted_r_squared

def Remove(duplicate):
    # remove duplicate trials in a sequence of numbers
    final_list = []
    for num in duplicate:
        if num not in final_list:
            final_list.append(num)
    return final_list

def findAllIndexes(list, target):
    indexes = []
    for index, item in enumerate(list):
        if (item == target) :
            indexes.append(index)
    return indexes

def get_num(x):
    # get the number inside a string of characters
    return int(''.join(ele for ele in x if ele.isdigit()))

def roundDigits(num,n):
    # round a single number to n decimals
    return float(int(num*(10**n)))/(10**n)

def convertInt(listTarget):
    newList = []
    for num in listTarget:
        newList.append(int(num))
    # round a single number to n decimals
    return newList


def collapseList(target_list):
    return [i for l in target_list for i in l]

def str2float_matrix(data_matrix):
    # conver string to float for matrix
    num_row = data_matrix.shape[0]
    num_col = data_matrix.shape[1]
    # print(num_row)
    new_matrix = np.zeros((num_row,num_col),dtype = float)
    for row in np.arange(num_row):
        for col in np.arange(num_col):
            new_matrix[row,col]=float(data_matrix[row,col])
    return new_matrix

def str2float_vector(data_vector):
    # convert string to float for a vector
    num_row = len(data_vector)
    new_array = []
    for row in np.arange(num_row):
        new_array.append(float(data_vector[row]))
    return new_array

def permuation_fisher(data_1,data_2,iteration):
    real_diff = np.tanh(np.nanmean(np.arctanh(data_1))) - np.tanh(np.nanmean(np.arctanh(data_2)))
    fake_diff = []
    n_sample = len(data_1)
    for iter_id in np.arange(iteration):
        group_of_items = set(np.arange(1,n_sample))
        group_1_indexes = random.sample(group_of_items, int(np.round(n_sample/2)))
        group_2_indexes = list(group_of_items - set(group_1_indexes))
        fake_data_1 = np.concatenate((data_1[group_1_indexes], data_2[group_2_indexes]))
        fake_data_2 = np.concatenate((data_1[group_2_indexes], data_2[group_1_indexes]))
        temp_diff = np.abs(np.tanh(np.nanmean(np.arctanh(fake_data_1)))-np.tanh(np.nanmean(np.arctanh(fake_data_2))))
        fake_diff.append(temp_diff)
    p_value = np.sum(fake_diff > np.abs(real_diff))/float(len(fake_diff))
    print(real_diff)
    print(p_value)
    return p_value

def permuation(data_1,data_2,iteration):
    real_diff = np.nanmean(data_1) - np.nanmean(data_2)
    fake_diff = []
    n_sample = len(data_1)
    for iter_id in np.arange(iteration):
        group_of_items = set(np.arange(1,n_sample))
        group_1_indexes = random.sample(group_of_items, int(np.round(n_sample/2)))
        group_2_indexes = list(group_of_items - set(group_1_indexes))
        fake_data_1 = np.concatenate((data_1[group_1_indexes], data_2[group_2_indexes]))
        fake_data_2 = np.concatenate((data_1[group_2_indexes], data_2[group_1_indexes]))
        temp_diff = np.abs(np.nanmean(fake_data_1)-np.nanmean(fake_data_2))
        fake_diff.append(temp_diff)
    p_value = np.sum(fake_diff > np.abs(real_diff))/float(len(fake_diff))
    print(real_diff)
    print(p_value)
    return p_value

def bootstrap_ci(data, reps, low_ci, high_ci):
    # if len(data.shape) > 1:
    #     data = data.reshape(-1)
    n = len(data)
    xb = np.random.choice(data, (n, reps))
    mb = np.nanmean(xb,axis=0)
    mb.sort()
    bootstrapped_ci = np.percentile(mb, [low_ci, high_ci])
    return np.nanmean(mb), bootstrapped_ci[0],bootstrapped_ci[1]
    
def bootstrap_ci_fisher(data, reps, low_ci, high_ci):
    # bootstrap mean and 95% confidence intervals with fisher z transformation
    # this should be used for correlations
    # if len(data.shape) > 1:
    #     data = data.reshape(-1)
    n = len(data)
    xb = np.random.choice(data, (n, reps))
    xb = np.arctanh(xb)
    mb = np.nanmean(xb,axis=0)
    mb = np.tanh(mb)
    mb.sort()
    bootstrapped_ci = np.percentile(mb, [low_ci, high_ci])
    return np.tanh(np.nanmean(np.arctanh(mb))), bootstrapped_ci[0],bootstrapped_ci[1]

def bootstrap_ci_matrix(data, reps, low_ci, high_ci):
    # random permuate columns and calculate mean across axis of 1
    n = data.shape[1] # number of columns
    selected_indexes = np.random.choice(np.arange(n), [n, reps], replace = True)
    selected_mean = np.nanmean(data[:,selected_indexes], axis = 1)
    selected_mean.sort(axis = 1)
    bootstrapped_ci = np.nanpercentile(selected_mean, [low_ci, high_ci],axis = 1)
    return np.nanmean(selected_mean,axis = 1), bootstrapped_ci

def bootstrap_ci_matrix_fisher(data, reps, low_ci, high_ci):
    # random permuate columns and calculate mean across axis of 1
    n = data.shape[1] # number of columns
    selected_indexes = np.random.choice(np.arange(n), [n, reps], replace = True)
    selected_mean = np.tanh(np.nanmean(np.arctanh(data[:,selected_indexes]), axis = 1))
    selected_mean.sort(axis = 1)
    bootstrapped_ci = np.nanpercentile(selected_mean, [low_ci, high_ci],axis = 1)
    return np.nanmean(selected_mean,axis = 1), bootstrapped_ci

def alignLength(data_matrix, max_length):
    # aligh the number of rows between several matrix. 
    # this is for aligning the length of emotion ratings in order to compare them 
    if data_matrix.shape[0] < max_length:
        shape_r = data_matrix.shape[0]
        shape_c = data_matrix.shape[1] 
        temp_matrix = np.zeros([int(max_length - shape_r), int(shape_c)])
        start = shape_r*0.2
        end = roundDigits(max_length*0.2,2)
        steps = np.round((end-start)/0.2)
        temp_matrix[:,0] = np.linspace(start,end,steps)
        temp_matrix[:,1:] = data_matrix[-1,1:]
        data_matrix = np.concatenate((data_matrix,temp_matrix),axis=0)
    return data_matrix


def alignLength_noSeq(data_matrix, max_length):
    # aligh the number of rows between several matrix. 
    # this is for aligning the length of emotion ratings in order to compare them 
    if data_matrix.shape[0] < max_length:
        shape_r = data_matrix.shape[0]
        shape_c = data_matrix.shape[1] 
        temp_matrix = np.zeros([max_length - shape_r, shape_c])
        # start = shape_r*0.2
        # end = roundDigits(max_length*0.2,2)
        # steps = np.round((end-start)/0.2)
        # temp_matrix[:,0] = np.linspace(start,end,steps)
        temp_matrix[:,:] = data_matrix[-1,:]
        data_matrix = np.concatenate((data_matrix,temp_matrix),axis=0)
    return data_matrix
