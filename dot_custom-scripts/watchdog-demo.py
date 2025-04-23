import time
import shutil
import os
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from pathlib import Path
from loguru import logger
import sys

# 配置日志输出
logger.remove()  # 移除默认的处理器
logger.add(
    sys.stdout,
    format="<green>{time:YYYY-MM-DD HH:mm:ss.SSS}</green> | <level>{level: <8}</level> | <cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - <level>{message}</level>",
    level="INFO"
)

def execute_post_sync_command(command, directory):
    """执行文件同步后的系统命令
    Args:
        command: 要执行的系统命令
        directory: 命令执行的工作目录
    """
    try:
        logger.info(f"在目录 {directory} 中执行命令: {command}")
        os.chdir(directory)
        os.system(command)
    except Exception as e:
        logger.error(f"执行命令时出错: {e}")

class FileChangeHandler(PatternMatchingEventHandler):
    def __init__(self, watch_path, target_path):
        # 设置要忽略的模式
        patterns = ["*"]  # 监听所有文件
        ignore_patterns = [".git/*", ".git/**/*", "**/.git/*", "**/.git/**/*"]  # 忽略所有 .git 目录及其内容
        ignore_directories = False  # 允许监听目录事件
        case_sensitive = True
        super().__init__(
            patterns=patterns,
            ignore_patterns=ignore_patterns,
            ignore_directories=ignore_directories,
            case_sensitive=case_sensitive
        )
        self.watch_path = watch_path
        self.target_path = target_path
        self.last_copy_time = 0  # 上次复制的时间戳
        self.copy_cooldown = 0.5  # 复制冷却时间（秒）

    def should_ignore(self, path, names=None):
        """检查路径是否应该被忽略
        Args:
            path: 要检查的路径
            names: 可选参数，用于 shutil.copytree 的 ignore 函数
        """
        if names is not None:
            # 用于 shutil.copytree 的 ignore 函数
            return [name for name in names if '.git' in name]
        
        # 用于普通路径检查
        path_str = str(path)
        return '.git' in path_str.split(os.sep)

    def copy_file(self, src_path, event_type):
        """复制单个文件
        Args:
            src_path: 源文件路径
            event_type: 事件类型（modified/created/moved）
        """
        current_time = time.time()
        # 检查是否在冷却时间内
        if current_time - self.last_copy_time < self.copy_cooldown:
            return

        try:
            # 计算目标文件路径
            relative_path = Path(src_path).relative_to(self.watch_path)
            target_file = self.target_path / relative_path
            
            # 确保目标目录存在
            target_file.parent.mkdir(parents=True, exist_ok=True)
            
            if event_type == 'deleted':
                # 如果是删除事件，删除目标文件
                if target_file.exists():
                    target_file.unlink()
                    logger.info(f"文件已删除: {target_file}")
            else:
                # 复制文件
                shutil.copy2(src_path, str(target_file))
                logger.info(f"文件已复制: {target_file}")
            
            self.last_copy_time = current_time

            # 在文件同步完成后执行命令（仅对特定目录）
            if str(self.watch_path) == "E:/shared/source":
                execute_post_sync_command("npm run lint", str(self.watch_path))
        except Exception as e:
            logger.error(f"处理文件时出错: {e}")

    def on_modified(self, event):
        if not self.should_ignore(Path(event.src_path)):
            logger.info(f"文件被修改: {event.src_path}")
            self.copy_file(event.src_path, 'modified')

    def on_created(self, event):
        if not self.should_ignore(Path(event.src_path)):
            logger.info(f"新文件创建: {event.src_path}")
            self.copy_file(event.src_path, 'created')

    def on_deleted(self, event):
        if not self.should_ignore(Path(event.src_path)):
            logger.info(f"文件被删除: {event.src_path}")
            self.copy_file(event.src_path, 'deleted')

    def on_moved(self, event):
        if not self.should_ignore(Path(event.src_path)):
            logger.info(f"文件移动: {event.src_path} -> {event.dest_path}")
            # 先删除源文件
            self.copy_file(event.src_path, 'deleted')
            # 再复制新文件
            self.copy_file(event.dest_path, 'moved')

def watch_directory(watch_path, target_path):
    event_handler = FileChangeHandler(watch_path, target_path)
    observer = Observer()
    # 监听整个目录及其子目录
    observer.schedule(event_handler, path=str(watch_path), recursive=True)
    observer.start()
    return observer

def main():
    # 配置监听目录和目标目录的对应关系
    # 格式: {监听目录: 目标目录}
    watch_config = {
        Path("E:/shared/source"): Path("Z:/hjh/source"),
        Path("C:/Users/twm/.local/share/chezmoi"): Path("Z:/hjh/chezmoi"),
        # 添加更多目录对应关系
        # Path("源目录路径"): Path("目标目录路径"),
    }
    
    observers = []
    try:
        for watch_path, target_path in watch_config.items():
            logger.info(f"开始监听目录: {watch_path}")
            logger.info(f"变化将同步到: {target_path}")
            observer = watch_directory(watch_path, target_path)
            observers.append(observer)
        
        logger.info("已排除所有 .git 目录的监听和复制")
        logger.info("所有目录监听已启动，按 Ctrl+C 停止")
        
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        for observer in observers:
            observer.stop()
            observer.join()
        logger.info("停止所有监听")

if __name__ == "__main__":
    main()