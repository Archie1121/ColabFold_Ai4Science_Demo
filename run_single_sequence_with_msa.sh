#!/bin/bash
# ==========================================
# ColabFold 离线预测脚本
# ==========================================


# 设置路径
FASTA_FILE="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/results_single/protein_msa.fasta"
OUTPUT_DIR="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/results_single/output_msa"
MODELS_DIR="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases/params"
MSA_FILE="/home/u2024170925/Ai4Science-Demo/ColabFold_demo/results_single/query1_fixed.a3m"

# 创建输出目录（如果不存在）
mkdir -p "$OUTPUT_DIR"

# 调用 ColabFold 运行
python - <<EOF
from pathlib import Path
from colabfold.batch import run

with open("$FASTA_FILE") as f:
    sequence = f.read().splitlines()[1]

queries = [("query1", sequence, "$MSA_FILE")]  # 3 元组

run(
    queries=queries,
    result_dir=Path("$OUTPUT_DIR"),
    num_models=1,
    is_complex=False,
    model_type="auto",
    data_dir=Path("$MODELS_DIR")
)
EOF

echo "✅ 离线预测完成，结果保存在 $OUTPUT_DIR"
