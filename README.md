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
ColabFold_demo/
├── results_single/
│   ├── protein.fasta
│   └── output/
│       ├── query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000.pdb
│       └── query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_predicted_aligned_error_v1.json
├── visualization/
│   ├── query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_pdb.png
│   └── query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_pae.png
├── run_single_sequence.sh
├── run_single_sequence_with_msa.sh
└── colabfold_visualization.ipynb
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

