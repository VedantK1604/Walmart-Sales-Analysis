<h1>Walmart Sales Analysis</h1>

<p>This is the SQL based data analysis project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of different products, customer behaviour. The aim is to study how sales strategies can be improved and optimized.</p>

<h2> Analysis List</h2>

<ul>
  <li><b>Product Analysis:</b> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.</li><br>
  <li><b>Sales Analysis:</b> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.</li><br>
  <li><b>Customer Analysis:</b> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.</li>
</ul>

<h2>Approach Used</h2>

<ol>
  <li><b>Data Wrangling:</b> This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
    <ul>
      <li>Build a database.</li>
      <li>Create table and insert the data.</li>
    </ul>
  </li><br>
  <li><b>Feature Engineering: </b>This will help use generate some new columns from existing ones.</li>
    <ul>
      <li>Add a new column named <i>time_of_day</i> to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.</li>
      <li>Add a new column named <i>day_name</i> that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.</li>
      <li>Add a new column named <i>month_name</i> that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.</li>
    </ul><br>
  <li><b>Exploratory Data Analysis (EDA):</b> Exploratory data analysis is done to answer the listed questions and aims of this project.</li>
</ol>

<p></p>
