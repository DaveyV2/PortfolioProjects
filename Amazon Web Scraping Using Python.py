#!/usr/bin/env python
# coding: utf-8

# In[31]:


from bs4 import BeautifulSoup
import requests
import smtplib
import time
import datetime


# In[58]:


URL = "https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ/ref=sr_1_3?crid=PKD3KUPUDHME&keywords=got+data&qid=1693074657&sprefix=got+data%2Caps%2C96&sr=8-3"

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0", "X-Amzn-Trace-Id": "Root=1-64ea45fa-67783cc431ee0ec16b39194f"}

page = requests.get(URL, headers=headers)

soup1 = BeautifulSoup(page.content, "html.parser")


soup2 = BeautifulSoup(soup1.prettify(),"html.parser")

title = soup2.find(id='productTitle').get_text()

price = soup2.find(id='priceblock_ourprice').get_text()

print(title)
print(price)


# In[59]:


price = price.strip()[1:]
title = title.strip()

print(title)
print(price)


# In[60]:


import datetime

today = datetime.date.today()

print(today)


# In[61]:


import csv 

header = ['Title', 'Price', 'Date']
data = [title, price, today]


with open('AmazonWebScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)
    


# In[62]:


import pandas as pd

df = pd.read_csv(r'C:\Users\alexf\AmazonWebScraperDataset.csv')

print(df)


# In[63]:


with open('AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(data)


# In[64]:


while(True):
    check_price()
    time.sleep(86400)


# In[65]:


import pandas as pd

df = pd.read_csv(r'C:\Users\alexf\AmazonWebScraperDataset.csv')

print(df)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




