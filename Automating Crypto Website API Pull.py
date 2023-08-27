#!/usr/bin/env python
# coding: utf-8

# In[29]:


from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json


# In[30]:


from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json

url = 'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
parameters = {
  'start':'1',
  'limit':'15',
  'convert':'USD'
}
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c',
}

session = Session()
session.headers.update(headers)

try:
  response = session.get(url, params=parameters)
  data = json.loads(response.text)
  print(data)
except (ConnectionError, Timeout, TooManyRedirects) as e:
  print(e)


# In[31]:


type(data)


# In[32]:


import pandas as pd

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows, None')


# In[33]:


df = pd.json_normalize(data['data'])
df['timestamp'] = pd.to_datetime('now')
df


# In[42]:


def api_runner():
    global df
    url = 'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
    parameters = {
      'start':'1',
      'limit':'15',
      'convert':'USD'
    }
    headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c',
    }

    session = Session()
    session.headers.update(headers)

    try:
      response = session.get(url, params=parameters)
      data = json.loads(response.text)
      #print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
      print(e)
    
    df = pd.json_normalize(data['data'])
    df['timestamp'] = pd.to_datetime('now')
    df
    
    if not os.path.isfile(r'C:\Users\david\OneDrive\Documents\Data Analytics\API.csv'):
        df.to_csv(r'C:\Users\david\OneDrive\Documents\Data Analytics\API.csv', header = 'column_names')
    else:
        df.to_csv(r'C:\Users\david\OneDrive\Documents\Data Analytics\API.csv', mode = 'a', header=False)


# In[45]:


import os
from time import time
from time import sleep

for i in range(333): #333 runs per day
    api_runner()
    print('API Runner completed successfully')
    sleep(60) #sleep for 1 minute
exit()


# In[46]:





# In[54]:


df = pd.read_csv(r'C:\Users\david\OneDrive\Documents\Data Analytics\API.csv')
df


# In[48]:


pd.set_option('display.float_format',lambda x: '%.5f' % x)


# In[55]:


df


# In[57]:


df3 = df.groupby('name', sort = False)[['quote.USD.percent_change_1h','quote.USD.percent_change_24h','quote.USD.percent_change_7d']].mean()
df3


# In[58]:


df4 = df3.stack()
df4


# In[59]:


type(df4)


# In[64]:


df5 = df4.to_frame(name='values')
df5


# In[65]:


df5.count()


# In[69]:


pd.Index(range(150))

df6 = df5.reset_index()
df6


# In[91]:


df7 = df6.rename(columns={'level_1': 'percent_change'})
df7=df7.head(30)
df7


# In[92]:


df7['percent_change']=df7['percent_change'].replace(['quote.USD.percent_change_1h'],['1h'])
df7['percent_change']=df7['percent_change'].replace(['quote.USD.percent_change_24h'],['24h'])
df7['percent_change']=df7['percent_change'].replace(['quote.USD.percent_change_7d'],['7d'])


# In[93]:


import seaborn as sns
import matplotlib.pyplot as plt


# In[94]:


sns.catplot(x='percent_change',y='values', hue='name',data=df7,kind='point')


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




