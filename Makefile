SHELL := /bin/bash -l

.PHONY: all clean

all: derived_data/clustered_data.csv \
derived_data/cluster_profiles_data.csv \
derived_data/trajectory_data.csv \
derived_data/score_changes_data.csv \
derived_data/income_plot_data.csv \
derived_data/income_model_data.csv \
figures/risk_by_job.pdf \
figures/job_by_income_inter.rds \
figures/clustered_by_subscores.rds \
figures/automation_by_adoption.rds \
figures/displacement_trajectory.rds \
figures/displacement_score_changes.png \
figures/subscores_by_income_model.png

clean:
	rm -rf derived_data/*
	rm -rf figures/*

derived_data:
	mkdir -p $@

figures:
	mkdir -p $@

derived_data/clustered_data.csv: clustered_data_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript clustered_data_maker.R
	
derived_data/cluster_profiles_data.csv: cluster_profiles_data_maker.R derived_data/clustered_data.csv
	Rscript cluster_profiles_data_maker.R

derived_data/trajectory_data.csv: trajectory_data_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript trajectory_data_maker.R

derived_data/score_changes_data.csv: score_changes_data_maker.R derived_data/trajectory_data.csv
	Rscript score_changes_data_maker.R

derived_data/income_plot_data.csv: income_plot_data_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript income_plot_data_maker.R

derived_data/income_model_data.csv: income_model_data_maker.R income_plot_data_maker.R
	Rscript income_model_data_maker.R

figures/risk_by_job.pdf: risk_by_job_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript risk_by_job_maker.R

figures/job_by_income_inter.rds: job_by_income_inter_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript job_by_income_inter_maker.R

figures/clustered_by_subscores.rds: clustered_subscores_maker.R derived_data/clustered_data.csv
	Rscript clustered_subscores_maker.R

figures/automation_by_adoption.rds: automation_by_adoption_inter_maker.R derived_data/clustered_data.csv
	Rscript automation_by_adoption_inter_maker.R

figures/displacement_trajectory.rds: displacement_trajectory_maker.R derived_data/trajectory_data.csv
	Rscript displacement_trajectory_maker.R

figures/displacement_score_changes.png: displacement_score_changes_maker.R derived_data/score_changes_data.csv
	Rscript displacement_score_changes_maker.R

figures/subscores_by_income_model.png: subscores_by_income_model_maker.R derived_data/income_plot_data.csv derived_data/income_model_data.csv
	Rscript subscores_by_income_model_maker.R