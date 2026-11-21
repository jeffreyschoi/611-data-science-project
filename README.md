# AI Career Threat Index Analysis
## Bios 611 Final Project
## Overview

We analyze the AI Career Threat Index, which scores 300 US professions on AI displacement risk from 0 - 100, located in:

`ai-career-threat-index/data/ai-career-threat-index.csv`. 

Every score is a weighted sum of four published sub-scores with written rationales:

| Sub-score | Question it answers |
|---|---|
| `taskAutomation` | What share of the role's core work could AI do end-to-end today, at more than 90% reliability? |
| `toolMaturity` | How mature and deployed are the AI tools targeting those tasks? |
| `adoption` | What share of employers actually use AI for those tasks in production? |
| `agenticExposure` | What share of the role could autonomous multi-step agents own -- not copilots, agents? |

where the score is computed as

```
score = taskAutomation * (0.45 + 0.30 * toolMaturity / 100 + 0.25 * adoption / 100) + 0.10 * agenticExposure
```


While working on the project, we became a bit suspicious on the cleanliness and perfection of the data. After looking through the data source, we found out the data was AI generated. Regardless, we continued on with the project, considering that data is not empirical evidence of actual job displacement or labor-market changes. We sort of take an adversarial stance on the validity of the data in our analysis as a result. 

A final report on our analysis is found in `final_report.pdf`.

### Variables

The dataset includes several measures used throughout this analysis:

| Variable | Description |
|---|---|
| `title` | Occupation title |
| `category` | Occupational category |
| `score` | Overall AI-related occupational risk score |
| `salary_low_usd` | Lower end of the reported salary range |
| `sub_task_automation` | Subscore measuring potential task automation |
| `sub_tool_maturity` | Subscore measuring the maturity of AI tools relevant to the occupation |
| `sub_adoption` | Subscore measuring AI adoption |
| `sub_agentic_exposure` | Subscore measuring exposure to agentic AI systems |
| `score_q1_2025` | Risk score for Q1 2025 |
| `score_q3_2025` | Risk score for Q3 2025 |
| `score_q1_2026` | Risk score for Q1 2026 |
| `score_q2_2026` | Risk score for Q2 2026 |
| `score_q3_2026` | Risk score for Q3 2026 |

---

## Project Structure

```text
611-data-science-project/
|
|-- Dockerfile
|-- Makefile
|-- README.md
|
|-- ai-career-threat-index/
|   |-- data/
|       |-- ai-career-threat-index.csv
|
|-- derived_data/
|   |-- clustered_data.csv
|   |-- cluster_profiles_data.csv
|   |-- trajectory_data.csv
|   |-- score_changes_data.csv
|   |-- income_plot_data.csv
|   |-- income_model_data.csv
|
|-- figures/
|   |-- risk_by_job.pdf
|   |-- job_by_income_inter.html
|   |-- clustered_by_subscores.html
|   |-- automation_by_adoption.html
|   |-- displacement_trajectory.html
|   |-- displacement_score_changes.pdf
|   |-- subscores_by_income_model.pdf
|
|-- *_maker.R
```

The `*_maker.R` scripts are responsible for creating the intermediate datasets and visualizations. The `Makefile` manages the order in which these scripts are executed. The `derived_data/` directory contains datasets created during the analysis. The `figures/` directory contains the final visualizations.

# How to use the repo

## 1. Clone the repository

Open terminal and clone the repository:

```bash
git clone https://github.com/jeffreyschoi/611-data-science-project.git
```

Navigate into the project directory:

```bash
cd 611-data-science-project
```

All subsequent commands should be run from the root of this project directory.

## 2. Build the Docker image

The Dockerfile specifies the environment used for this project. It is based on `amoselb/rstudio-m1` and installs the required R packages.

Build the Docker image by running:

```bash
docker build . -t 611-data-science-project
```

## 3. Start the Docker container

After building the image, start a container using the following command.

```bash
docker run \
-p 8787:8787 \
--rm -v "$PWD":/home/rstudio/work \
-w /home/rstudio/work \
-e PASSWORD=yourpassword \
-it 611-data-science-project
```

Replace `yourpassword` with a password of your choice.

## 4. Open RStudio in your browser

Once the container is running, open your web browser and navigate to:

http://localhost:8787

Log in using the following credentials:

- **Username:** `rstudio`
- **Password:** The password you specified in the Docker command.

## 5. Navigate to the project directory

Inside RStudio, run the following in the Console tab:

```bash
setwd("~/work")
```

Next, open the Terminal tab (next to the Console tab) and run

```bash
cd work
```

To confirm that you are in the project directory, run:

```bash
ls
```

You should see the project files, including the `Makefile`, `Dockerfile`, R scripts, and data directory.

## 6. Run the analysis

From the RStudio Terminal, run:

```bash
make
```

This will execute the Makefile and automatically generate all required intermediate datasets and figures.

The generated datasets will be saved in:

```text
derived_data/
```

The generated figures will be saved in:

```text
figures/
```
