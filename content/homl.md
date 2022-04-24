
---
---

# Hands on Machine learning with R

> **During my master in Statistics and Operation Research (graduated: 2015)**,
> I had some classes with the approach to some supervised and unsupervised
> machine learning (Multivariante Analysis class and Inferences):
> - Linear regression,
> - Principal components analysis (PCA)
> - Clustering (KNN, hierarchical)
> - Multidimensional Scaling
> - Correspondance analysis.
> - Among others.
>
> From the day I started write this blog I have applied for
> few occassion. Therefore, I decided to read and practice with the book
> [HOML](https://bradleyboehmke.github.io/HOML/) so I can have a stronger knowledge
> on machine learning.
>
> \***Below, you can find some quotes from the book which is very important to me, and
> some notes that I included.**

The two main groups this book focuses on are: supervised learners which construct

predictive models, and unsupervised learners which build descriptive models

## Supervised learning
A predictive model is used for tasks that involve the prediction of a given
output (or target) using other variables (or features) in the data set.

Examples:
 - using customer attributes to predict the probability of the customer churning in the next 6 weeks;
 - using home attributes to predict the sales price;
 - using employee attributes to predict the likelihood of attrition;
 - using patient attributes and symptoms to predict the risk of readmission;
 - using production attributes to predict time to market.

When the objective of our supervised learning is to predict a numeric outcome,
we refer to this as a **regression problem**.

When the objective of our supervised learning is to predict a categorical outcome,
we refer to this as a **classification problem**.

## Unsupervised learning
Unsupervised learning, in contrast to supervised learning, includes a set of
statistical tools to better understand and describe your data, but performs the
analysis without a target variable. **In essence, unsupervised learning is concerned
with identifying groups in a data set. The groups may be defined by the rows
(i.e., clustering) or the columns (i.e., dimension reduction); however, the
motive in each case is quite different.**

## Data splitting
A major goal of the machine learning process is to find an algorithm
_f_(**X**) that most accurately predicts future values (^Y) based on a set of features
(**X**). In other words, we want an algorithm that not only fits well to our past
data, but more importantly, one that predicts a future outcome accurately.
This is called the **generalizability** of our algorithm. How we “spend” our data
will help us understand how well our algorithm generalizes to unseen data

 - Spending too much in training (e.g.,  >80% ) won’t allow us to get a good
   assessment of predictive performance. We may find a model that fits the
   training data very well, but is not generalizable (overfitting).
 - Sometimes too much spent in testing ( >40% ) won’t allow us to get a good
   assessment of model parameters.

Other factors should also influence the allocation proportions. For example,
very large training sets (e.g.,  n>100K ) often result in only marginal gains
compared to smaller sample sizes. Consequently, you may use a smaller training
sample to increase computation speed (e.g., models built on larger training
sets often take longer to score new data sets in production). In contrast, as
p≥n  (where p represents the number of features), larger samples sizes are often
required to identify consistent signals in the features.

The two most common ways of splitting data include **simple random sampling** and
**stratified sampling.**



## Simple random sampling

```r
# Using base R
set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(ames), round(nrow(ames) * 0.7))
train_1 <- ames[index_1, ]
test_1  <- ames[-index_1, ]

# Using caret package
set.seed(123)  # for reproducibility
index_2 <- createDataPartition(ames$Sale_Price, p = 0.7,
                               list = FALSE)
train_2 <- ames[index_2, ]
test_2  <- ames[-index_2, ]

# Using rsample package
set.seed(123)  # for reproducibility
split_1  <- initial_split(ames, prop = 0.7)
train_3  <- training(split_1)
test_3   <- testing(split_1)

# Using h2o package
split_2 <- h2o.splitFrame(ames.h2o, ratios = 0.7,
                          seed = 123)
train_4 <- split_2[[1]]
test_4  <- split_2[[2]]
```

### Stratified sampling
**If we want to explicitly control the sampling so that our training and test sets
have similar _Y_  distributions**, we can use stratified sampling. This is _more
common with classification problems_ where the response variable may be severely
imbalanced (e.g., 90% of observations with response “Yes” and 10% with response
“No”).
However, we can also apply stratified sampling to regression problems for data
sets that have a small sample size and where the response variable deviates
strongly from normality (i.e., positively skewed like Sale\_Price). With a
continuous response variable, stratified sampling will segment
Y into quantiles and randomly sample from each. Consequently, this will help
ensure a balanced representation of the response distribution in both the
training and test sets
