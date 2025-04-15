import time
import shutil
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from pathlib import Path

class FileChangeHandler(FileSystemEventHandler):
    def __init__(self, source_file, target_file):
        self.source_file = source_file
        self.target_file = target_file
        super().__init__()

    def on_modified(self, event):
        if not event.is_directory and Path(event.src_path) == self.source_file:
            print(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - 文件被修改: {event.src_path}")
            self.copy_file_content()

    def on_created(self, event):
        if not event.is_directory:
            print(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - 新文件创建: {event.src_path}")

    def on_deleted(self, event):
        if not event.is_directory:
            print(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - 文件被删除: {event.src_path}")

    def copy_file_content(self):
        try:
            shutil.copy2(str(self.source_file), str(self.target_file))
            print(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - 文件内容已复制到: {self.target_file}")
        except Exception as e:
            print(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - 复制文件时出错: {e}")

def watch_file(source_file, target_file):
    # 确保目标目录存在
    target_file.parent.mkdir(parents=True, exist_ok=True)
    
    event_handler = FileChangeHandler(source_file, target_file)
    observer = Observer()
    # 监听文件所在目录
    observer.schedule(event_handler, path=str(source_file.parent), recursive=False)
    observer.start()
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == "__main__":
    source_path = Path("E:/shared/demo/DeviceList.vue")  # 要监听的文件
    target_path = Path("Z:/hjh/temporary.txt")          # 要复制到的目标文件
    
    print(f"开始监听文件: {source_path}")
    print(f"修改内容将复制到: {target_path}")
    
    watch_file(source_path, target_path)