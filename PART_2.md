## Part 2 – CI/CD for Analytics Data Model Changes

### How would you envision the ideal CI/CD process to implement changes over time?

In an ideal setup, analytics model changes would be treated the same way as production code changes.

Every change to the data model would start in a feature branch and go through a pull request. This ensures changes are reviewed and discussed before they impact business metrics. Once a pull request is created, automated checks would run to validate the change. After approval, the change would be promoted step by step through environments instead of being deployed directly to production. This reduces risk and makes failures easier to detect and roll back.

This approach is similar to how I have worked with production data pipelines in the past, where structured reviews and controlled deployments helped reduce data issues.

---

### What kind of environments might be involved?

I would use the following environments:

- Local development for quick iteration and testing
- Shared development environment for collaboration with other engineers and analysts
- Staging environment with production-like data and permissions
- Production environment used by dashboards and business users

This separation allows safe testing of changes before they reach end users.

---

### What kind of processes might be involved?

The main processes would include:

- Feature-based development using Git branches
- Mandatory pull requests and code reviews
- Automated validation before merging
- Deployment first to staging and then to production
- Clear communication of changes to analysts when models or metrics are updated

In my previous roles, having clear ownership and review processes helped avoid accidental breaking changes to dashboards.

---

### What kind of tests might be involved?

Automated testing would be a core part of the CI/CD process. This would include:

- dbt compile to catch syntax and dependency issues
- dbt run for impacted models
- dbt tests such as not null, unique, relationships, and accepted values
- Post-deployment checks on data freshness and row counts
- Monitoring key business metrics to detect unexpected changes

From experience, basic integrity and volume checks catch most real-world data issues early.

---

### What kind of tools might be involved?

An example toolset could include:

- GitHub for version control, pull requests, and CI pipelines
- dbt for transformations, testing, and documentation
- Databricks or Spark for compute
- An orchestrator such as Airflow for scheduling and dependencies
- Alerting tools such as Slack or email for failures

This aligns closely with tools I have used when building and maintaining analytics and pricing data products.

---

### How would this differ in the real world where resources are limited?

In real-world scenarios, tooling and time are often limited. In that case, the focus should be on controls that provide the highest reliability with the least complexity. The goal is to prevent incorrect data from reaching users rather than building a perfect system upfront.

---

### Low effort / short-term improvements

- Use a single Git repository with mandatory pull requests
- Run dbt compile, dbt run, and dbt test before merging
- Focus tests on the most important fact tables and metrics
- Ensure pipelines are safe to rerun so data is not duplicated
- Keep dbt documentation up to date for analyst self-service

In previous roles, adding these steps alone significantly reduced production incidents.

---

### High effort / long-term improvements

- Introduce a full staging environment with production-scale data
- Enforce schema contracts and controlled deprecation of columns and metrics
- Add anomaly detection on key KPIs such as revenue and active users
- Implement stronger metric governance for BI tools
- Add data observability tooling for proactive monitoring and alerting

These improvements can be phased in as the business and data usage grow.

---

### Relevant experience from the past

In my previous work building pricing and analytics data products using Spark, SQL, and Python, orchestrated with Airflow, we improved reliability by adding rerun-safe logic and validation checks before exposing data to dashboards. Applying the same principles in a dbt-based setup helps keep analytics data trustworthy as the model evolves.
