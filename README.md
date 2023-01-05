# Mobile App (iOS) Analysis 
![download](https://user-images.githubusercontent.com/117702329/210484905-055a6a83-a9e6-4234-82e0-712237f97c4a.jpg)


## Statistics 
1. According to [Apple](https://www.apple.com/app-store/#:~:text=Because%20we%20offer%20nearly%20two,every%20single%20one%20of%20them.), there are nearly **2 million** apps in [App Store](https://www.apple.com/app-store/). 

2. There are over **1.2 billion** iPhone users worldwide, and the market share in **North America** is more than **50%** ([Source](https://www.demandsage.com/iphone-user-statistics/#:~:text=Key%20iPhone%20Statistics%20(2023),were%20sold%20in%20Q1%202022.)).

3. As of Q2 2022, the number of app downloads is **8.2 billion** ([Source](https://www.statista.com/topics/9757/apple-app-store/#topicOverview)).


## Motivation 
- Scenario: Developing your own app and have it available on App Store

1. Understand the iOS market to identify trends and competitions 
      - Number of apps by genre
      - Free vs Paid app statistics
      - Number and kinds of content offered (e.g. 4+ to 18+) 
      - Average statistics of number of devices and languages supported and number of screenshots shown for display

2. Understand the top trending apps and genres 
      - App average rating and total number of ratings 
      - Quality of apps (e.g. Ratio of free and paid apps that has a rating of 4)


## Project Details
1. Tool: PostgreSQL 

2. Dataset downloaded from [Kaggle](https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps)

   - 7,197 rows
   - 15 columns ([Column Details](https://github.com/harris-wan-analyst/mobile_iOS_apps/blob/main/column_details.md))
   - data type: numeric & varchar 
   
3. Tableau ([link](https://public.tableau.com/app/profile/harris.wan.analyst/viz/MobileAppDashboard_16726880309640/MobileAppiOSAnalysis))


## Key Findings 

1. iOS Market Analysis 
   - Total number of genres available: **23**
   
   - More than half (**53.66 %**) of the apps belong to the Games genre, followed by Entertainment (**7.43 %**) and Education (**6.29 %**)
   
   - There are more free apps (**56.36 %**) compared to paid apps (**43.64 %**)
   
   - Top 3 most common pricing for paid apps: 
        - 0.99 (**10.12 %**)
        - 2.99 (**9.49 %**)
        - 1.99 (**8.63%**)
        
   - There are 4 types of contents offered:
        - 4+ (**61.60 %**)
        - 9+ (**13.71 %**)
        - 12+ (**16.05 %**)
        - 17+ (**8.64 %**)
   
   - Avergage statistics for iOS apps:
        - Number of devices supported: **37**
        - Number of languages supported: **5**
        - Number of screenshots shown: **3**

2. Trending apps and genres by rating 

    - The average user rating of all iOS apps is **3.527**

    - Top 3 genres with highest ratings:
        - Productivity: **4.281** (Rank **12th** in total number of ratings)
        - Music: **4.261** (Rank **5th** in total number of ratings)
        - Photo & Video: **4.092** (Rank **3rd** in total number of ratings)

    - Example of trending apps (ratings in **4** & **5**): 
        - Pythonista 3 (Productivity)
        - Pandora - Music & Radio (Music)  
        - Meitu (Photo & Video)

    - Top 3 genres with lowest ratings:
        - Catalogs: **2.200** (Rank **22nd** in total number of ratings)
        - Book: **2.643** (Rank **19th** in total number of ratings)
        - Finance: **2.654** (Rank **13th** in total number of ratings)

3. Quality of apps (free apps vs paid apps)

    - Most free apps (**72.44 %**) do not have any ratings (**0**)
    
    - Both free and paid apps have similar app count for ratings **1** and **2** 

    - Free apps have higher app count than paid apps for ratings **3** to **5**

## Recommendations

- Key: Understand the type of app you want to create and genre it belongs then do the following: 

1. Understand customer preferences overtime
   - e.g. number of installs per app and genre / google trends 

2. Finding niches in the market
   - Idea 1: Develop a paid app with competitive pricing 
      - paid apps have relatively lower ratings to free apps 
      
   - Idea 2: Develop a high quality app in areas with less competition and lower ratings 
      - e.g. Finance genre only has 104 apps available and an average rating of 2.654

3. Dive deep into top trending apps of your interest 
   - 5Ws (Who, What, Where, When, Why) 
   
