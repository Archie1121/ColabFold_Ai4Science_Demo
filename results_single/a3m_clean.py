# a3m_fix.py
import sys

def fix_a3m(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = [line.rstrip('\n') for line in f]

    sequences = []
    descriptions = []
    current_seq = ""
    max_len = 0

    for line in lines:
        if line.startswith('>'):
            if current_seq:
                sequences.append(current_seq)
                max_len = max(max_len, len(current_seq))
                current_seq = ""
            descriptions.append(line)
        else:
            current_seq += line
    if current_seq:
        sequences.append(current_seq)
        max_len = max(max_len, len(current_seq))

    # 补齐长度
    fixed_sequences = []
    for i, seq in enumerate(sequences):
        # query 序列不能有 gap
        if i == 0:
            seq = seq.replace('-', '')
            if len(seq) < max_len:
                seq += 'A' * (max_len - len(seq))  # 随机用 A 补齐
        else:
            if len(seq) < max_len:
                seq += '-' * (max_len - len(seq))
        fixed_sequences.append(seq)

    # 写入新文件
    with open(output_file, 'w') as f:
        for desc, seq in zip(descriptions, fixed_sequences):
            f.write(desc + '\n')
            f.write(seq + '\n')

    print(f"修复完成，结果保存到 {output_file}")
    print(f"每条序列长度统一为 {max_len}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("用法: python3 a3m_fix.py input.a3m output.a3m")
    else:
        fix_a3m(sys.argv[1], sys.argv[2])
