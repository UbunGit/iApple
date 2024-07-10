import sqlite3
from sqlite3 import Cursor
from pydantic import BaseModel
from typing import Union

def tojson(cursor):
    rows = cursor.fetchall()
    # 获取列名
    column_names = [description[0] for description in cursor.description]
    # 将结果转化为字典
    dict_rows = [dict(zip(column_names, row)) for row in rows]
    return dict_rows

class ReqFeach(BaseModel):
    name: str
    predicate: Union[str, None] = None

def feach(name:str,predicate:str,zone = "defual"):
    connect = sqlite3.connect(f'./{zone}.db')
    cursor = connect.cursor()
    sql = f'''
    select * from {name} 
    '''
    if predicate is not None:
        sql += " where " + predicate
    cursor.execute(sql)
    json_data = tojson(cursor)
    cursor.close()
    return json_data