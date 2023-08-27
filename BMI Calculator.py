#!/usr/bin/env python
# coding: utf-8

# In[16]:


first_name = input("Enter your first name: ")

weight = int(input("Enter your weight in pounds: "))

height = int(input("Enter your height in inches: "))


BMI = (weight * 703) / (height**2)
print(BMI)

if BMI>0:
    if (BMI) < 18.5:
        print(first_name + ", You are underweight.")
    elif (BMI) <= 24.9:
        print(first_name + ", You are normal weight.")
    elif (BMI) <= 29.9:
        print(first_name + ", You are Overweight.")
    elif (BMI) <= 34.9:
        print(first_name + ", You are Obese.")
    elif (BMI) <= 39.9:
        print(first_name +", You are Severely Obese.")
    else:
        print(first_name + ", You are Morbidly Obese.")
else:
    print("Enter valid input.")


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





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




