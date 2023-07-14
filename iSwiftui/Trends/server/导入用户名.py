import csv
import sqlite3

connection = sqlite3.connect('/Users/mac/Documents/gitee/iApple/iSwiftui/Trends/server/defual.db')
cursor = connection.cursor()
with open('/Users/mac/Documents/gitee/i-data/text/中文用户名.txt', 'r') as file:
    reader = csv.reader(file)
    for index,row in enumerate(reader):
       
        cs = row[0]
        # 使用适当的SQL插入语句将数据插入到数据库中
        sql = "INSERT INTO member (uuid, nickName) VALUES (?, ?)"
        print(index)
        print(cs)
        cursor.execute(sql, (index, cs))

# 提交更改并关闭数据库连接
connection.commit()
cursor.close()

