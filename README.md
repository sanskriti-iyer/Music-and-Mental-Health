# Music and Mental Health Survey Analysis

## Overview

This project analyzes survey data on music listening habits and their relationship
to mental health outcomes including anxiety, depression, insomnia, and OCD. The
dataset contains 736 respondents and covers streaming behavior, genre preferences,
listening frequency, and self-reported mental health scores.

---

## Dataset

**Source file:** mxmh_survey_results.csv
**Rows:** 736

**Key columns:**
- Demographics: Age
- Listening behavior: Hours per day, While working, BPM, Fav genre, Frequency [Genre] columns for 16 genres
- Music behavior: Exploratory, Foreign languages, Instrumentalist, Composer
- Mental health scores (0-10): Anxiety, Depression, Insomnia, OCD
- Outcome: Music effects (Improve / 0 effect / Worsen)

---

## Data Preprocessing

### Missing Values

| Column         | Missing Count | Treatment                        |
|----------------|---------------|----------------------------------|
| BPM            | 107           | Genre-based median imputation    |
| Music effects  | 8             | Kept as-is, dropped per analysis |
| All others     | 0-4           | Dropped per analysis as needed   |

**BPM imputation rationale:** BPM represents the tempo of music respondents listen
to. Since genre is a strong predictor of tempo, missing BPM values were imputed
using the median BPM of each respondent's Fav genre. A global median fallback was
included for genres with no non-null BPM values, though none were needed in practice.

---

## Analysis

### Normality Testing

D'Agostino-Pearson test was applied to all four mental health variables. All four
were non-normal (p < 0.05), which determined the use of non-parametric tests
throughout.

| Variable   | Statistic | p-value  |
|------------|-----------|----------|
| Anxiety    | 71.21     | 3.44e-16 |
| Depression | 350.96    | 6.16e-77 |
| OCD        | 83.50     | 7.37e-19 |
| Insomnia   | 192.21    | 1.83e-42 |

---

### Question 1: Correlation Between Mental Health Disorders

**Method:** Spearman correlation matrix

**Finding:** All four disorders show positive correlations with each other.
Depression has the strongest relationship with insomnia among the pairs.

---

### Question 2: Is BPM Related to Insomnia?

**Method:** Spearman correlation
**Result:** Spearman r = 0.072, p = 0.0495

**Finding:** Statistically significant but the effect size is negligible. A
correlation of 0.072 explains less than 1% of variance in insomnia scores. The
significance is likely a function of sample size, not a meaningful relationship.

---

### Question 3: Does Age Correlate with Mental Health Scores?

**Method:** Spearman correlation for each disorder

| Disorder   | r      | p-value | Significant |
|------------|--------|---------|-------------|
| Anxiety    | -0.069 | 0.0600  | No          |
| Depression | 0.009  | 0.8090  | No          |
| Insomnia   | 0.022  | 0.5589  | No          |
| OCD        | -0.091 | 0.0134  | Yes         |

**Finding:** Age has no meaningful relationship with anxiety, depression, or
insomnia. A weak negative correlation with OCD was statistically significant
but small in magnitude.

---

### Question 4: Anxiety Levels by Music While Working

**Method:** Mann-Whitney U test
**Result:** U = 46468, p = 0.4166

**Finding:** No significant difference in anxiety levels between people who
listen to music while working and those who do not.

---

### Question 5: Music Effects on Mental Health

#### 5.1 Kruskal-Wallis Test

| Outcome    | H-statistic | p-value | Significant |
|------------|-------------|---------|-------------|
| Insomnia   | 1.75        | 0.4174  | No          |
| Depression | 13.40       | 0.0012  | Yes         |

Music effects groups show no significant difference in insomnia scores but
differ significantly in depression scores.

#### 5.2 Post-hoc Analysis for Depression

Dunn's test with Bonferroni correction applied following significant Kruskal-Wallis result.

| Comparison          | p-value | Significant |
|---------------------|---------|-------------|
| 0 effect vs Improve | 0.1904  | No          |
| 0 effect vs Worsen  | 0.0012  | Yes         |
| Improve vs Worsen   | 0.0085  | Yes         |

