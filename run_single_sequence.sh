#!/bin/bash
# run_single_sequence_offline.sh
set -e

FASTA_FILE="results_single/protein.fasta"
OUTPUT_DIR="results_single/output"
DB_FILE="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases/uniref50.fasta"
MODELS_DIR="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases/params"

mkdir -p "$OUTPUT_DIR"

python - <<'END'
from pathlib import Path
from colabfold.batch import run

fasta_file = Path("results_single/protein.fasta")
output_dir = Path("results_single/output")
models_dir = Path("/home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases/params")

# 读取FASTA
with open(fasta_file) as f:
    lines = f.read().splitlines()
sequence = lines[1].strip()

queries = [("query1", sequence, None)]

# 运行完整预测流程
run(
    queries=queries,
    result_dir=output_dir,
    num_models=1,
    is_complex=False,
    use_gpu=False,             # CPU 模式
    models_dir=models_dir,     # 模型路径
    num_recycle=3,
    msa_mode="single_sequence",
    model_type="AlphaFold2-ptm"  # 显式使用 PTM 模型
)
END

echo "✅ 预测完成，结果保存在 $OUTPUT_DIR"
