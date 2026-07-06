# 🛒 Instacart Market Basket Analysis

A complete end-to-end **Data Science** project that analyzes customer purchasing behavior using the **Instacart Market Basket Analysis** dataset. The project combines **SQL** for data engineering and **Python** for exploratory data analysis and machine learning to predict whether a customer will reorder a product.

---

# 📌 Project Objective

The goal of this project is to build a **binary classification model** that predicts whether a customer will reorder a previously purchased product.

**Target Variable**

- `reordered`
  - **1** → Product will be reordered.
  - **0** → Product will not be reordered.

---

# 📂 Dataset

**Dataset Source**

https://www.kaggle.com/competitions/instacart-market-basket-analysis/data

The project uses the following tables:

- orders
- order_products_prior
- order_products_train
- products
- aisles
- departments

Because the complete dataset contains over **32 million rows**, a sampled dataset (~443K rows) was created for local experimentation.

---

# 🛠️ Technologies Used

## Database

- SQL Server 2022 Express
- SQL Views
- Joins
- Aggregations
- Feature Engineering

## Python

- Python 3.x
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- CatBoost
- SciPy
- SQLAlchemy
- PyODBC

---

# 📊 Project Workflow

## 1. SQL Data Engineering

The SQL phase is responsible for preparing the machine learning dataset.

### Tasks

- Database creation
- Data import
- Table relationships
- Business analysis queries
- Feature engineering
- SQL Views

Created engineered features including:

- Total Orders per User
- Average Days Between Orders
- Average Basket Size
- User Reorder Rate
- Product Popularity
- Product Reorder Rate
- Department Reorder Rate
- Aisle Reorder Rate

---

## 2. Exploratory Data Analysis (EDA)

Performed extensive exploratory analysis including:

### Dataset Overview

- Dataset shape
- Data types
- Missing values
- Duplicate check

### Univariate Analysis

- Feature distributions
- Target distribution
- Numerical feature analysis

### Bivariate Analysis

- Numerical Features vs Target
- Categorical Features vs Target
- Correlation Matrix
- Reorder Rate Analysis

### Statistical Analysis

- Chi-Square Test
- Cramér's V
- Correlation Analysis

### Outlier Analysis

- Boxplots
- Business outlier interpretation

---

## 3. Machine Learning

The project uses **CatBoost Classifier** for binary classification.

### Why CatBoost?

- Excellent performance on tabular datasets.
- Handles categorical variables efficiently.
- Captures complex non-linear relationships.
- Requires minimal preprocessing.
- Robust to outliers.
- Suitable for mixed numerical and categorical features.

Hyperparameter tuning is performed to optimize model performance.

---

# 📈 Model Evaluation

The model is evaluated using:

- Accuracy
- Precision
- Recall
- F1-Score
- ROC-AUC
- Confusion Matrix

---

# 📁 Repository Structure

```
Instacart-Market-Basket-Analysis/
│
├── SQL/
│   ├── Database Creation.sql
│   ├── Feature Engineering.sql
│   ├── Business Queries.sql
│
├── notebooks/
│   └── Instacart_Market_Basket_Analysis.ipynb
│
├── data/
│   └── sampled_dataset.csv (optional)
│
├── README.md
└── requirements.txt
```

---

# 📌 Key Features

- End-to-end Data Science workflow
- SQL-based feature engineering
- Comprehensive exploratory data analysis
- Statistical feature analysis
- Business insights
- CatBoost classification model
- Hyperparameter tuning
- Model evaluation

---

# 🚀 Future Improvements

- SHAP Explainability
- Feature Importance Analysis
- Model Comparison (CatBoost vs XGBoost vs Random Forest)
- Cross Validation
- Deployment using Streamlit or Flask

---

# 👤 Author

**Malek Raafat**

Artificial Intelligence Undergraduate

Interested in:

- Data Science
- Machine Learning
- Deep Learning
- Artificial Intelligence

GitHub: *(Add your GitHub profile here)*
LinkedIn: *(Add your LinkedIn profile here if available)*

---

# ⭐ Acknowledgements

This project uses the **Instacart Market Basket Analysis** dataset provided by Instacart through Kaggle.

https://www.kaggle.com/competitions/instacart-market-basket-analysis