**Finding:** The Worsen group has significantly different depression scores from
both other groups. The 0 effect and Improve groups do not significantly differ
from each other.

#### 5.3 Average Depression by Genre Engagement

Respondents were grouped by whether they engage with each genre at any frequency
other than Never. Average depression scores were computed per genre.

| Rank | Genre            | Avg Depression |
|------|------------------|----------------|
| 1    | Metal            | 5.28           |
| 2    | EDM              | 5.15           |
| 3    | Rap              | 5.13           |
| 4    | Hip hop          | 5.07           |
| 5    | Folk             | 5.05           |
| 6    | Video game music | 4.99           |
| 7    | R&B              | 4.97           |
| 8    | Lofi             | 4.96           |
| 9    | Rock             | 4.95           |
| 10   | Latin            | 4.92           |
| 11   | K pop            | 4.88           |
| 12   | Jazz             | 4.85           |
| 13   | Pop              | 4.85           |
| 14   | Gospel           | 4.81           |
| 15   | Classical        | 4.78           |
| 16   | Country          | 4.76           |

**Note:** These are observational averages. Genre does not cause depression.
Both are likely influenced by underlying factors not captured in this dataset.

---

### Question 6: Combined Effect of Anxiety, Depression, and OCD on Insomnia

**Method:** Ordinal Logistic Regression (proportional odds model)

**Rationale:** Insomnia is a discrete 0-10 ordinal scale. OLS was not appropriate
given non-normal residuals and the bounded discrete nature of the outcome. Ordinal
logistic regression is the correct model for this data structure.

**Proportional odds assumption:** Verified by fitting binary logistic models at
each of the 9 thresholds. Coefficients were stable across thresholds, confirming
the assumption holds. A slight attenuation of the Depression coefficient at
thresholds 7-9 was observed but not severe enough to invalidate the model.

| Predictor  | Coefficient | Odds Ratio | p-value | Interpretation                                                      |
|------------|-------------|------------|---------|---------------------------------------------------------------------|
| Depression | 0.205       | 1.228      | < 0.001 | Strongest predictor. Each 1-point increase multiplies odds by 1.23 |
| OCD        | 0.094       | 1.098      | < 0.001 | Modest but consistent effect                                        |
| Anxiety    | 0.058       | 1.060      | 0.050   | Borderline significant. Confidence interval touches zero            |

**Model fit:**

| Metric         | Ordinal Logistic | OLS (prior) |
|----------------|------------------|-------------|
| AIC            | 3266             | 3616        |
| Log-Likelihood | -1620.0          | -1804.2     |

The ordinal model is a meaningful improvement over OLS and is the appropriate
choice for this outcome variable.

---

### Question 7: Behavioral Clustering by Mental Health Profile

**Method:** K-Means clustering (k=3) on standardized Anxiety, Depression,
Insomnia, and OCD scores

**Cluster average hours per day:**

| Cluster | Avg Hours/Day |
|---------|---------------|
| 0       | 3.36          |
| 1       | 3.21          |
| 2       | 4.12          |

Cluster 2 listens to notably more music per day. Rock and Pop dominate across
all three clusters, reflecting the overall genre distribution in the dataset
rather than cluster-specific preference.

**Music effects by cluster:**

| Cluster | 0 Effect | Improve | Worsen |
|---------|----------|---------|--------|
| 0       | 53       | 181     | 5      |
| 1       | 69       | 168     | 2      |
| 2       | 47       | 193     | 10     |

The majority of respondents across all clusters perceive music as improving
their mental health.

---

## Dependencies

```
pandas
numpy
scipy
matplotlib
seaborn
scikit-learn
statsmodels
scikit-posthocs
```

Install with:

```
pip install pandas numpy scipy matplotlib seaborn scikit-learn statsmodels scikit-posthocs
```

---

## Limitations

- Self-reported data is subject to response bias
- Cross-sectional design means no causal claims can be made
- BPM imputation for 107 rows introduces noise into any BPM-related analyses
- Anxiety in the ordinal regression is borderline significant and should not be treated as a robust finding
- Cluster labels are arbitrary and the three-cluster solution was not validated against alternative values of k
- Genre engagement averages in Question 5.3 are descriptive only and carry no inferential weight
