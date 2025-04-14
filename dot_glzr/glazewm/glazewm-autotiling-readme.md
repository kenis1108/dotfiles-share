# 由于 glazewm 原生还没实现 autotiling,所以使用 python 脚本实现

感谢大佬[https://github.com/burgr033/GlazeWM-autotiling-python](https://github.com/burgr033/GlazeWM-autotiling-python)

创建 venv

```powershell
uv venv
```

进入 venv

```powershell
.venv\Scripts\activate
```

安装依赖

```powershell
uv pip install websockets
```

执行脚本, 保持运行着就可以了

```powershell
uv run .\glazewm-autotiling.py
```
