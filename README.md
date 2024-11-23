
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

### Rule of Thumb

1. **Non-covering clustered index** should give better performance for a multipoint query than a **Non-covering Non-clustered index**.

### Distributions:
- **Fractal Distribution**: Using the same dataset from Question 1.
- **Uniform Distribution**: Run `gen_uniform_distr.py` to create `uniform_trades.csv`.

Run thumb1.sql to get these results for Rule of Thumb1 in MySQL
| Index Type                     | Uniform Distribution (seconds) | Fractal Distribution (seconds) | Difference |
|--------------------------------|---------------------------------|---------------------------------|------------|
| Non-Covering Clustered Index   | 7.047                           | 7.156                           |            |
| Non-Covering Non-Clustered Index | 8.641                         | 8.656                           |            |
| Difference                     | 1.594                           | 1.500                           |            |

Here are the screenshots of running locally (times are in the bottom)
Clustered
![MySQL_Clustered](https://github.com/user-attachments/assets/294d437e-064b-494f-80ab-9573e1af7a10)
Non Clustered
![MySQL_NonClustered](https://github.com/user-attachments/assets/8db3311a-c722-47b5-b393-c96216eb5f64)

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
