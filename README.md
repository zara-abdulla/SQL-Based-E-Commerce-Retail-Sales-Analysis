# SQL-Based E-Commerce Retail Sales Analysis

![](/images/sales_project.png) 

## 📌 Project Overview  
This project focuses on analyzing e-commerce retail sales data using **Oracle SQL**, with results visualized in **Excel** and presented in **PowerPoint**.  
The goal is to explore customer behavior, product performance, revenue trends, discounts, and return patterns to generate actionable business insights.

---

## 🔗 Files & Resources
- 📽️ Presentation (PDF): [View Presentation](presentation/Sales_Presentation.pdf)
- 🧾 Full Analysis SQL Script: [View SQL File](sql_queries/Sales_Project.sql)
- 📂 Dataset: [View dataset](/data/)  

---

## 🎯 Objectives  
- Analyze e-commerce sales data using SQL  
- Understand customer purchasing behavior and product performance  
- Identify revenue, profit, and sales trends  
- Evaluate the impact of discounts, payment methods, and returns  
- Visualize results in Excel and summarize insights in a presentation  

---


## 🗂️ Database Schema  

### **CUSTOMERS**
| Column | Description |
|--------|-------------|
| customer_id | Unique customer ID |
| full_name | Customer name |
| gender | Gender (Male/Female) |
| age | Customer age |
| city | Customer city |
| registration_date | Registration date |

### **PRODUCTS**
| Column | Description |
|--------|-------------|
| product_id | Product ID |
| product_name | Product name |
| category | Product category |
| unit_price | Selling price |
| cost_price | Cost price |

### **ORDERS**
| Column | Description |
|--------|-------------|
| order_id | Order ID |
| customer_id | Customer ID (FK) |
| order_date | Order date |
| payment_method | Payment method |
| status | Order status (Completed, Cancelled, Returned) |

### **ORDER_DETAILS**
| Column | Description |
|--------|-------------|
| order_id | Order ID (FK) |
| product_id | Product ID (FK) |
| quantity | Quantity sold |
| discount | Discount amount |

### **RETURNS**
| Column | Description |
|--------|-------------|
| return_id | Return ID |
| order_id | Order ID (FK) |
| product_id | Product ID |
| return_date | Return date |
| reason | Return reason |


---

## 📈 Analysis Tasks  

### **I. Sales Performance**
1. Calculate total sales revenue (unit_price × quantity − discount)  
2. Monthly sales revenue and order count  
3. Revenue, cost, and profit per product  
4. Top 5 products by revenue  
5. Top 5 customers by total spending  
6. Sales and order distribution by city  

---

### **II. Discount & Payment Analysis**
7. Analyze impact of discounts on sales (discounted vs non-discounted orders)  
8. Sales distribution by payment method  
9. Ratio of completed vs cancelled orders  

---

### **III. Return Analysis**
10. Return rate (number of returns / total orders)  
11. Most returned products and categories  
12. Distribution of return reasons  

---

### **IV. Bonus Analysis**
- Average profit margin by category  
- Sales share by customer age groups  
- Year-over-year sales growth (2023 vs 2024)  


---

## 📊 Excel Visualization  
SQL results were exported to Excel and analyzed using Pivot Tables and charts:

#### Monthly sales trend 
-  [Monthly sales query](/sql_queries/query_1.sql) 
- 📊 Chart: ![](/images/image_2.png)  

#### Top 5 products and customers 
 - [top 5 product query](/sql_queries/query_2.sql) 
- [top 5 customer query](/sql_queries/query_3.sql) 

- 📊 Chart 1: ![](/images/image_3.png)  
- 📊 Chart 2: ![](/images/image_4.png)  


#### Return rate visualization  
-  [Return rate query](/sql_queries/query_4.sql) 
- 📊 Chart: ![](/images/image_5.png)  

#### Payment method distribution
-  [Payment method query](/sql_queries/query_5.sql) 
- 📊 Chart: ![](/images/image_6.png) 

---


## 🚀 Key Insights 
 - **July, August, and September** recorded the highest sales volume and order counts.  
- Sales and order trends move in the same direction, indicating strong demand-driven purchasing behavior.  
- A small group of customers generates a disproportionate share of total orders, confirming the presence of high-value customers.  
- **Home** and **Toys** categories are among the top revenue drivers.  
- **Cash** is the most frequently used payment method (35%).  
- **Bank transfer** accounts for 34% of payments.  
- **Card payments** represent 31% of total orders.  
- The overall **return rate is 17.6%**, which indicates a moderate level of post-purchase dissatisfaction or logistics issues.  


---
## 🛠️ Tools & Technologies  
- **SQL (Oracle SQL Developer)**  
- **Microsoft Excel (Pivot Tables & Charts)**  
- **Microsoft PowerPoint**  
