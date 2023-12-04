
import sys
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QTextEdit, QProgressBar
from PyQt5.QtCore import QTimer
from PyQt5.QtGui import QPalette, QColor
import pyautogui

class TextTyper(QWidget):
    def __init__(self):
        super().__init__()

        self.initUI()

    def initUI(self):
        self.setWindowTitle('Text Typer')

        self.textEdit = QTextEdit()
        self.button = QPushButton("Type Text")
        self.button.clicked.connect(self.start_timer)

        self.progressBar = QProgressBar()  # Progress bar to show the countdown
        self.progressBar.setMaximum(100)  # Countdown time in seconds
        self.progressBar.setTextVisible(False)  # Don't show the numeric %

        # Change the color from green to grey
        palette = self.progressBar.palette()
        palette.setColor(QPalette.Highlight, QColor('grey'))
        self.progressBar.setPalette(palette)

        vbox = QVBoxLayout()
        vbox.addWidget(self.textEdit)
        vbox.addWidget(self.button)
        vbox.addWidget(self.progressBar)

        self.setLayout(vbox)

    def type_text(self):
        text = self.textEdit.toPlainText()
        if text:
            pyautogui.typewrite(text, interval=0.01)

    def start_timer(self):
        self.countdown = 100  # Countdown time in seconds
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_timer)
        self.timer.start(50)  # Timer ticks every 0.05 second

    def update_timer(self):
        self.progressBar.setValue(self.countdown)
        self.countdown -= 1
        if self.countdown < 0:
            self.timer.stop()
            self.type_text()

def main():
    app = QApplication(sys.argv)
    app.setStyle('Fusion')  # Set the application style to 'Fusion'

    # Apply dark theme
    palette = QPalette()
    palette.setColor(QPalette.Window, QColor(53, 53, 53))
    palette.setColor(QPalette.WindowText, QColor(255, 255, 255))
    palette.setColor(QPalette.Base, QColor(25, 25, 25))
    palette.setColor(QPalette.AlternateBase, QColor(53, 53, 53))
    palette.setColor(QPalette.ToolTipBase, QColor(255, 255, 255))
    palette.setColor(QPalette.ToolTipText, QColor(255, 255, 255))
    palette.setColor(QPalette.Text, QColor(255, 255, 255))
    palette.setColor(QPalette.Button, QColor(53, 53, 53))
    palette.setColor(QPalette.ButtonText, QColor(255, 255, 255))
    palette.setColor(QPalette.BrightText, QColor(255, 0, 0))
    palette.setColor(QPalette.Highlight, QColor(142, 45, 197).lighter())
    palette.setColor(QPalette.HighlightedText, QColor(0, 0, 0))
    app.setPalette(palette)

    ex = TextTyper()
    ex.show()

    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
