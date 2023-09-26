import tkinter as tk
from tkinter import ttk
import pyautogui
import time


# interval = <time taken between registering the keys>
def type_text(text):
    pyautogui.typewrite(text, interval=0.02)

def get_input_and_type():
    text = input_text.get("1.0", "end-1c")  # Get the text from the Text widget
    if text:
        time.sleep(5)  # Pause for 5 seconds
        type_text(text)

root = tk.Tk()
root.title("Text Typer")
root.geometry("400x250")  # Adjust the window size for vertical orientation
root.configure(bg="#4B0082")  # Set the background color to a dark purple (#4B0082)

# Create a canvas with a dark purple background
canvas = tk.Canvas(root, background="#4B0082")
canvas.pack(fill="both", expand=True)

# Create a top frame for text input
top_frame = ttk.Frame(canvas, style='Background.TFrame')  # Use a custom style for background color
top_frame.pack(fill="both", expand=True)

# Define a custom style for background color
style = ttk.Style()
style.configure('Background.TFrame', background='#4B0082')

# Top side: Text input
input_label = ttk.Label(top_frame, text="Enter text:", background="#4B0082", foreground="white")
input_label.pack()

# Use a Text widget for input
input_text = tk.Text(top_frame, width=40, height=10)  # Adjust width and height as needed
input_text.pack(pady=10)  # Add some vertical padding

type_button = ttk.Button(top_frame, text="Type Text", command=get_input_and_type)
type_button.pack()

root.mainloop()
