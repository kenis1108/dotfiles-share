import time
import shutil
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
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

class FileChangeHandler(FileSystemEventHandler):
    def __init__(self, watch_path, target_path):
        self.watch_path = watch_path
        self.target_path = target_path
        super().__init__()

    def copy_directory(self):
        try:
            # 如果目标目录存在，先删除它
            if self.target_path.exists():
                shutil.rmtree(self.target_path)
            # 复制整个目录
            shutil.copytree(self.watch_path, self.target_path)
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
    
    try:
        logger.info(f"开始监听目录: {watch_path}")
        logger.info(f"变化将同步到: {target_path}")
        # 初始复制一次
        event_handler.copy_directory()
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
        logger.info("停止监听")
    observer.join()

if __name__ == "__main__":
    # 要监听的目录路径
    watch_path = Path("E:/shared/source")
    # 目标目录路径
    target_path = Path("Z:/hjh/source")
    watch_directory(watch_path, target_path)