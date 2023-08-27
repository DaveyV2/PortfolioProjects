#!/usr/bin/env python
# coding: utf-8

# In[25]:


import os, shutil


# In[22]:


path = r"C:/Users/david/OneDrive/Documents/Professional/Business/Docs/"


# In[23]:


file_name = os.listdir(path)


# In[26]:


folder_names = ['pdf files', 'text files', "image files"]

for loop in range (0,3):
    if not os.path.exists(path + folder_names[loop]):
        print((path + folder_names[loop]))
        os.makedirs(path + folder_names[loop])
for file in file_name:
    if ".pdf" in file and not os.path.exists(path + "pdf files/" + file):
        shutil.move(path + file, path + "pdf files/" + file)
    elif ".png" in file and not os.path.exists(path + "image files/" + file):
        shutil.move(path + file, path + "image files/" + file)
    elif ".txt" in file and not os.path.exists(path + "text files/" + file):
        shutil.move(path + file, path + "text files/" + file)
    elif ".docx" in file and not os.path.exists(path + "text files/" + file):
        shutil.move(path + file, path + "text files/" + file)


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




