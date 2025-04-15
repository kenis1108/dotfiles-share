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

class FileChangeHandler(PatternMatchingEventHandler):
    def __init__(self, watch_path, target_path):
        # 设置要忽略的模式
        patterns = ["*"]  # 监听所有文件
        ignore_patterns = [".git/*", ".git/**/*"]  # 忽略 .git 目录及其所有内容
        ignore_directories = True  # 忽略目录事件
        case_sensitive = True
        super().__init__(
            patterns=patterns,
            ignore_patterns=ignore_patterns,
            ignore_directories=ignore_directories,
            case_sensitive=case_sensitive
        )
        self.watch_path = watch_path
        self.target_path = target_path

    def copy_directory(self):
        try:
            # 确保目标目录存在
            self.target_path.mkdir(parents=True, exist_ok=True)
            
            # 复制除 .git 外的所有文件和目录
            for item in self.watch_path.iterdir():
                if item.name == '.git':
                    continue
                    
                target_item = self.target_path / item.name
                
                if item.is_file():
                    # 如果是文件，直接复制
                    shutil.copy2(str(item), str(target_item))
                elif item.is_dir():
                    # 如果是目录，递归复制
                    if target_item.exists():
                        shutil.rmtree(target_item)
                    shutil.copytree(str(item), str(target_item), 
                                  ignore=shutil.ignore_patterns('.git', '.git/*', '.git/**/*'))
            
            logger.info(f"目录已复制到: {self.target_path}")
        except Exception as e:
            logger.error(f"复制目录时出错: {e}")

    def on_modified(self, event):
        if not event.is_directory:
            logger.info(f"文件被修改: {event.src_path}")
            self.copy_directory()

    def on_created(self, event):
        if not event.is_directory:
            logger.info(f"新文件创建: {event.src_path}")
            self.copy_directory()

    def on_deleted(self, event):
        if not event.is_directory:
            logger.info(f"文件被删除: {event.src_path}")
            self.copy_directory()

    def on_moved(self, event):
        if not event.is_directory:
            logger.info(f"文件移动: {event.src_path} -> {event.dest_path}")
            self.copy_directory()

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
            # 初始复制一次
            FileChangeHandler(watch_path, target_path).copy_directory()
        
        logger.info("已排除 .git 目录的监听和复制")
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