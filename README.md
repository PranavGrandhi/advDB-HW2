
# Advanced DB - Homework 2 - pvg2018, sc10670

---

## Question 1: Fractal Distribution and Queries

### Steps:
1. **Run `distr.py`**: This generates a `fractal_distribution.txt` file.
2. **Run `gen_data.py`**: This creates the `trades.csv` data file.
3. **Run `queries.py`**:
   - The script reads the `trades.csv` file.
   - Executes 4 queries (`query_a`, `query_b`, `query_c`, `query_d`).
   - Saves the results to:
     - `query_a.csv`
     - `query_b.csv`
     - `query_c.csv`
     - `query_d.csv`
   - Outputs the execution times on the command line.

### Notes:
- The `typescript` file with logs saved in `crunchy1` is provided in `Queries_Q1.zip`.

---

## Question 2: 

### Rule of Thumb1

1. **Non-covering clustered index** should give better performance for a multipoint query than a **Non-covering Non-clustered index**.

### Distributions:
- **Fractal Distribution**: Using the same dataset from Question 1.
- **Uniform Distribution**: Run `gen_uniform_distr.py` to create `uniform_trades.csv`.

Run thumb1.sql to get these results for Rule of Thumb1 in MySQL
| Index Type                     | Uniform Distribution (seconds) | Fractal Distribution (seconds) |
|--------------------------------|---------------------------------|---------------------------------|
| Non-Covering Clustered Index   | 7.047                           | 7.156                           |
| Non-Covering Non-Clustered Index | 8.641                         | 8.656                           |
| Difference                     | 1.594                           | 1.500                           |


Here are the screenshots of running locally (times are in the bottom)
Clustered
![MySQL_Clustered](https://github.com/user-attachments/assets/294d437e-064b-494f-80ab-9573e1af7a10)
Non Clustered
![MySQL_NonClustered](https://github.com/user-attachments/assets/8db3311a-c722-47b5-b393-c96216eb5f64)

I have included codes for Postgres Queries in the Postgres_Thumb1.s file. These queries are supposed to be run on the shell one by one so as to get the result.

| Index Type                     | Planning Time (Uniform, milliseconds) | Execution Time (Uniform, milliseconds) | Total Time (Uniform, seconds) | Planning Time (Fractal, milliseconds) | Execution Time (Fractal, milliseconds) | Total Time (Fractal, seconds) |
|--------------------------------|----------------------------------|-----------------------------------|-------------------------------|----------------------------------|-----------------------------------|-------------------------------|
| Non-Covering Clustered Index   | 10.149                           | 13547.375                             | 13.557524                      | 3.432        | 13503.324                             | 13.506756                        |
| Non-Covering Non-Clustered Index | 19.289                         | 14270.868                             | 14.290157                       | 57.844                             | 14237.571                             | 14.295415                       |
| Difference                     |                            |                         | 0.732633                        |                         |                              | 0.788659                        |

Below are the runs for the Postgres queries on Crunchy:

Uniform Distribution/Clustered

![image](https://github.com/user-attachments/assets/be335ebd-f379-4c6f-b5ed-a8779422cec0)

Fractal Distribution/Clustered

<img width="738" alt="image" src="https://github.com/user-attachments/assets/72d7b2d9-e989-426a-baa6-8e6503493d5e">

Uniform Distribution/Non Clustered

<img width="740" alt="image" src="https://github.com/user-attachments/assets/801780c2-0e08-4d5b-8d31-c6e79116a244">

Fractal Distribution/ Non Clustered

<img width="740" alt="image" src="https://github.com/user-attachments/assets/1abc148e-3aa2-47fc-bc73-6526517295bf">



### Rule of Thumb2

1. **Indexes** are most effective when they have high **selectivity** (i.e., the indexed column contains many unique values).

### Distributions:
- **Uniform Distribution**: Uniformly distributed dataset of size 10 million numbers.
- **Skewed Distribution**: Skewed distribution of data where 70% of the numbers are between 1-5, 20% of the data are between 6-15, and 10% of the data in 16-1000
- Run `gen_Data_thumb2.py` to create `uniform_data_thumb2.csv` and `skewed_data_thumb2.csv`.

Run thumb2.sql to get these results for Rule of Thumb2 in MySQL
| Index Type                     | Uniform Distribution (seconds) | Skewed Distribution (seconds) |
|--------------------------------|---------------------------------|---------------------------------|
| With Indexing                  | 0.360                           | 2.797                           |
| Wihtout Indexing               | 4.875                           | 3.563                           |
| Difference                     | 4.515                           | 0.766                           |

Here are the screenshots of running locally (times are in the bottom)
![MySQL_thumb2](https://github.com/user-attachments/assets/653e4cf7-ec26-46be-9b58-06f91ab767a9)

I have included codes for Postgres Queries in the Postgres_Thumb2.s file. These queries are supposed to be run on the shell one by one so as to get the result.

| Index Type                     | Planning Time (Uniform, milliseconds) | Execution Time (Uniform, milliseconds) | Total Time (Uniform, seconds) | Planning Time (Skewed, milliseconds) | Execution Time (Skewed, milliseconds) | Total Time (Skewed, seconds) |
|--------------------------------|----------------------------------|-----------------------------------|-------------------------------|----------------------------------|-----------------------------------|-------------------------------|
| With Indexing  | 2.438                           | 5648.564                             | 5.651002                      | 1.903        | 19941.123                             | 19.943026                        |
|Without Indexing | 19.289                         |9148.476                            | 9.167762                       | 1.474                            | 22200.418                             | 22.201892                       |
| Difference                     |                            |                         | 3.51676                        |                         |                              | 2.258866                       |

---

## Question 3: Friends and Likes Queries in MySQL

### Steps:
1. Download `friends.csv` and `like.csv` from the course website.
2. Run the `mapping.sql` script:
   - Ensure to update the file locations for `friends.csv` and `like.csv` in the script.
   - The script generates `result.csv` (output location can be modified in the script).
3. Verify Results:
   - Queries were tested locally using MySQL.
   - A screenshot of the query execution is attached.
---![MySQL Query run](https://github.com/user-attachments/assets/f3fd18e6-b05b-4243-a14e-fa0b9929e053)

### Files:
- `Result.zip`: Contains the zipped output result file (`result.csv`).


## Attachments:
- `Queries_Q1.zip`: Contains the typescript file from Question 1.
- `Result.zip`: Contains the output file for Question 3.
