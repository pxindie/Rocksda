#pannel.py
import tkinter as tk
def say():
    print(0)

class Panel(tk.Tk):
    
    def __init__(self,name,x,y):
        super().__init__()
        self.x = x
        self.y = y
        self.title = name
        self.bg = 25

        self.wm_protocol('WM_DELETE_WINDOW',self.çıkış)

        self.tag = tk.Label(text = 'DepTog Giriş Erkanı').pack()
        self.geometry(f'{x}x{y}')


    def say(self):
        print(0)

    def çıkış(self):
        self.destroy
        exit()

        
    
