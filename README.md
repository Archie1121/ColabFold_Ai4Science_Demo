# 🧪 ColabFold Demo: 蛋白质结构预测与可视化

> 一个完整的 **AlphaFold2/ColabFold** 离线预测与可视化流程演示，  
> 支持单序列、MSA 输入，集成 **PDB 3D 结构展示**、**PAE 热图分析** 和 **静态图像导出**。  

---

## 🌍 项目概述
本项目是HFUT深度学习课程的Ai4Science的16组代码部分，成员包括：刘思思，柳霄，王学林，何艺超，刘明鑫，其中代码构建部分由何艺超完成。
本项目基于 **ColabFold**（AlphaFold2 的开源实现）构建了一个轻量级的蛋白质结构预测与可视化工作流，包含：

- ✅ **离线运行脚本**：无需 Google Colab，可在本地或服务器上运行。
- ✅ **完整预测流程**：从 FASTA 输入 → MSA 搜索 → 结构预测 → 结果输出。
- ✅ **交互式 3D 可视化**：使用 `nglview` 在 Jupyter Notebook 中实时查看预测结构。
- ✅ **自动保存 PNG 图像**：生成高质量 PDB 和 PAE 静态图用于报告或论文。

---

## 🧩 功能概览

| 模块 | 功能说明 | 关键技术 |
|------|-----------|-----------|
| [run_single_sequence.sh](file://c:\Users\admin\Desktop\ColabFold_demo\run_single_sequence.sh) | 单序列无 MSA 模式预测 | ColabFold + AlphaFold2-ptm |
| [run_single_sequence_with_msa.sh](file://c:\Users\admin\Desktop\ColabFold_demo\run_single_sequence_with_msa.sh) | 使用预生成 MSA 进行预测 | MMseqs2 / a3m 文件输入 |
| [colabfold_visualization.ipynb](file://c:\Users\admin\Desktop\ColabFold_demo\colabfold_visualization.ipynb) | 结果可视化核心脚本 | nglview, seaborn, matplotlib |

---

## ⚙️ 安装与环境配置

### 1. 依赖安装（推荐使用 Conda）

```bash
# 创建虚拟环境
conda create -n colabfold python=3.9
conda activate colabfold

# 安装关键包
pip install colabfold nglview matplotlib seaborn numpy jupyterlab
```

### 2. 下载模型与数据库

```bash
# 下载 ColabFold 所需参数（models）
cd /home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases
wget https://github.com/sokrypton/ColabFold/releases/download/v1.0/params.tar.gz
tar -xzf params.tar.gz

# 下载 UniRef50 数据库（用于 MSA 搜索）
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/UniRef50.fasta.gz
gunzip UniRef50.fasta.gz
```

---

## 🚀 快速上手

### 1️⃣ 准备输入文件

确保以下文件存在：

```
results_single/
├── protein.fasta         # 单个蛋白序列（FASTA 格式）
└── protein_msa.fasta     # 可选：已生成的 MSA（用于更准确预测）
```

示例 `protein.fasta` 内容：

```fasta
>query1
MVLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGKKVADALTNAVA
```

---

### 2️⃣ 运行预测（两种模式）

#### 模式一：仅用单序列（快速但精度较低）

```bash
bash run_single_sequence.sh
```

#### 模式二：使用 MSA（推荐，提升预测准确性）

```bash
bash run_single_sequence_with_msa.sh
```

> ✅ 输出将保存在 `results_single/output/` 目录下，包括：
>
> - `query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000.pdb`
> - `query1_predicted_aligned_error_v1.json`

---

### 3️⃣ 可视化结果（Jupyter Notebook）

启动 Jupyter 并打开 `colabfold_visualization.ipynb`：

```bash
jupyter notebook
colabfold_visualization.ipynb
```
**示例预测如下：**

![可视化示例](https://github.com/Archie1121/ColabFold_Ai4Science_Demo/blob/master/visual.png)
---

## 🧰 项目结构

```
ColabFold_Ai4Science_Demo/
├── ColabFold/                     # 模型及代码依赖子目录
├── databases/                     # 用于 MSA/模型的数据库文件夹
├── results_single/                # 单序列预测结果输入／输出目录
│   ├── output/                    # 输出文件（PDB、PAE、JSON 等）
│   └── …                          # 脚本运行前的输入（如 FASTA／MSA）
├── .gitignore
├── README.md                      # 项目说明文档
├── colabfold_visualization.ipynb  # Jupyter Notebook 可视化脚本
├── run_single_sequence.sh         # 单序列预测脚本
├── run_single_sequence_with_msa.sh# 使用 MSA 的预测脚本
└── visual.png                     # 蛋白质预测图
```

---

## 📜 版权与引用

本项目基于 [ColabFold](https://github.com/sokrypton/ColabFold) 开源框架构建，遵循其 MIT 许可协议。

> 若用于学术发表，请引用原始 AlphaFold 和 ColabFold 文献：
>
> - Jumper et al., *Nature* (2021): "Highly accurate protein structure prediction with AlphaFold"
> - Elnaggar et al., *BioRxiv* (2022): "ColabFold: Fast and accurate protein structure prediction on Colab"

---

## ❤️ 致谢

感谢 [Sokrypton](https://github.com/sokrypton) 提供的 ColabFold 工具链，  
以及 AlphaFold 团队推动结构生物学进入 AI 新时代。

> 如果这个 demo 对你有帮助，请 ⭐ 支持一下！

# 英文版：

当然，这里是与你提供的中文版本**一一对应**、**可直接复制到 GitHub 的英文版 README.md**👇

---

````markdown
# 🧪 ColabFold Demo: Protein Structure Prediction & Visualization

> A complete **AlphaFold2/ColabFold** offline workflow demonstration for protein structure prediction and visualization.  
> Supports both single-sequence and MSA inputs, integrating **3D PDB visualization**, **PAE heatmap analysis**, and **static figure export**.

---

## 🌍 Project Overview
This project is part of the Ai4Science course at HFUT (Hefei University of Technology), developed by **Team 16**: SiSi Liu, Xiao Liu, Xuelin Wang, Yichao He, and Mingxin Liu.  
The code implementation was primarily completed by **Yichao He**.  

This project builds a lightweight workflow for protein structure prediction and visualization based on **ColabFold** (the open-source implementation of AlphaFold2), including:

- ✅ **Offline execution scripts** — run locally or on servers, no Google Colab required.  
- ✅ **Full prediction pipeline** — from FASTA input → MSA search → structure prediction → result output.  
- ✅ **Interactive 3D visualization** — view predicted structures in real time using `nglview` in Jupyter Notebook.  
- ✅ **Automatic PNG export** — generate high-quality PDB and PAE plots for reports or papers.

---

## 🧩 Function Overview

| Module | Description | Core Technologies |
|--------|--------------|-------------------|
| [run_single_sequence.sh](file://c:/Users/admin/Desktop/ColabFold_demo/run_single_sequence.sh) | Predict structure from a single sequence without MSA | ColabFold + AlphaFold2-ptm |
| [run_single_sequence_with_msa.sh](file://c:/Users/admin/Desktop/ColabFold_demo/run_single_sequence_with_msa.sh) | Predict structure using pre-generated MSA | MMseqs2 / A3M input |
| [colabfold_visualization.ipynb](file://c:/Users/admin/Desktop/ColabFold_demo/colabfold_visualization.ipynb) | Core visualization notebook | nglview, seaborn, matplotlib |

---

## ⚙️ Installation & Environment Setup

### 1. Install dependencies (recommended: Conda)

```bash
# Create virtual environment
conda create -n colabfold python=3.9
conda activate colabfold

# Install essential packages
pip install colabfold nglview matplotlib seaborn numpy jupyterlab
````

### 2. Download models and databases

```bash
# Download ColabFold model parameters
cd /home/u2024170925/Ai4Science-Demo/ColabFold_demo/databases
wget https://github.com/sokrypton/ColabFold/releases/download/v1.0/params.tar.gz
tar -xzf params.tar.gz

# Download UniRef50 database (for MSA search)
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/UniRef50.fasta.gz
gunzip UniRef50.fasta.gz
```

---

## 🚀 Quick Start

### 1️⃣ Prepare input files

Ensure the following files exist:

```
results_single/
├── protein.fasta         # Single protein sequence (FASTA format)
└── protein_msa.fasta     # Optional: pre-generated MSA for higher accuracy
```

Example of `protein.fasta`:

```fasta
>query1
MVLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGKKVADALTNAVA
```

---

### 2️⃣ Run Prediction (Two Modes)

#### Mode 1: Single-sequence only (fast but less accurate)

```bash
bash run_single_sequence.sh
```

#### Mode 2: With MSA (recommended for higher accuracy)

```bash
bash run_single_sequence_with_msa.sh
```

> ✅ The output will be saved in the `results_single/output/` directory, including:
>
> * `query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000.pdb`
> * `query1_predicted_aligned_error_v1.json`

---

### 3️⃣ Visualize Results (Jupyter Notebook)

Launch Jupyter and open the visualization notebook:

```bash
jupyter notebook
colabfold_visualization.ipynb
```

**Example prediction:**

![Visualization Example](https://github.com/Archie1121/ColabFold_Ai4Science_Demo/blob/master/visual.png)

---

## 🧰 Project Structure

```
ColabFold_Ai4Science_Demo/
├── ColabFold/                     # Core model and code dependencies
├── databases/                     # Databases for MSA/model parameters
├── results_single/                # Input/output directory for single-sequence predictions
│   ├── output/                    # Output files (PDB, PAE, JSON, etc.)
│   └── …                          # Input files before running (FASTA / MSA)
├── .gitignore
├── README.md                      # Project documentation
├── colabfold_visualization.ipynb  # Jupyter Notebook visualization script
├── run_single_sequence.sh         # Script for single-sequence prediction
├── run_single_sequence_with_msa.sh# Script for MSA-based prediction
└── visual.png                     # Example protein visualization
```

---

## 📜 License & Citation

This project is built upon the open-source framework [ColabFold](https://github.com/sokrypton/ColabFold) under the MIT License.

> If used in academic publications, please cite the following works:
>
> * Jumper et al., *Nature* (2021): "Highly accurate protein structure prediction with AlphaFold"
> * Elnaggar et al., *BioRxiv* (2022): "ColabFold: Fast and accurate protein structure prediction on Colab"

---

## ❤️ Acknowledgments

Special thanks to [Sokrypton](https://github.com/sokrypton) for providing the ColabFold toolkit,
and to the AlphaFold team for advancing structural biology into the AI era.

> If this demo helps you, please ⭐ the project and share your work!

```


