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
import helperFuncs

def plotBars(globalName,ax,data_to_plot,fisher_z,bar_width,y_label,x_label,tickFont):
    datafiles = []
    for variableName in data_to_plot:
        datafiles.append(globalName[variableName])

    mean_bootstrapped = []
    lower_bootstrapped = []
    upper_bootstrapped = []
    for data in datafiles:
        if fisher_z:
            [mean_temp, lower_temp, higher_temp] = helperFuncs.bootstrap_ci_fisher(data, 10000, 2.5, 97.5)
        else:
            [mean_temp, lower_temp, higher_temp] = helperFuncs.bootstrap_ci(data, 10000, 2.5, 97.5)

        mean_bootstrapped.append(mean_temp)
        lower_bootstrapped.append(lower_temp)
        upper_bootstrapped.append(higher_temp)

    num_variables = len(data_to_plot)
    x_pos = np.arange(num_variables)
    ax.bar(x_pos, mean_bootstrapped, bar_width, yerr = [np.array(mean_bootstrapped) - np.array(lower_bootstrapped),
           np.array(upper_bootstrapped) - np.array(mean_bootstrapped)], align='center', alpha=0.5, ecolor='black', capsize=10)
    ax.set_xticks(x_pos)
    ax.set_ylabel(y_label, fontsize = tickFont)
    ax.set_xticklabels(x_label, fontsize = tickFont)


def plotStyleBegin(axis,fontsize):
	sns.set(color_codes=True)
	sns.set_style("whitegrid",{'axes.spines.right': False,'axes.spines.top': False})
	sns.set_style("ticks",{'xtick.bottom': True,'ytick.left': True})
	axis.yaxis.set_tick_params(labelsize=fontsize)
	axis.xaxis.set_tick_params(labelsize=fontsize)
	axis.grid(False)
	sns.despine()
	return axis

def plotStyleBar(axis,ylabel,fontsize, title, num_variables, xtickLabels, y_range):
	# ax.set_ylabel(xlabel, fontsize = fontsize)
	axis.set_ylabel(ylabel, fontsize = fontsize)
	axis.set_xticks(np.arange(num_variables))
	axis.set_xticklabels(xtickLabels, fontsize = fontsize)
	axis.set_title(title, fontweight="bold", fontsize = fontsize)
	axis.set_ylim([y_range])
	axis.set_xlim([-1,num_variables])

def plotStyleLine(axis,xlabel, ylabel,fontsize, y_range):
	axis.set_xlabel(xlabel, fontsize = fontsize)
	axis.set_ylabel(ylabel, fontsize = fontsize)
	axis.set_ylim(y_range)
