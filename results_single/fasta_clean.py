input_a3m = "results_single/query1.a3m"
output_a3m = "results_single/query1_clean.a3m"

with open(input_a3m) as f, open(output_a3m, "w") as out:
    for line in f:
        line = line.rstrip()
        if not line or line.startswith("#"):
            continue
        out.write(line + "\n")

print("have done")