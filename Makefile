SHELL := /bin/bash -l

.PHONY: all clean

all: figures/risk_by_job.pdf figures/job_by_income_inter.html

clean:
	rm -rf derived_data/*
	rm -rf figures/*

figures/risk_by_job.pdf: risk_by_job_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript risk_by_job_maker.R

figures/job_by_income_inter.html: job_by_income_inter_maker.R ai-career-threat-index/data/ai-career-threat-index.csv
	Rscript job_by_income_inter_maker.R