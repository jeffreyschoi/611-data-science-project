SHELL := /bin/bash -l

.PHONY: all clean

all: derived_data/clustered_data.csv \
derived_data/cluster_profiles_data.csv \
figures/risk_by_job.pdf \
figures/job_by_income_inter.html \
figures/clustered_by_subscores.html

clean:
	rm -rf derived_data/*
	rm -rf figures/*

derived_data/clustered_data.csv: clustered_data_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript clustered_data_maker.R
	
derived_data/cluster_profiles_data.csv: cluster_profiles_data_maker.R derived_data/clustered_data.csv
	Rscript cluster_profiles_data_maker.R
	
figures/risk_by_job.pdf: risk_by_job_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript risk_by_job_maker.R

figures/job_by_income_inter.html: job_by_income_inter_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript job_by_income_inter_maker.R

figures/clustered_by_subscores.html: clustered_subscores_maker.R derived_data/clustered_data.csv
	Rscript clustered_subscores_maker.R