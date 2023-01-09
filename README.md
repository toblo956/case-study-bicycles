# Google Data Analytics Certificate Case Study

## Case study: How does a Bike-share Navigate speedy success?

### Scenario:
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.

### Business Questions:
In order to get good insights into the issue, it is important to start with asking the right business-related questions for the problem at hand. In this case, that means maximizing users with annual membership through converting current casual users and acquiring new customers and incentivizing them to buy the membership.


The three questions investigated in this case study is:

    1. How do annual members and casual riders use Cyclistic bikes differently?
    2. How can we incentivize casual riders and non-users buy Cyclistic annual memberships?
    3. How can Cyclistic use digital media to influence casual riders to become members?

### Data Sources used

The previous 12 months of Cyclistic public [dataset](https://divvy-tripdata.s3.amazonaws.com/index.html). This data only contains one row for each bike ride via the service. It does not contain any personal data. As a consequence, it is not possible to analyze or draw conclusions based on a user-level, but rather a more general level.

### Data cleaning and manipulation

The open source python library [dbt](https://www.getdbt.com/) which is used for data cleaning and data transformation on top of a data warehouse (BigQuery in this case). In this repository, all data tranformation is done and transparent in SQL under the "models" folder.


