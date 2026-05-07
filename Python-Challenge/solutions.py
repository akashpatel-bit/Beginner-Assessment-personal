import pandas as pd

clean_data = []
with open('sales_data.csv', 'r') as f:
    header = f.readline() 
    for line in f:
        parts = line.strip().split(',')
        if len(parts) < 6: continue 
        
        # first 4 column fix
        order_id = parts[0]
        product = parts[1]
        qty = parts[2]
        price = parts[3]
        date = parts[4]
        # remaining parts of address joined using commas
        address = ",".join(parts[5:])
        
        clean_data.append([order_id, product, qty, price, date, address])

# dataframe
df = pd.DataFrame(clean_data, columns=['Order ID', 'Product', 'Quantity Ordered', 'Price Each', 'Order Date', 'Purchase Address'])

# mean and numeric conversion
df['Quantity Ordered'] = pd.to_numeric(df['Quantity Ordered'], errors='coerce')
df['Price Each'] = pd.to_numeric(df['Price Each'], errors='coerce')
df['Price Each'] = df['Price Each'].fillna(df.groupby('Product')['Price Each'].transform('mean'))
df['Order Date'] = pd.to_datetime(df['Order Date'], errors='coerce', format='mixed')
df.dropna(subset=['Order Date'], inplace=True)

#extracting the month
df['Total Sales'] = df['Quantity Ordered'] * df['Price Each']
df['Month'] = df['Order Date'].dt.to_period('M').astype(str)

print("--- Output 2 (Manual Load) ---")
print(df.groupby('Month')['Total Sales'].sum())

df.to_csv("cleaned_sales.csv", index=False)
# Best Selling Product 
best_selling_df = df.groupby(['Month', 'Product'])['Quantity Ordered'].sum().reset_index()

# sorting based on quantity
best_selling_product = (
    best_selling_df.sort_values(['Month', 'Quantity Ordered'], ascending=[True, False])
    .drop_duplicates(['Month'])
    .set_index('Month')['Product']
)

print("Best Selling Product Per Month")
print(best_selling_product)

print(df.head())