from datetime import datetime
from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.standard.operators.bash import BashOperator

DBT = "/opt/airflow/dbt_venv/bin/dbt"
DBT_PROJECT = "/opt/airflow/dbt/zomato"

COPY_RAW = [
    "USE WAREHOUSE ZOMATO_WH",
    "COPY INTO ZOMATO.RAW.resturents   FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/resturents/  ON_ERROR='CONTINUE'",
    "COPY INTO ZOMATO.RAW.users        FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/users/        ON_ERROR='CONTINUE'",
    "COPY INTO ZOMATO.RAW.foods        FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/foods/         ON_ERROR='CONTINUE'",
    "COPY INTO ZOMATO.RAW.manus        FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/manus/         ON_ERROR='CONTINUE'",
    "COPY INTO ZOMATO.RAW.orders       FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/orders/",
    "COPY INTO ZOMATO.RAW.order_items  FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/order_items/",
    "COPY INTO ZOMATO.RAW.reviews      FROM @ZOMATO.RAW.ZOMATO_RAW_STAGE/reviews/",
]

with DAG(
    dag_id="zomato_batch",
    start_date=datetime(2024, 1, 1),
    schedule="@daily",
    catchup=False,
    tags=["zomato", "batch", "dbt"],
    doc_md=__doc__,
) as dag:
    
    reload_raw = SQLExecuteQueryOperator(
        task_id="reload_raw", 
        conn_id="snowflake_default",
        sql=COPY_RAW, 
        split_statements=True, 
        autocommit=True,
    )

    dbt_build_code = BashOperator(
        task_id="dbt_build_code",
        bash_command=f"{DBT} build --project-dir {DBT_PROJECT} --profiles-dir {DBT_PROJECT}",
    )

    
    reload_raw >> dbt_build_code
    