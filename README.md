```markdown
# 🧪 ColabFold Demo: 蛋白质结构预测与可视化

> 一个完整的 **AlphaFold2/ColabFold** 离线预测与可视化流程演示，  
> 支持单序列、MSA 输入，集成 **PDB 3D 结构展示**、**PAE 热图分析** 和 **静态图像导出**。  
> 适用于科研教学、蛋白结构初探与 AI4Science 演示场景。

---

## 🌍 项目概述

本项目基于 **ColabFold**（AlphaFold2 的开源实现）构建了一个轻量级的蛋白质结构预测与可视化工作流，包含：

- ✅ **离线运行脚本**：无需 Google Colab，可在本地或服务器上运行。
- ✅ **完整预测流程**：从 FASTA 输入 → MSA 搜索 → 结构预测 → 结果输出。
- ✅ **交互式 3D 可视化**：使用 `nglview` 在 Jupyter Notebook 中实时查看预测结构。
- ✅ **PAE 热图分析**：可视化预测置信度（Predicted Aligned Error），评估结构可靠性。
- ✅ **自动保存 PNG 图像**：生成高质量 PDB 和 PAE 静态图用于报告或论文。

适合：
- 🧫 生物信息学初学者快速上手 AlphaFold；
- 🔬 科研人员进行小规模蛋白结构预测；
- 📊 教学演示 AI 如何预测蛋白质折叠。

---

## 🧩 功能概览

| 模块 | 功能说明 | 关键技术 |
|------|-----------|-----------|
| [run_single_sequence.sh](file://c:\Users\admin\Desktop\ColabFold_demo\run_single_sequence.sh) | 单序列无 MSA 模式预测 | ColabFold + AlphaFold2-ptm |
| [run_single_sequence_with_msa.sh](file://c:\Users\admin\Desktop\ColabFold_demo\run_single_sequence_with_msa.sh) | 使用预生成 MSA 进行预测 | MMseqs2 / a3m 文件输入 |
| [colabfold_visualization.ipynb](file://c:\Users\admin\Desktop\ColabFold_demo\colabfold_visualization.ipynb) | 结果可视化核心脚本 | nglview, seaborn, matplotlib |
| `results_single/output/` | 存储预测结果（PDB, JSON, PAE） | 标准 AlphaFold 输出格式 |
| `visualization/` | 自动生成的图片文件夹 | PNG 图像导出 |

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

> 💡 提示：若无法访问外网，可提前在其他机器下载后拷贝至本地。

---

## 🚀 快速上手

### 1️⃣ 准备输入文件

确保以下文件存在：

```
results_single/
├── protein.fasta          # 单个蛋白序列（FASTA 格式）
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
> - `query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_predicted_aligned_error_v1.json`

---

### 3️⃣ 可视化结果（Jupyter Notebook）

启动 Jupyter 并打开 `colabfold_visualization.ipynb`：

```bash
jupyter notebook
```

运行所有单元格后，你将看到：

- 🌀 **3D 蛋白结构**：以彩色带状图显示 α-螺旋和 β-折叠。
- 🔥 **PAE 热图**：展示残基间预测误差，越亮表示不确定性越高。
- 🖼️ **PNG 图片自动保存**：到 `visualization/` 文件夹中。

---

## 🔎 可视化详解

### 1. PDB 3D 结构展示

使用 `nglview` 实现交互式 3D 渲染：

```python
view = nv.show_file(pdb_file)
view.add_cartoon(color_scheme='residueindex')
display(view)
```

- 🎨 颜色按残基索引渐变，便于观察结构走向。
- 🖱️ 支持旋转、缩放、平移等操作（仅限 Jupyter Notebook）。

### 2. PAE 热图分析

加载并绘制 `predicted_aligned_error`：

```python
pae = np.array(data["predicted_aligned_error"])
sns.heatmap(pae, cmap="viridis")
plt.title(f"{base_name} PAE")
plt.xlabel("Residue")
plt.ylabel("Residue")
plt.tight_layout()
plt.savefig(pae_png_path, dpi=300)
```

- 🔵 深色区域：高置信度（低误差）
- 🔴 浅色区域：低置信度（高误差），可能为柔性区或错误折叠

---

## 📦 输出示例

| 类型 | 文件名 | 说明 |
|------|--------|------|
| PDB 结构 | [query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000.pdb](file://c:\Users\admin\Desktop\ColabFold_demo\results_single\output\query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000.pdb) | 预测的三维坐标 |
| PAE JSON | `query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_predicted_aligned_error_v1.json` | 预测误差矩阵 |
| PDB 图片 | `visualization/query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_pdb.png` | 3D 结构截图 |
| PAE 图片 | `visualization/query1_unrelaxed_rank_001_alphafold2_ptm_model_1_seed_000_pae.png` | 热图截图 |

---

## 🧠 扩展建议

| 方向 | 建议 |
|------|------|
| ✅ 多序列预测 | 修改 `queries` 列表支持多个蛋白 |
| ✅ 添加 pLDDT 分析 | 加载 `predicted_lddt` 字段绘制置信度图 |
| ✅ 结构松弛 | 使用 [relax.py](file://c:\Users\admin\Desktop\ColabFold_demo\ColabFold\colabfold\relax.py) 对未松弛结构进行优化 |
| ✅ 与实验结构比对 | 使用 `rmsd` 或 `superpose` 工具对比真实结构 |
| ✅ 集成 Gradio UI | 构建 Web 界面供非技术人员使用 |

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
```
